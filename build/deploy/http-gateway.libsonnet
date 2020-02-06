local base = import 'base.libsonnet';

local ingress(metadata) = base.Ingress(metadata, 'https-ingress') {
  metadata+: {
    annotations: {
      'kubernetes.io/ingress.global-static-ip-name': metadata.gateway.ipName,
      'kubernetes.io/ingress.allow-http': 'false',
    },
  },
  spec: {
    backend: {
      serviceName: 'http-gateway',
      servicePort: metadata.gateway.port,
    },
  },
};

{
  ManagedCertIngress(metadata): {
    ingress: ingress(metadata) {
      metadata+: {
        annotations+: {
          'networking.gke.io/managed-certificates': 'https-certificate',
        },
      },
    },
    managedCert: base.ManagedCert(metadata, 'https-certificate') {
      spec: {
        domains: [
          metadata.gateway.hostname,
        ],
      },
    },
  },
  
  PresharedCertIngress(metadata, certName): ingress(metadata) {
    metadata+: {
      annotations+: {
        'ingress.gcp.kubernetes.io/pre-shared-cert': certName,
      },
    },
  },


  all(metadata): {
    # ingress: if metadata.enable_istio then {
    #   apiVersion: 'networking.istio.io/v1alpha3',
    #   kind: 'Gateway',
    #   metadata: {
    #     name: 'http-gateway',
    #   },
    #   spec: {
    #     selector: {
    #       istio: 'ingressgateway',
    #     },
    #     servers: [
    #       {
    #         port: {
    #           number: metadata.gateway.port,
    #           name: 'https',
    #           protocol: 'HTTPS',
    #         },
    #         hosts: [
    #           metadata.gateway.hostname,
    #         ],
    #         tls: {
    #           mode: 'SIMPLE',
    #           serverCertificate: '/etc/certs/servercert.pem',
    #           privateKey: '/etc/certs/privatekey.pem',
    #         },
    #       },
    #     ],
    #   },
    # } else $.ManagedCertIngress(metadata),

    virtual_service: if metadata.enable_istio then {
      apiVersion: 'networking.istio.io/v1alpha3',
      kind: 'VirtualService',
      metadata: {
        name: 'http-gateway',
      },
      spec: {
        hosts: [
          metadata.gateway.hostname,
        ],
        gateways: [
          'ingressgateway',
        ],
        tls: [
          {
            match: [
              {
                sniHosts: [
                  'spiffe-big-1.interussplatform.dev',
                ],
              },
            ],
            route: [
              {
                destination: {
                  port: {
                    number: metadata.gateway.port,
                  },
                  host: 'http-gateway',
                },
              },
            ],
          },
        ],
      },
    },
    service: base.Service(metadata, 'http-gateway') {
      app:: 'http-gateway',
      port:: metadata.gateway.port,
      type:: 'NodePort',
      enable_monitoring:: true,
    },

    deployment: base.Deployment(metadata, 'http-gateway') {
      app:: 'http-gateway',
      metadata+: {
        namespace: metadata.namespace,
      },
      spec+: {
        template+: {
          spec+: {
            soloContainer:: base.Container('http-gateway') {
              image: metadata.gateway.image,
              ports: [
                {
                  containerPort: metadata.gateway.port,
                  name: 'http',
                },
              ],
              args: [
                'http-gateway',
                '-grpc-backend=grpc-backend.' + metadata.namespace + ':' + metadata.backend.port,
                '-addr=:' + metadata.gateway.port,
              ],
              readinessProbe: {
                httpGet: {
                  path: '/healthy',
                  port: metadata.gateway.port,
                },
              },
            },
          },
        },
      },
    },
  },
}
