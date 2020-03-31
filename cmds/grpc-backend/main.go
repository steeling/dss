package main

import (
	"context"
	"flag"
	"net"
	"net/url"
	"strconv"
	"time"

	"cloud.google.com/go/profiler"
	"github.com/interuss/dss/pkg/dss"
	"github.com/interuss/dss/pkg/dss/auth"
	"github.com/interuss/dss/pkg/dss/build"
	"github.com/interuss/dss/pkg/dss/cockroach"
	"github.com/interuss/dss/pkg/dss/validations"
	"github.com/interuss/dss/pkg/dssproto"
	uss_errors "github.com/interuss/dss/pkg/errors"
	"github.com/interuss/dss/pkg/logging"

	"github.com/dpjacques/clockwork"
	grpc_middleware "github.com/grpc-ecosystem/go-grpc-middleware"
	"go.uber.org/zap"
	"google.golang.org/grpc"
	"google.golang.org/grpc/reflection"
)

var (
	address           = flag.String("addr", ":8081", "address")
	pkFile            = flag.String("public_key_file", "", "Path to public Key to use for JWT decoding.")
	jwksEndpoint      = flag.String("jwks_endpoint", "", "URL pointing to an endpoint serving JWKS")
	jwksKeyID         = flag.String("jwks_key_id", "", "ID of a specific key in a JWKS")
	keyRefreshTimeout = flag.Duration("key_refresh_timeout", 1*time.Minute, "Timeout for refreshing keys for JWT verification")
	timeout           = flag.Duration("server timeout", 10*time.Second, "Default timeout for server calls")
	reflectAPI        = flag.Bool("reflect_api", false, "Whether to reflect the API.")
	logFormat         = flag.String("log_format", logging.DefaultFormat, "The log format in {json, console}")
	logLevel          = flag.String("log_level", logging.DefaultLevel.String(), "The log level")
	dumpRequests      = flag.Bool("dump_requests", false, "Log request and response protos")
	profServiceName   = flag.String("gcp_prof_service_name", "", "Service name for the Go profiler")

	cockroachParams = struct {
		host            *string
		port            *int
		sslMode         *string
		sslDir          *string
		user            *string
		applicationName *string
	}{
		host:            flag.String("cockroach_host", "", "cockroach host to connect to"),
		port:            flag.Int("cockroach_port", 26257, "cockroach port to connect to"),
		sslMode:         flag.String("cockroach_ssl_mode", "disable", "cockroach sslmode"),
		user:            flag.String("cockroach_user", "root", "cockroach user to authenticate as"),
		sslDir:          flag.String("cockroach_ssl_dir", "", "directory to ssl certificates. Must contain files: ca.crt, client.<user>.crt, client.<user>.key"),
		applicationName: flag.String("cockroach_application_name", "dss", "application name for tagging the connection to cockroach"),
	}

	jwtAudience = flag.String("jwt_audience", "", "Require that JWTs contain this `aud` claim")
)

// RunGRPCServer starts the example gRPC service.
// "network" and "address" are passed to net.Listen.
func RunGRPCServer(ctx context.Context, address string) error {
	logger := logging.WithValuesFromContext(ctx, logging.Logger)

	if *jwtAudience == "" {
		// TODO: Make this flag required once all parties can set audiences
		// correctly.
		logger.Warn("missing required --jwt_audience")
	}

	l, err := net.Listen("tcp", address)
	if err != nil {
		return err
	}
	defer func() {
		if err := l.Close(); err != nil {
			logger.Error("Failed to close listener", zap.String("address", address), zap.Error(err))
		}
	}()

	uriParams := map[string]string{
		"host":             *cockroachParams.host,
		"port":             strconv.Itoa(*cockroachParams.port),
		"user":             *cockroachParams.user,
		"ssl_mode":         *cockroachParams.sslMode,
		"ssl_dir":          *cockroachParams.sslDir,
		"application_name": *cockroachParams.applicationName,
	}
	uri, err := cockroach.BuildURI(uriParams)
	if err != nil {
		logger.Panic("Failed to build URI", zap.Error(err))
	}

	store, err := cockroach.Dial(uri, logger)
	if err != nil {
		logger.Panic("Failed to open connection to CRDB", zap.String("uri", uri), zap.Error(err))
	}

	if err := store.Bootstrap(ctx); err != nil {
		logger.Panic("Failed to bootstrap CRDB instance", zap.Error(err))
	}

	dssServer := &dss.Server{
		Store:   store,
		Timeout: *timeout,
	}

	var keyResolver auth.KeyResolver
	switch {
	case *pkFile != "":
		keyResolver = &auth.FromFileKeyResolver{
			KeyFile: *pkFile,
		}
	case *jwksEndpoint != "" && *jwksKeyID != "":
		u, err := url.Parse(*jwksEndpoint)
		if err != nil {
			return err
		}

		keyResolver = &auth.JWKSResolver{
			Endpoint: u,
			KeyID:    *jwksKeyID,
		}
	default:
		logger.Warn("operating without authorizing interceptor")
	}

	authorizer, err := auth.NewRSAAuthorizer(
		ctx, auth.Configuration{
			KeyResolver:       keyResolver,
			KeyRefreshTimeout: *keyRefreshTimeout,
			RequiredScopes:    dssServer.AuthScopes(),
			RequiredAudience:  *jwtAudience,
		},
	)
	if err != nil {
		return err
	}

	interceptors := []grpc.UnaryServerInterceptor{
		uss_errors.Interceptor(logger),
		logging.Interceptor(logger),
		authorizer.AuthInterceptor,
		validations.ValidationInterceptor,
	}
	if *dumpRequests {
		interceptors = append(interceptors, logging.DumpRequestResponseInterceptor(logger))
	}

	s := grpc.NewServer(grpc_middleware.WithUnaryServerChain(interceptors...))
	if err != nil {
		return err
	}
	if *reflectAPI {
		reflection.Register(s)
	}

	dssproto.RegisterDiscoveryAndSynchronizationServiceServer(s, dssServer)

	logger.Info("build", zap.Any("description", build.Describe()))

	go func() {
		defer s.GracefulStop()
		<-ctx.Done()
	}()
	return s.Serve(l)
}

func main() {
	flag.Parse()

	if err := logging.Configure(*logLevel, *logFormat); err != nil {
		panic(err)
	}

	var (
		ctx    = context.Background()
		logger = logging.WithValuesFromContext(ctx, logging.Logger)
	)
	if *profServiceName != "" {
		err := profiler.Start(profiler.Config{
			Service: *profServiceName})
		if err != nil {
			logger.Panic("Failed to start the profiler ", zap.Error(err))
		}
	}

	if err := RunGRPCServer(ctx, *address); err != nil {
		logger.Panic("Failed to execute service", zap.Error(err))
	}
	logger.Info("Shutting down gracefully")
}
