{
  "cert-manager-0": {
    "apiVersion": "apiextensions.k8s.io/v1beta1",
    "kind": "CustomResourceDefinition",
    "metadata": {
      "name": "certificaterequests.cert-manager.io"
    },
    "spec": {
      "additionalPrinterColumns": [
        {
          "JSONPath": ".status.conditions[?(@.type==\"Ready\")].status",
          "name": "Ready",
          "type": "string"
        },
        {
          "JSONPath": ".spec.issuerRef.name",
          "name": "Issuer",
          "priority": 1,
          "type": "string"
        },
        {
          "JSONPath": ".status.conditions[?(@.type==\"Ready\")].message",
          "name": "Status",
          "priority": 1,
          "type": "string"
        },
        {
          "JSONPath": ".metadata.creationTimestamp",
          "description": "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC.",
          "name": "Age",
          "type": "date"
        }
      ],
      "group": "cert-manager.io",
      "preserveUnknownFields": false,
      "names": {
        "kind": "CertificateRequest",
        "listKind": "CertificateRequestList",
        "plural": "certificaterequests",
        "shortNames": [
          "cr",
          "crs"
        ],
        "singular": "certificaterequest"
      },
      "scope": "Namespaced",
      "subresources": {
        "status": {}
      },
      "validation": {
        "openAPIV3Schema": {
          "description": "CertificateRequest is a type to represent a Certificate Signing Request",
          "type": "object",
          "properties": {
            "apiVersion": {
              "description": "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources",
              "type": "string"
            },
            "kind": {
              "description": "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds",
              "type": "string"
            },
            "metadata": {
              "type": "object"
            },
            "spec": {
              "description": "CertificateRequestSpec defines the desired state of CertificateRequest",
              "type": "object",
              "required": [
                "csr",
                "issuerRef"
              ],
              "properties": {
                "csr": {
                  "description": "Byte slice containing the PEM encoded CertificateSigningRequest",
                  "type": "string",
                  "format": "byte"
                },
                "duration": {
                  "description": "Requested certificate default Duration",
                  "type": "string"
                },
                "isCA": {
                  "description": "IsCA will mark the resulting certificate as valid for signing. This implies that the 'cert sign' usage is set",
                  "type": "boolean"
                },
                "issuerRef": {
                  "description": "IssuerRef is a reference to the issuer for this CertificateRequest.  If the 'kind' field is not set, or set to 'Issuer', an Issuer resource with the given name in the same namespace as the CertificateRequest will be used.  If the 'kind' field is set to 'ClusterIssuer', a ClusterIssuer with the provided name will be used. The 'name' field in this stanza is required at all times. The group field refers to the API group of the issuer which defaults to 'cert-manager.io' if empty.",
                  "type": "object",
                  "required": [
                    "name"
                  ],
                  "properties": {
                    "group": {
                      "type": "string"
                    },
                    "kind": {
                      "type": "string"
                    },
                    "name": {
                      "type": "string"
                    }
                  }
                },
                "usages": {
                  "description": "Usages is the set of x509 actions that are enabled for a given key. Defaults are ('digital signature', 'key encipherment') if empty",
                  "type": "array",
                  "items": {
                    "description": "KeyUsage specifies valid usage contexts for keys. See: https://tools.ietf.org/html/rfc5280#section-4.2.1.3      https://tools.ietf.org/html/rfc5280#section-4.2.1.12 Valid KeyUsage values are as follows: \"signing\", \"digital signature\", \"content commitment\", \"key encipherment\", \"key agreement\", \"data encipherment\", \"cert sign\", \"crl sign\", \"encipher only\", \"decipher only\", \"any\", \"server auth\", \"client auth\", \"code signing\", \"email protection\", \"s/mime\", \"ipsec end system\", \"ipsec tunnel\", \"ipsec user\", \"timestamping\", \"ocsp signing\", \"microsoft sgc\", \"netscape sgc\"",
                    "type": "string",
                    "enum": [
                      "signing",
                      "digital signature",
                      "content commitment",
                      "key encipherment",
                      "key agreement",
                      "data encipherment",
                      "cert sign",
                      "crl sign",
                      "encipher only",
                      "decipher only",
                      "any",
                      "server auth",
                      "client auth",
                      "code signing",
                      "email protection",
                      "s/mime",
                      "ipsec end system",
                      "ipsec tunnel",
                      "ipsec user",
                      "timestamping",
                      "ocsp signing",
                      "microsoft sgc",
                      "netscape sgc"
                    ]
                  }
                }
              }
            },
            "status": {
              "description": "CertificateStatus defines the observed state of CertificateRequest and resulting signed certificate.",
              "type": "object",
              "properties": {
                "ca": {
                  "description": "Byte slice containing the PEM encoded certificate authority of the signed certificate.",
                  "type": "string",
                  "format": "byte"
                },
                "certificate": {
                  "description": "Byte slice containing a PEM encoded signed certificate resulting from the given certificate signing request.",
                  "type": "string",
                  "format": "byte"
                },
                "conditions": {
                  "type": "array",
                  "items": {
                    "description": "CertificateRequestCondition contains condition information for a CertificateRequest.",
                    "type": "object",
                    "required": [
                      "status",
                      "type"
                    ],
                    "properties": {
                      "lastTransitionTime": {
                        "description": "LastTransitionTime is the timestamp corresponding to the last status change of this condition.",
                        "type": "string",
                        "format": "date-time"
                      },
                      "message": {
                        "description": "Message is a human readable description of the details of the last transition, complementing reason.",
                        "type": "string"
                      },
                      "reason": {
                        "description": "Reason is a brief machine readable explanation for the condition's last transition.",
                        "type": "string"
                      },
                      "status": {
                        "description": "Status of the condition, one of ('True', 'False', 'Unknown').",
                        "type": "string",
                        "enum": [
                          "True",
                          "False",
                          "Unknown"
                        ]
                      },
                      "type": {
                        "description": "Type of the condition, currently ('Ready', 'InvalidRequest').",
                        "type": "string"
                      }
                    }
                  }
                },
                "failureTime": {
                  "description": "FailureTime stores the time that this CertificateRequest failed. This is used to influence garbage collection and back-off.",
                  "type": "string",
                  "format": "date-time"
                }
              }
            }
          }
        }
      },
      "version": "v1alpha2",
      "versions": [
        {
          "name": "v1alpha2",
          "served": true,
          "storage": true
        }
      ]
    }
  },
  "cert-manager-1": {
    "apiVersion": "apiextensions.k8s.io/v1beta1",
    "kind": "CustomResourceDefinition",
    "metadata": {
      "name": "certificates.cert-manager.io"
    },
    "spec": {
      "additionalPrinterColumns": [
        {
          "JSONPath": ".status.conditions[?(@.type==\"Ready\")].status",
          "name": "Ready",
          "type": "string"
        },
        {
          "JSONPath": ".spec.secretName",
          "name": "Secret",
          "type": "string"
        },
        {
          "JSONPath": ".spec.issuerRef.name",
          "name": "Issuer",
          "priority": 1,
          "type": "string"
        },
        {
          "JSONPath": ".status.conditions[?(@.type==\"Ready\")].message",
          "name": "Status",
          "priority": 1,
          "type": "string"
        },
        {
          "JSONPath": ".metadata.creationTimestamp",
          "description": "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC.",
          "name": "Age",
          "type": "date"
        }
      ],
      "group": "cert-manager.io",
      "preserveUnknownFields": false,
      "names": {
        "kind": "Certificate",
        "listKind": "CertificateList",
        "plural": "certificates",
        "shortNames": [
          "cert",
          "certs"
        ],
        "singular": "certificate"
      },
      "scope": "Namespaced",
      "subresources": {
        "status": {}
      },
      "validation": {
        "openAPIV3Schema": {
          "description": "Certificate is a type to represent a Certificate from ACME",
          "type": "object",
          "properties": {
            "apiVersion": {
              "description": "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources",
              "type": "string"
            },
            "kind": {
              "description": "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds",
              "type": "string"
            },
            "metadata": {
              "type": "object"
            },
            "spec": {
              "description": "CertificateSpec defines the desired state of Certificate. A valid Certificate requires at least one of a CommonName, DNSName, or URISAN to be valid.",
              "type": "object",
              "required": [
                "issuerRef",
                "secretName"
              ],
              "properties": {
                "commonName": {
                  "description": "CommonName is a common name to be used on the Certificate. The CommonName should have a length of 64 characters or fewer to avoid generating invalid CSRs.",
                  "type": "string"
                },
                "dnsNames": {
                  "description": "DNSNames is a list of subject alt names to be used on the Certificate.",
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                },
                "duration": {
                  "description": "Certificate default Duration",
                  "type": "string"
                },
                "ipAddresses": {
                  "description": "IPAddresses is a list of IP addresses to be used on the Certificate",
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                },
                "isCA": {
                  "description": "IsCA will mark this Certificate as valid for signing. This implies that the 'cert sign' usage is set",
                  "type": "boolean"
                },
                "issuerRef": {
                  "description": "IssuerRef is a reference to the issuer for this certificate. If the 'kind' field is not set, or set to 'Issuer', an Issuer resource with the given name in the same namespace as the Certificate will be used. If the 'kind' field is set to 'ClusterIssuer', a ClusterIssuer with the provided name will be used. The 'name' field in this stanza is required at all times.",
                  "type": "object",
                  "required": [
                    "name"
                  ],
                  "properties": {
                    "group": {
                      "type": "string"
                    },
                    "kind": {
                      "type": "string"
                    },
                    "name": {
                      "type": "string"
                    }
                  }
                },
                "keyAlgorithm": {
                  "description": "KeyAlgorithm is the private key algorithm of the corresponding private key for this certificate. If provided, allowed values are either \"rsa\" or \"ecdsa\" If KeyAlgorithm is specified and KeySize is not provided, key size of 256 will be used for \"ecdsa\" key algorithm and key size of 2048 will be used for \"rsa\" key algorithm.",
                  "type": "string",
                  "enum": [
                    "rsa",
                    "ecdsa"
                  ]
                },
                "keyEncoding": {
                  "description": "KeyEncoding is the private key cryptography standards (PKCS) for this certificate's private key to be encoded in. If provided, allowed values are \"pkcs1\" and \"pkcs8\" standing for PKCS#1 and PKCS#8, respectively. If KeyEncoding is not specified, then PKCS#1 will be used by default.",
                  "type": "string",
                  "enum": [
                    "pkcs1",
                    "pkcs8"
                  ]
                },
                "keySize": {
                  "description": "KeySize is the key bit size of the corresponding private key for this certificate. If provided, value must be between 2048 and 8192 inclusive when KeyAlgorithm is empty or is set to \"rsa\", and value must be one of (256, 384, 521) when KeyAlgorithm is set to \"ecdsa\".",
                  "type": "integer"
                },
                "organization": {
                  "description": "Organization is the organization to be used on the Certificate",
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                },
                "renewBefore": {
                  "description": "Certificate renew before expiration duration",
                  "type": "string"
                },
                "secretName": {
                  "description": "SecretName is the name of the secret resource to store this secret in",
                  "type": "string"
                },
                "subject": {
                  "description": "Full X509 name specification (https://golang.org/pkg/crypto/x509/pkix/#Name).",
                  "type": "object",
                  "properties": {
                    "countries": {
                      "description": "Countries to be used on the Certificate.",
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "localities": {
                      "description": "Cities to be used on the Certificate.",
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "organizationalUnits": {
                      "description": "Organizational Units to be used on the Certificate.",
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "postalCodes": {
                      "description": "Postal codes to be used on the Certificate.",
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "provinces": {
                      "description": "State/Provinces to be used on the Certificate.",
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    },
                    "serialNumber": {
                      "description": "Serial number to be used on the Certificate.",
                      "type": "string"
                    },
                    "streetAddresses": {
                      "description": "Street addresses to be used on the Certificate.",
                      "type": "array",
                      "items": {
                        "type": "string"
                      }
                    }
                  }
                },
                "uriSANs": {
                  "description": "URISANs is a list of URI Subject Alternative Names to be set on this Certificate.",
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                },
                "usages": {
                  "description": "Usages is the set of x509 actions that are enabled for a given key. Defaults are ('digital signature', 'key encipherment') if empty",
                  "type": "array",
                  "items": {
                    "description": "KeyUsage specifies valid usage contexts for keys. See: https://tools.ietf.org/html/rfc5280#section-4.2.1.3      https://tools.ietf.org/html/rfc5280#section-4.2.1.12 Valid KeyUsage values are as follows: \"signing\", \"digital signature\", \"content commitment\", \"key encipherment\", \"key agreement\", \"data encipherment\", \"cert sign\", \"crl sign\", \"encipher only\", \"decipher only\", \"any\", \"server auth\", \"client auth\", \"code signing\", \"email protection\", \"s/mime\", \"ipsec end system\", \"ipsec tunnel\", \"ipsec user\", \"timestamping\", \"ocsp signing\", \"microsoft sgc\", \"netscape sgc\"",
                    "type": "string",
                    "enum": [
                      "signing",
                      "digital signature",
                      "content commitment",
                      "key encipherment",
                      "key agreement",
                      "data encipherment",
                      "cert sign",
                      "crl sign",
                      "encipher only",
                      "decipher only",
                      "any",
                      "server auth",
                      "client auth",
                      "code signing",
                      "email protection",
                      "s/mime",
                      "ipsec end system",
                      "ipsec tunnel",
                      "ipsec user",
                      "timestamping",
                      "ocsp signing",
                      "microsoft sgc",
                      "netscape sgc"
                    ]
                  }
                }
              }
            },
            "status": {
              "description": "CertificateStatus defines the observed state of Certificate",
              "type": "object",
              "properties": {
                "conditions": {
                  "type": "array",
                  "items": {
                    "description": "CertificateCondition contains condition information for an Certificate.",
                    "type": "object",
                    "required": [
                      "status",
                      "type"
                    ],
                    "properties": {
                      "lastTransitionTime": {
                        "description": "LastTransitionTime is the timestamp corresponding to the last status change of this condition.",
                        "type": "string",
                        "format": "date-time"
                      },
                      "message": {
                        "description": "Message is a human readable description of the details of the last transition, complementing reason.",
                        "type": "string"
                      },
                      "reason": {
                        "description": "Reason is a brief machine readable explanation for the condition's last transition.",
                        "type": "string"
                      },
                      "status": {
                        "description": "Status of the condition, one of ('True', 'False', 'Unknown').",
                        "type": "string",
                        "enum": [
                          "True",
                          "False",
                          "Unknown"
                        ]
                      },
                      "type": {
                        "description": "Type of the condition, currently ('Ready').",
                        "type": "string"
                      }
                    }
                  }
                },
                "lastFailureTime": {
                  "type": "string",
                  "format": "date-time"
                },
                "notAfter": {
                  "description": "The expiration time of the certificate stored in the secret named by this resource in spec.secretName.",
                  "type": "string",
                  "format": "date-time"
                }
              }
            }
          }
        }
      },
      "version": "v1alpha2",
      "versions": [
        {
          "name": "v1alpha2",
          "served": true,
          "storage": true
        }
      ]
    }
  },
  "cert-manager-2": {
    "apiVersion": "apiextensions.k8s.io/v1beta1",
    "kind": "CustomResourceDefinition",
    "metadata": {
      "name": "challenges.acme.cert-manager.io"
    },
    "spec": {
      "additionalPrinterColumns": [
        {
          "JSONPath": ".status.state",
          "name": "State",
          "type": "string"
        },
        {
          "JSONPath": ".spec.dnsName",
          "name": "Domain",
          "type": "string"
        },
        {
          "JSONPath": ".status.reason",
          "name": "Reason",
          "priority": 1,
          "type": "string"
        },
        {
          "JSONPath": ".metadata.creationTimestamp",
          "description": "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC.",
          "name": "Age",
          "type": "date"
        }
      ],
      "group": "acme.cert-manager.io",
      "preserveUnknownFields": false,
      "names": {
        "kind": "Challenge",
        "listKind": "ChallengeList",
        "plural": "challenges",
        "singular": "challenge"
      },
      "scope": "Namespaced",
      "subresources": {
        "status": {}
      },
      "validation": {
        "openAPIV3Schema": {
          "description": "Challenge is a type to represent a Challenge request with an ACME server",
          "type": "object",
          "required": [
            "metadata"
          ],
          "properties": {
            "apiVersion": {
              "description": "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources",
              "type": "string"
            },
            "kind": {
              "description": "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds",
              "type": "string"
            },
            "metadata": {
              "type": "object"
            },
            "spec": {
              "type": "object",
              "required": [
                "authzURL",
                "dnsName",
                "issuerRef",
                "key",
                "token",
                "type",
                "url"
              ],
              "properties": {
                "authzURL": {
                  "description": "AuthzURL is the URL to the ACME Authorization resource that this challenge is a part of.",
                  "type": "string"
                },
                "dnsName": {
                  "description": "DNSName is the identifier that this challenge is for, e.g. example.com.",
                  "type": "string"
                },
                "issuerRef": {
                  "description": "IssuerRef references a properly configured ACME-type Issuer which should be used to create this Challenge. If the Issuer does not exist, processing will be retried. If the Issuer is not an 'ACME' Issuer, an error will be returned and the Challenge will be marked as failed.",
                  "type": "object",
                  "required": [
                    "name"
                  ],
                  "properties": {
                    "group": {
                      "type": "string"
                    },
                    "kind": {
                      "type": "string"
                    },
                    "name": {
                      "type": "string"
                    }
                  }
                },
                "key": {
                  "description": "Key is the ACME challenge key for this challenge",
                  "type": "string"
                },
                "solver": {
                  "description": "Solver contains the domain solving configuration that should be used to solve this challenge resource.",
                  "type": "object",
                  "properties": {
                    "dns01": {
                      "type": "object",
                      "properties": {
                        "acmedns": {
                          "description": "ACMEIssuerDNS01ProviderAcmeDNS is a structure containing the configuration for ACME-DNS servers",
                          "type": "object",
                          "required": [
                            "accountSecretRef",
                            "host"
                          ],
                          "properties": {
                            "accountSecretRef": {
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            },
                            "host": {
                              "type": "string"
                            }
                          }
                        },
                        "akamai": {
                          "description": "ACMEIssuerDNS01ProviderAkamai is a structure containing the DNS configuration for Akamai DNS\u2014Zone Record Management API",
                          "type": "object",
                          "required": [
                            "accessTokenSecretRef",
                            "clientSecretSecretRef",
                            "clientTokenSecretRef",
                            "serviceConsumerDomain"
                          ],
                          "properties": {
                            "accessTokenSecretRef": {
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            },
                            "clientSecretSecretRef": {
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            },
                            "clientTokenSecretRef": {
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            },
                            "serviceConsumerDomain": {
                              "type": "string"
                            }
                          }
                        },
                        "azuredns": {
                          "description": "ACMEIssuerDNS01ProviderAzureDNS is a structure containing the configuration for Azure DNS",
                          "type": "object",
                          "required": [
                            "clientID",
                            "clientSecretSecretRef",
                            "resourceGroupName",
                            "subscriptionID",
                            "tenantID"
                          ],
                          "properties": {
                            "clientID": {
                              "type": "string"
                            },
                            "clientSecretSecretRef": {
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            },
                            "environment": {
                              "type": "string",
                              "enum": [
                                "AzurePublicCloud",
                                "AzureChinaCloud",
                                "AzureGermanCloud",
                                "AzureUSGovernmentCloud"
                              ]
                            },
                            "hostedZoneName": {
                              "type": "string"
                            },
                            "resourceGroupName": {
                              "type": "string"
                            },
                            "subscriptionID": {
                              "type": "string"
                            },
                            "tenantID": {
                              "type": "string"
                            }
                          }
                        },
                        "clouddns": {
                          "description": "ACMEIssuerDNS01ProviderCloudDNS is a structure containing the DNS configuration for Google Cloud DNS",
                          "type": "object",
                          "required": [
                            "project"
                          ],
                          "properties": {
                            "project": {
                              "type": "string"
                            },
                            "serviceAccountSecretRef": {
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            }
                          }
                        },
                        "cloudflare": {
                          "description": "ACMEIssuerDNS01ProviderCloudflare is a structure containing the DNS configuration for Cloudflare",
                          "type": "object",
                          "required": [
                            "email"
                          ],
                          "properties": {
                            "apiKeySecretRef": {
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            },
                            "apiTokenSecretRef": {
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            },
                            "email": {
                              "type": "string"
                            }
                          }
                        },
                        "cnameStrategy": {
                          "description": "CNAMEStrategy configures how the DNS01 provider should handle CNAME records when found in DNS zones.",
                          "type": "string",
                          "enum": [
                            "None",
                            "Follow"
                          ]
                        },
                        "digitalocean": {
                          "description": "ACMEIssuerDNS01ProviderDigitalOcean is a structure containing the DNS configuration for DigitalOcean Domains",
                          "type": "object",
                          "required": [
                            "tokenSecretRef"
                          ],
                          "properties": {
                            "tokenSecretRef": {
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            }
                          }
                        },
                        "rfc2136": {
                          "description": "ACMEIssuerDNS01ProviderRFC2136 is a structure containing the configuration for RFC2136 DNS",
                          "type": "object",
                          "required": [
                            "nameserver"
                          ],
                          "properties": {
                            "nameserver": {
                              "description": "The IP address of the DNS supporting RFC2136. Required. Note: FQDN is not a valid value, only IP.",
                              "type": "string"
                            },
                            "tsigAlgorithm": {
                              "description": "The TSIG Algorithm configured in the DNS supporting RFC2136. Used only when ``tsigSecretSecretRef`` and ``tsigKeyName`` are defined. Supported values are (case-insensitive): ``HMACMD5`` (default), ``HMACSHA1``, ``HMACSHA256`` or ``HMACSHA512``.",
                              "type": "string"
                            },
                            "tsigKeyName": {
                              "description": "The TSIG Key name configured in the DNS. If ``tsigSecretSecretRef`` is defined, this field is required.",
                              "type": "string"
                            },
                            "tsigSecretSecretRef": {
                              "description": "The name of the secret containing the TSIG value. If ``tsigKeyName`` is defined, this field is required.",
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            }
                          }
                        },
                        "route53": {
                          "description": "ACMEIssuerDNS01ProviderRoute53 is a structure containing the Route 53 configuration for AWS",
                          "type": "object",
                          "required": [
                            "region"
                          ],
                          "properties": {
                            "accessKeyID": {
                              "description": "The AccessKeyID is used for authentication. If not set we fall-back to using env vars, shared credentials file or AWS Instance metadata see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials",
                              "type": "string"
                            },
                            "hostedZoneID": {
                              "description": "If set, the provider will manage only this zone in Route53 and will not do an lookup using the route53:ListHostedZonesByName api call.",
                              "type": "string"
                            },
                            "region": {
                              "description": "Always set the region when using AccessKeyID and SecretAccessKey",
                              "type": "string"
                            },
                            "role": {
                              "description": "Role is a Role ARN which the Route53 provider will assume using either the explicit credentials AccessKeyID/SecretAccessKey or the inferred credentials from environment variables, shared credentials file or AWS Instance metadata",
                              "type": "string"
                            },
                            "secretAccessKeySecretRef": {
                              "description": "The SecretAccessKey is used for authentication. If not set we fall-back to using env vars, shared credentials file or AWS Instance metadata https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials",
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            }
                          }
                        },
                        "webhook": {
                          "description": "ACMEIssuerDNS01ProviderWebhook specifies configuration for a webhook DNS01 provider, including where to POST ChallengePayload resources.",
                          "type": "object",
                          "required": [
                            "groupName",
                            "solverName"
                          ],
                          "properties": {
                            "config": {
                              "description": "Additional configuration that should be passed to the webhook apiserver when challenges are processed. This can contain arbitrary JSON data. Secret values should not be specified in this stanza. If secret values are needed (e.g. credentials for a DNS service), you should use a SecretKeySelector to reference a Secret resource. For details on the schema of this field, consult the webhook provider implementation's documentation.",
                              "x-kubernetes-preserve-unknown-fields": true
                            },
                            "groupName": {
                              "description": "The API group name that should be used when POSTing ChallengePayload resources to the webhook apiserver. This should be the same as the GroupName specified in the webhook provider implementation.",
                              "type": "string"
                            },
                            "solverName": {
                              "description": "The name of the solver to use, as defined in the webhook provider implementation. This will typically be the name of the provider, e.g. 'cloudflare'.",
                              "type": "string"
                            }
                          }
                        }
                      }
                    },
                    "http01": {
                      "description": "ACMEChallengeSolverHTTP01 contains configuration detailing how to solve HTTP01 challenges within a Kubernetes cluster. Typically this is accomplished through creating 'routes' of some description that configure ingress controllers to direct traffic to 'solver pods', which are responsible for responding to the ACME server's HTTP requests.",
                      "type": "object",
                      "properties": {
                        "ingress": {
                          "description": "The ingress based HTTP01 challenge solver will solve challenges by creating or modifying Ingress resources in order to route requests for '/.well-known/acme-challenge/XYZ' to 'challenge solver' pods that are provisioned by cert-manager for each Challenge to be completed.",
                          "type": "object",
                          "properties": {
                            "class": {
                              "description": "The ingress class to use when creating Ingress resources to solve ACME challenges that use this challenge solver. Only one of 'class' or 'name' may be specified.",
                              "type": "string"
                            },
                            "name": {
                              "description": "The name of the ingress resource that should have ACME challenge solving routes inserted into it in order to solve HTTP01 challenges. This is typically used in conjunction with ingress controllers like ingress-gce, which maintains a 1:1 mapping between external IPs and ingress resources.",
                              "type": "string"
                            },
                            "podTemplate": {
                              "description": "Optional pod template used to configure the ACME challenge solver pods used for HTTP01 challenges",
                              "type": "object",
                              "properties": {
                                "metadata": {
                                  "description": "ObjectMeta overrides for the pod used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values.",
                                  "type": "object",
                                  "properties": {
                                    "annotations": {
                                      "description": "Annotations that should be added to the create ACME HTTP01 solver pods.",
                                      "type": "object",
                                      "additionalProperties": {
                                        "type": "string"
                                      }
                                    },
                                    "labels": {
                                      "description": "Labels that should be added to the created ACME HTTP01 solver pods.",
                                      "type": "object",
                                      "additionalProperties": {
                                        "type": "string"
                                      }
                                    }
                                  }
                                },
                                "spec": {
                                  "description": "PodSpec defines overrides for the HTTP01 challenge solver pod. Only the 'nodeSelector', 'affinity' and 'tolerations' fields are supported currently. All other fields will be ignored.",
                                  "type": "object",
                                  "properties": {
                                    "affinity": {
                                      "description": "If specified, the pod's scheduling constraints",
                                      "type": "object",
                                      "properties": {
                                        "nodeAffinity": {
                                          "description": "Describes node affinity scheduling rules for the pod.",
                                          "type": "object",
                                          "properties": {
                                            "preferredDuringSchedulingIgnoredDuringExecution": {
                                              "description": "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.",
                                              "type": "array",
                                              "items": {
                                                "description": "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op).",
                                                "type": "object",
                                                "required": [
                                                  "preference",
                                                  "weight"
                                                ],
                                                "properties": {
                                                  "preference": {
                                                    "description": "A node selector term, associated with the corresponding weight.",
                                                    "type": "object",
                                                    "properties": {
                                                      "matchExpressions": {
                                                        "description": "A list of node selector requirements by node's labels.",
                                                        "type": "array",
                                                        "items": {
                                                          "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                          "type": "object",
                                                          "required": [
                                                            "key",
                                                            "operator"
                                                          ],
                                                          "properties": {
                                                            "key": {
                                                              "description": "The label key that the selector applies to.",
                                                              "type": "string"
                                                            },
                                                            "operator": {
                                                              "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                              "type": "string"
                                                            },
                                                            "values": {
                                                              "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                              "type": "array",
                                                              "items": {
                                                                "type": "string"
                                                              }
                                                            }
                                                          }
                                                        }
                                                      },
                                                      "matchFields": {
                                                        "description": "A list of node selector requirements by node's fields.",
                                                        "type": "array",
                                                        "items": {
                                                          "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                          "type": "object",
                                                          "required": [
                                                            "key",
                                                            "operator"
                                                          ],
                                                          "properties": {
                                                            "key": {
                                                              "description": "The label key that the selector applies to.",
                                                              "type": "string"
                                                            },
                                                            "operator": {
                                                              "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                              "type": "string"
                                                            },
                                                            "values": {
                                                              "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                              "type": "array",
                                                              "items": {
                                                                "type": "string"
                                                              }
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }
                                                  },
                                                  "weight": {
                                                    "description": "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.",
                                                    "type": "integer",
                                                    "format": "int32"
                                                  }
                                                }
                                              }
                                            },
                                            "requiredDuringSchedulingIgnoredDuringExecution": {
                                              "description": "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.",
                                              "type": "object",
                                              "required": [
                                                "nodeSelectorTerms"
                                              ],
                                              "properties": {
                                                "nodeSelectorTerms": {
                                                  "description": "Required. A list of node selector terms. The terms are ORed.",
                                                  "type": "array",
                                                  "items": {
                                                    "description": "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm.",
                                                    "type": "object",
                                                    "properties": {
                                                      "matchExpressions": {
                                                        "description": "A list of node selector requirements by node's labels.",
                                                        "type": "array",
                                                        "items": {
                                                          "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                          "type": "object",
                                                          "required": [
                                                            "key",
                                                            "operator"
                                                          ],
                                                          "properties": {
                                                            "key": {
                                                              "description": "The label key that the selector applies to.",
                                                              "type": "string"
                                                            },
                                                            "operator": {
                                                              "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                              "type": "string"
                                                            },
                                                            "values": {
                                                              "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                              "type": "array",
                                                              "items": {
                                                                "type": "string"
                                                              }
                                                            }
                                                          }
                                                        }
                                                      },
                                                      "matchFields": {
                                                        "description": "A list of node selector requirements by node's fields.",
                                                        "type": "array",
                                                        "items": {
                                                          "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                          "type": "object",
                                                          "required": [
                                                            "key",
                                                            "operator"
                                                          ],
                                                          "properties": {
                                                            "key": {
                                                              "description": "The label key that the selector applies to.",
                                                              "type": "string"
                                                            },
                                                            "operator": {
                                                              "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                              "type": "string"
                                                            },
                                                            "values": {
                                                              "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                              "type": "array",
                                                              "items": {
                                                                "type": "string"
                                                              }
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        },
                                        "podAffinity": {
                                          "description": "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).",
                                          "type": "object",
                                          "properties": {
                                            "preferredDuringSchedulingIgnoredDuringExecution": {
                                              "description": "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.",
                                              "type": "array",
                                              "items": {
                                                "description": "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)",
                                                "type": "object",
                                                "required": [
                                                  "podAffinityTerm",
                                                  "weight"
                                                ],
                                                "properties": {
                                                  "podAffinityTerm": {
                                                    "description": "Required. A pod affinity term, associated with the corresponding weight.",
                                                    "type": "object",
                                                    "required": [
                                                      "topologyKey"
                                                    ],
                                                    "properties": {
                                                      "labelSelector": {
                                                        "description": "A label query over a set of resources, in this case pods.",
                                                        "type": "object",
                                                        "properties": {
                                                          "matchExpressions": {
                                                            "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                            "type": "array",
                                                            "items": {
                                                              "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                              "type": "object",
                                                              "required": [
                                                                "key",
                                                                "operator"
                                                              ],
                                                              "properties": {
                                                                "key": {
                                                                  "description": "key is the label key that the selector applies to.",
                                                                  "type": "string"
                                                                },
                                                                "operator": {
                                                                  "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                  "type": "string"
                                                                },
                                                                "values": {
                                                                  "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                  "type": "array",
                                                                  "items": {
                                                                    "type": "string"
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          },
                                                          "matchLabels": {
                                                            "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                            "type": "object",
                                                            "additionalProperties": {
                                                              "type": "string"
                                                            }
                                                          }
                                                        }
                                                      },
                                                      "namespaces": {
                                                        "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                        "type": "array",
                                                        "items": {
                                                          "type": "string"
                                                        }
                                                      },
                                                      "topologyKey": {
                                                        "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                        "type": "string"
                                                      }
                                                    }
                                                  },
                                                  "weight": {
                                                    "description": "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.",
                                                    "type": "integer",
                                                    "format": "int32"
                                                  }
                                                }
                                              }
                                            },
                                            "requiredDuringSchedulingIgnoredDuringExecution": {
                                              "description": "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.",
                                              "type": "array",
                                              "items": {
                                                "description": "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running",
                                                "type": "object",
                                                "required": [
                                                  "topologyKey"
                                                ],
                                                "properties": {
                                                  "labelSelector": {
                                                    "description": "A label query over a set of resources, in this case pods.",
                                                    "type": "object",
                                                    "properties": {
                                                      "matchExpressions": {
                                                        "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                        "type": "array",
                                                        "items": {
                                                          "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                          "type": "object",
                                                          "required": [
                                                            "key",
                                                            "operator"
                                                          ],
                                                          "properties": {
                                                            "key": {
                                                              "description": "key is the label key that the selector applies to.",
                                                              "type": "string"
                                                            },
                                                            "operator": {
                                                              "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                              "type": "string"
                                                            },
                                                            "values": {
                                                              "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                              "type": "array",
                                                              "items": {
                                                                "type": "string"
                                                              }
                                                            }
                                                          }
                                                        }
                                                      },
                                                      "matchLabels": {
                                                        "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                        "type": "object",
                                                        "additionalProperties": {
                                                          "type": "string"
                                                        }
                                                      }
                                                    }
                                                  },
                                                  "namespaces": {
                                                    "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                    "type": "array",
                                                    "items": {
                                                      "type": "string"
                                                    }
                                                  },
                                                  "topologyKey": {
                                                    "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                    "type": "string"
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        },
                                        "podAntiAffinity": {
                                          "description": "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).",
                                          "type": "object",
                                          "properties": {
                                            "preferredDuringSchedulingIgnoredDuringExecution": {
                                              "description": "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.",
                                              "type": "array",
                                              "items": {
                                                "description": "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)",
                                                "type": "object",
                                                "required": [
                                                  "podAffinityTerm",
                                                  "weight"
                                                ],
                                                "properties": {
                                                  "podAffinityTerm": {
                                                    "description": "Required. A pod affinity term, associated with the corresponding weight.",
                                                    "type": "object",
                                                    "required": [
                                                      "topologyKey"
                                                    ],
                                                    "properties": {
                                                      "labelSelector": {
                                                        "description": "A label query over a set of resources, in this case pods.",
                                                        "type": "object",
                                                        "properties": {
                                                          "matchExpressions": {
                                                            "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                            "type": "array",
                                                            "items": {
                                                              "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                              "type": "object",
                                                              "required": [
                                                                "key",
                                                                "operator"
                                                              ],
                                                              "properties": {
                                                                "key": {
                                                                  "description": "key is the label key that the selector applies to.",
                                                                  "type": "string"
                                                                },
                                                                "operator": {
                                                                  "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                  "type": "string"
                                                                },
                                                                "values": {
                                                                  "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                  "type": "array",
                                                                  "items": {
                                                                    "type": "string"
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          },
                                                          "matchLabels": {
                                                            "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                            "type": "object",
                                                            "additionalProperties": {
                                                              "type": "string"
                                                            }
                                                          }
                                                        }
                                                      },
                                                      "namespaces": {
                                                        "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                        "type": "array",
                                                        "items": {
                                                          "type": "string"
                                                        }
                                                      },
                                                      "topologyKey": {
                                                        "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                        "type": "string"
                                                      }
                                                    }
                                                  },
                                                  "weight": {
                                                    "description": "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.",
                                                    "type": "integer",
                                                    "format": "int32"
                                                  }
                                                }
                                              }
                                            },
                                            "requiredDuringSchedulingIgnoredDuringExecution": {
                                              "description": "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.",
                                              "type": "array",
                                              "items": {
                                                "description": "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running",
                                                "type": "object",
                                                "required": [
                                                  "topologyKey"
                                                ],
                                                "properties": {
                                                  "labelSelector": {
                                                    "description": "A label query over a set of resources, in this case pods.",
                                                    "type": "object",
                                                    "properties": {
                                                      "matchExpressions": {
                                                        "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                        "type": "array",
                                                        "items": {
                                                          "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                          "type": "object",
                                                          "required": [
                                                            "key",
                                                            "operator"
                                                          ],
                                                          "properties": {
                                                            "key": {
                                                              "description": "key is the label key that the selector applies to.",
                                                              "type": "string"
                                                            },
                                                            "operator": {
                                                              "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                              "type": "string"
                                                            },
                                                            "values": {
                                                              "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                              "type": "array",
                                                              "items": {
                                                                "type": "string"
                                                              }
                                                            }
                                                          }
                                                        }
                                                      },
                                                      "matchLabels": {
                                                        "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                        "type": "object",
                                                        "additionalProperties": {
                                                          "type": "string"
                                                        }
                                                      }
                                                    }
                                                  },
                                                  "namespaces": {
                                                    "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                    "type": "array",
                                                    "items": {
                                                      "type": "string"
                                                    }
                                                  },
                                                  "topologyKey": {
                                                    "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                    "type": "string"
                                                  }
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    },
                                    "nodeSelector": {
                                      "description": "NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/",
                                      "type": "object",
                                      "additionalProperties": {
                                        "type": "string"
                                      }
                                    },
                                    "tolerations": {
                                      "description": "If specified, the pod's tolerations.",
                                      "type": "array",
                                      "items": {
                                        "description": "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>.",
                                        "type": "object",
                                        "properties": {
                                          "effect": {
                                            "description": "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.",
                                            "type": "string"
                                          },
                                          "key": {
                                            "description": "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys.",
                                            "type": "string"
                                          },
                                          "operator": {
                                            "description": "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category.",
                                            "type": "string"
                                          },
                                          "tolerationSeconds": {
                                            "description": "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system.",
                                            "type": "integer",
                                            "format": "int64"
                                          },
                                          "value": {
                                            "description": "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.",
                                            "type": "string"
                                          }
                                        }
                                      }
                                    }
                                  }
                                }
                              }
                            },
                            "serviceType": {
                              "description": "Optional service type for Kubernetes solver service",
                              "type": "string"
                            }
                          }
                        }
                      }
                    },
                    "selector": {
                      "description": "Selector selects a set of DNSNames on the Certificate resource that should be solved using this challenge solver.",
                      "type": "object",
                      "properties": {
                        "dnsNames": {
                          "description": "List of DNSNames that this solver will be used to solve. If specified and a match is found, a dnsNames selector will take precedence over a dnsZones selector. If multiple solvers match with the same dnsNames value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected.",
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "dnsZones": {
                          "description": "List of DNSZones that this solver will be used to solve. The most specific DNS zone match specified here will take precedence over other DNS zone matches, so a solver specifying sys.example.com will be selected over one specifying example.com for the domain www.sys.example.com. If multiple solvers match with the same dnsZones value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected.",
                          "type": "array",
                          "items": {
                            "type": "string"
                          }
                        },
                        "matchLabels": {
                          "description": "A label selector that is used to refine the set of certificate's that this challenge solver will apply to.",
                          "type": "object",
                          "additionalProperties": {
                            "type": "string"
                          }
                        }
                      }
                    }
                  }
                },
                "token": {
                  "description": "Token is the ACME challenge token for this challenge.",
                  "type": "string"
                },
                "type": {
                  "description": "Type is the type of ACME challenge this resource represents, e.g. \"dns01\" or \"http01\"",
                  "type": "string"
                },
                "url": {
                  "description": "URL is the URL of the ACME Challenge resource for this challenge. This can be used to lookup details about the status of this challenge.",
                  "type": "string"
                },
                "wildcard": {
                  "description": "Wildcard will be true if this challenge is for a wildcard identifier, for example '*.example.com'",
                  "type": "boolean"
                }
              }
            },
            "status": {
              "type": "object",
              "properties": {
                "presented": {
                  "description": "Presented will be set to true if the challenge values for this challenge are currently 'presented'. This *does not* imply the self check is passing. Only that the values have been 'submitted' for the appropriate challenge mechanism (i.e. the DNS01 TXT record has been presented, or the HTTP01 configuration has been configured).",
                  "type": "boolean"
                },
                "processing": {
                  "description": "Processing is used to denote whether this challenge should be processed or not. This field will only be set to true by the 'scheduling' component. It will only be set to false by the 'challenges' controller, after the challenge has reached a final state or timed out. If this field is set to false, the challenge controller will not take any more action.",
                  "type": "boolean"
                },
                "reason": {
                  "description": "Reason contains human readable information on why the Challenge is in the current state.",
                  "type": "string"
                },
                "state": {
                  "description": "State contains the current 'state' of the challenge. If not set, the state of the challenge is unknown.",
                  "type": "string",
                  "enum": [
                    "valid",
                    "ready",
                    "pending",
                    "processing",
                    "invalid",
                    "expired",
                    "errored"
                  ]
                }
              }
            }
          }
        }
      },
      "version": "v1alpha2",
      "versions": [
        {
          "name": "v1alpha2",
          "served": true,
          "storage": true
        }
      ]
    }
  },
  "cert-manager-3": {
    "apiVersion": "apiextensions.k8s.io/v1beta1",
    "kind": "CustomResourceDefinition",
    "metadata": {
      "name": "clusterissuers.cert-manager.io"
    },
    "spec": {
      "additionalPrinterColumns": [
        {
          "JSONPath": ".status.conditions[?(@.type==\"Ready\")].status",
          "name": "Ready",
          "type": "string"
        },
        {
          "JSONPath": ".status.conditions[?(@.type==\"Ready\")].message",
          "name": "Status",
          "priority": 1,
          "type": "string"
        },
        {
          "JSONPath": ".metadata.creationTimestamp",
          "description": "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC.",
          "name": "Age",
          "type": "date"
        }
      ],
      "group": "cert-manager.io",
      "preserveUnknownFields": false,
      "names": {
        "kind": "ClusterIssuer",
        "listKind": "ClusterIssuerList",
        "plural": "clusterissuers",
        "singular": "clusterissuer"
      },
      "scope": "Cluster",
      "subresources": {
        "status": {}
      },
      "validation": {
        "openAPIV3Schema": {
          "type": "object",
          "properties": {
            "apiVersion": {
              "description": "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources",
              "type": "string"
            },
            "kind": {
              "description": "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds",
              "type": "string"
            },
            "metadata": {
              "type": "object"
            },
            "spec": {
              "description": "IssuerSpec is the specification of an Issuer. This includes any configuration required for the issuer.",
              "type": "object",
              "properties": {
                "acme": {
                  "description": "ACMEIssuer contains the specification for an ACME issuer",
                  "type": "object",
                  "required": [
                    "privateKeySecretRef",
                    "server"
                  ],
                  "properties": {
                    "email": {
                      "description": "Email is the email for this account",
                      "type": "string"
                    },
                    "externalAccountBinding": {
                      "description": "ExternalAcccountBinding is a reference to a CA external account of the ACME server.",
                      "type": "object",
                      "required": [
                        "keyAlgorithm",
                        "keyID",
                        "keySecretRef"
                      ],
                      "properties": {
                        "keyAlgorithm": {
                          "description": "keyAlgorithm is the MAC key algorithm that the key is used for. Valid values are \"HS256\", \"HS384\" and \"HS512\".",
                          "type": "string",
                          "enum": [
                            "HS256",
                            "HS384",
                            "HS512"
                          ]
                        },
                        "keyID": {
                          "description": "keyID is the ID of the CA key that the External Account is bound to.",
                          "type": "string"
                        },
                        "keySecretRef": {
                          "description": "keySecretRef is a Secret Key Selector referencing a data item in a Kubernetes Secret which holds the symmetric MAC key of the External Account Binding. The `key` is the index string that is paired with the key data in the Secret and should not be confused with the key data itself, or indeed with the External Account Binding keyID above. The secret key stored in the Secret **must** be un-padded, base64 URL encoded data.",
                          "type": "object",
                          "required": [
                            "name"
                          ],
                          "properties": {
                            "key": {
                              "description": "The key of the secret to select from. Must be a valid secret key.",
                              "type": "string"
                            },
                            "name": {
                              "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                              "type": "string"
                            }
                          }
                        }
                      }
                    },
                    "privateKeySecretRef": {
                      "description": "PrivateKey is the name of a secret containing the private key for this user account.",
                      "type": "object",
                      "required": [
                        "name"
                      ],
                      "properties": {
                        "key": {
                          "description": "The key of the secret to select from. Must be a valid secret key.",
                          "type": "string"
                        },
                        "name": {
                          "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                          "type": "string"
                        }
                      }
                    },
                    "server": {
                      "description": "Server is the ACME server URL",
                      "type": "string"
                    },
                    "skipTLSVerify": {
                      "description": "If true, skip verifying the ACME server TLS certificate",
                      "type": "boolean"
                    },
                    "solvers": {
                      "description": "Solvers is a list of challenge solvers that will be used to solve ACME challenges for the matching domains.",
                      "type": "array",
                      "items": {
                        "type": "object",
                        "properties": {
                          "dns01": {
                            "type": "object",
                            "properties": {
                              "acmedns": {
                                "description": "ACMEIssuerDNS01ProviderAcmeDNS is a structure containing the configuration for ACME-DNS servers",
                                "type": "object",
                                "required": [
                                  "accountSecretRef",
                                  "host"
                                ],
                                "properties": {
                                  "accountSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "host": {
                                    "type": "string"
                                  }
                                }
                              },
                              "akamai": {
                                "description": "ACMEIssuerDNS01ProviderAkamai is a structure containing the DNS configuration for Akamai DNS\u2014Zone Record Management API",
                                "type": "object",
                                "required": [
                                  "accessTokenSecretRef",
                                  "clientSecretSecretRef",
                                  "clientTokenSecretRef",
                                  "serviceConsumerDomain"
                                ],
                                "properties": {
                                  "accessTokenSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "clientSecretSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "clientTokenSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "serviceConsumerDomain": {
                                    "type": "string"
                                  }
                                }
                              },
                              "azuredns": {
                                "description": "ACMEIssuerDNS01ProviderAzureDNS is a structure containing the configuration for Azure DNS",
                                "type": "object",
                                "required": [
                                  "clientID",
                                  "clientSecretSecretRef",
                                  "resourceGroupName",
                                  "subscriptionID",
                                  "tenantID"
                                ],
                                "properties": {
                                  "clientID": {
                                    "type": "string"
                                  },
                                  "clientSecretSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "environment": {
                                    "type": "string",
                                    "enum": [
                                      "AzurePublicCloud",
                                      "AzureChinaCloud",
                                      "AzureGermanCloud",
                                      "AzureUSGovernmentCloud"
                                    ]
                                  },
                                  "hostedZoneName": {
                                    "type": "string"
                                  },
                                  "resourceGroupName": {
                                    "type": "string"
                                  },
                                  "subscriptionID": {
                                    "type": "string"
                                  },
                                  "tenantID": {
                                    "type": "string"
                                  }
                                }
                              },
                              "clouddns": {
                                "description": "ACMEIssuerDNS01ProviderCloudDNS is a structure containing the DNS configuration for Google Cloud DNS",
                                "type": "object",
                                "required": [
                                  "project"
                                ],
                                "properties": {
                                  "project": {
                                    "type": "string"
                                  },
                                  "serviceAccountSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  }
                                }
                              },
                              "cloudflare": {
                                "description": "ACMEIssuerDNS01ProviderCloudflare is a structure containing the DNS configuration for Cloudflare",
                                "type": "object",
                                "required": [
                                  "email"
                                ],
                                "properties": {
                                  "apiKeySecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "apiTokenSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "email": {
                                    "type": "string"
                                  }
                                }
                              },
                              "cnameStrategy": {
                                "description": "CNAMEStrategy configures how the DNS01 provider should handle CNAME records when found in DNS zones.",
                                "type": "string",
                                "enum": [
                                  "None",
                                  "Follow"
                                ]
                              },
                              "digitalocean": {
                                "description": "ACMEIssuerDNS01ProviderDigitalOcean is a structure containing the DNS configuration for DigitalOcean Domains",
                                "type": "object",
                                "required": [
                                  "tokenSecretRef"
                                ],
                                "properties": {
                                  "tokenSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  }
                                }
                              },
                              "rfc2136": {
                                "description": "ACMEIssuerDNS01ProviderRFC2136 is a structure containing the configuration for RFC2136 DNS",
                                "type": "object",
                                "required": [
                                  "nameserver"
                                ],
                                "properties": {
                                  "nameserver": {
                                    "description": "The IP address of the DNS supporting RFC2136. Required. Note: FQDN is not a valid value, only IP.",
                                    "type": "string"
                                  },
                                  "tsigAlgorithm": {
                                    "description": "The TSIG Algorithm configured in the DNS supporting RFC2136. Used only when ``tsigSecretSecretRef`` and ``tsigKeyName`` are defined. Supported values are (case-insensitive): ``HMACMD5`` (default), ``HMACSHA1``, ``HMACSHA256`` or ``HMACSHA512``.",
                                    "type": "string"
                                  },
                                  "tsigKeyName": {
                                    "description": "The TSIG Key name configured in the DNS. If ``tsigSecretSecretRef`` is defined, this field is required.",
                                    "type": "string"
                                  },
                                  "tsigSecretSecretRef": {
                                    "description": "The name of the secret containing the TSIG value. If ``tsigKeyName`` is defined, this field is required.",
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  }
                                }
                              },
                              "route53": {
                                "description": "ACMEIssuerDNS01ProviderRoute53 is a structure containing the Route 53 configuration for AWS",
                                "type": "object",
                                "required": [
                                  "region"
                                ],
                                "properties": {
                                  "accessKeyID": {
                                    "description": "The AccessKeyID is used for authentication. If not set we fall-back to using env vars, shared credentials file or AWS Instance metadata see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials",
                                    "type": "string"
                                  },
                                  "hostedZoneID": {
                                    "description": "If set, the provider will manage only this zone in Route53 and will not do an lookup using the route53:ListHostedZonesByName api call.",
                                    "type": "string"
                                  },
                                  "region": {
                                    "description": "Always set the region when using AccessKeyID and SecretAccessKey",
                                    "type": "string"
                                  },
                                  "role": {
                                    "description": "Role is a Role ARN which the Route53 provider will assume using either the explicit credentials AccessKeyID/SecretAccessKey or the inferred credentials from environment variables, shared credentials file or AWS Instance metadata",
                                    "type": "string"
                                  },
                                  "secretAccessKeySecretRef": {
                                    "description": "The SecretAccessKey is used for authentication. If not set we fall-back to using env vars, shared credentials file or AWS Instance metadata https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials",
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  }
                                }
                              },
                              "webhook": {
                                "description": "ACMEIssuerDNS01ProviderWebhook specifies configuration for a webhook DNS01 provider, including where to POST ChallengePayload resources.",
                                "type": "object",
                                "required": [
                                  "groupName",
                                  "solverName"
                                ],
                                "properties": {
                                  "config": {
                                    "description": "Additional configuration that should be passed to the webhook apiserver when challenges are processed. This can contain arbitrary JSON data. Secret values should not be specified in this stanza. If secret values are needed (e.g. credentials for a DNS service), you should use a SecretKeySelector to reference a Secret resource. For details on the schema of this field, consult the webhook provider implementation's documentation.",
                                    "x-kubernetes-preserve-unknown-fields": true
                                  },
                                  "groupName": {
                                    "description": "The API group name that should be used when POSTing ChallengePayload resources to the webhook apiserver. This should be the same as the GroupName specified in the webhook provider implementation.",
                                    "type": "string"
                                  },
                                  "solverName": {
                                    "description": "The name of the solver to use, as defined in the webhook provider implementation. This will typically be the name of the provider, e.g. 'cloudflare'.",
                                    "type": "string"
                                  }
                                }
                              }
                            }
                          },
                          "http01": {
                            "description": "ACMEChallengeSolverHTTP01 contains configuration detailing how to solve HTTP01 challenges within a Kubernetes cluster. Typically this is accomplished through creating 'routes' of some description that configure ingress controllers to direct traffic to 'solver pods', which are responsible for responding to the ACME server's HTTP requests.",
                            "type": "object",
                            "properties": {
                              "ingress": {
                                "description": "The ingress based HTTP01 challenge solver will solve challenges by creating or modifying Ingress resources in order to route requests for '/.well-known/acme-challenge/XYZ' to 'challenge solver' pods that are provisioned by cert-manager for each Challenge to be completed.",
                                "type": "object",
                                "properties": {
                                  "class": {
                                    "description": "The ingress class to use when creating Ingress resources to solve ACME challenges that use this challenge solver. Only one of 'class' or 'name' may be specified.",
                                    "type": "string"
                                  },
                                  "name": {
                                    "description": "The name of the ingress resource that should have ACME challenge solving routes inserted into it in order to solve HTTP01 challenges. This is typically used in conjunction with ingress controllers like ingress-gce, which maintains a 1:1 mapping between external IPs and ingress resources.",
                                    "type": "string"
                                  },
                                  "podTemplate": {
                                    "description": "Optional pod template used to configure the ACME challenge solver pods used for HTTP01 challenges",
                                    "type": "object",
                                    "properties": {
                                      "metadata": {
                                        "description": "ObjectMeta overrides for the pod used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values.",
                                        "type": "object",
                                        "properties": {
                                          "annotations": {
                                            "description": "Annotations that should be added to the create ACME HTTP01 solver pods.",
                                            "type": "object",
                                            "additionalProperties": {
                                              "type": "string"
                                            }
                                          },
                                          "labels": {
                                            "description": "Labels that should be added to the created ACME HTTP01 solver pods.",
                                            "type": "object",
                                            "additionalProperties": {
                                              "type": "string"
                                            }
                                          }
                                        }
                                      },
                                      "spec": {
                                        "description": "PodSpec defines overrides for the HTTP01 challenge solver pod. Only the 'nodeSelector', 'affinity' and 'tolerations' fields are supported currently. All other fields will be ignored.",
                                        "type": "object",
                                        "properties": {
                                          "affinity": {
                                            "description": "If specified, the pod's scheduling constraints",
                                            "type": "object",
                                            "properties": {
                                              "nodeAffinity": {
                                                "description": "Describes node affinity scheduling rules for the pod.",
                                                "type": "object",
                                                "properties": {
                                                  "preferredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.",
                                                    "type": "array",
                                                    "items": {
                                                      "description": "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op).",
                                                      "type": "object",
                                                      "required": [
                                                        "preference",
                                                        "weight"
                                                      ],
                                                      "properties": {
                                                        "preference": {
                                                          "description": "A node selector term, associated with the corresponding weight.",
                                                          "type": "object",
                                                          "properties": {
                                                            "matchExpressions": {
                                                              "description": "A list of node selector requirements by node's labels.",
                                                              "type": "array",
                                                              "items": {
                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "type": "object",
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "The label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                    "type": "array",
                                                                    "items": {
                                                                      "type": "string"
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            "matchFields": {
                                                              "description": "A list of node selector requirements by node's fields.",
                                                              "type": "array",
                                                              "items": {
                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "type": "object",
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "The label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                    "type": "array",
                                                                    "items": {
                                                                      "type": "string"
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          }
                                                        },
                                                        "weight": {
                                                          "description": "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.",
                                                          "type": "integer",
                                                          "format": "int32"
                                                        }
                                                      }
                                                    }
                                                  },
                                                  "requiredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.",
                                                    "type": "object",
                                                    "required": [
                                                      "nodeSelectorTerms"
                                                    ],
                                                    "properties": {
                                                      "nodeSelectorTerms": {
                                                        "description": "Required. A list of node selector terms. The terms are ORed.",
                                                        "type": "array",
                                                        "items": {
                                                          "description": "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm.",
                                                          "type": "object",
                                                          "properties": {
                                                            "matchExpressions": {
                                                              "description": "A list of node selector requirements by node's labels.",
                                                              "type": "array",
                                                              "items": {
                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "type": "object",
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "The label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                    "type": "array",
                                                                    "items": {
                                                                      "type": "string"
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            "matchFields": {
                                                              "description": "A list of node selector requirements by node's fields.",
                                                              "type": "array",
                                                              "items": {
                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "type": "object",
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "The label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                    "type": "array",
                                                                    "items": {
                                                                      "type": "string"
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              },
                                              "podAffinity": {
                                                "description": "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).",
                                                "type": "object",
                                                "properties": {
                                                  "preferredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.",
                                                    "type": "array",
                                                    "items": {
                                                      "description": "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)",
                                                      "type": "object",
                                                      "required": [
                                                        "podAffinityTerm",
                                                        "weight"
                                                      ],
                                                      "properties": {
                                                        "podAffinityTerm": {
                                                          "description": "Required. A pod affinity term, associated with the corresponding weight.",
                                                          "type": "object",
                                                          "required": [
                                                            "topologyKey"
                                                          ],
                                                          "properties": {
                                                            "labelSelector": {
                                                              "description": "A label query over a set of resources, in this case pods.",
                                                              "type": "object",
                                                              "properties": {
                                                                "matchExpressions": {
                                                                  "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                                  "type": "array",
                                                                  "items": {
                                                                    "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                    "type": "object",
                                                                    "required": [
                                                                      "key",
                                                                      "operator"
                                                                    ],
                                                                    "properties": {
                                                                      "key": {
                                                                        "description": "key is the label key that the selector applies to.",
                                                                        "type": "string"
                                                                      },
                                                                      "operator": {
                                                                        "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                        "type": "string"
                                                                      },
                                                                      "values": {
                                                                        "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                        "type": "array",
                                                                        "items": {
                                                                          "type": "string"
                                                                        }
                                                                      }
                                                                    }
                                                                  }
                                                                },
                                                                "matchLabels": {
                                                                  "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                                  "type": "object",
                                                                  "additionalProperties": {
                                                                    "type": "string"
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            "namespaces": {
                                                              "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                              "type": "array",
                                                              "items": {
                                                                "type": "string"
                                                              }
                                                            },
                                                            "topologyKey": {
                                                              "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                              "type": "string"
                                                            }
                                                          }
                                                        },
                                                        "weight": {
                                                          "description": "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.",
                                                          "type": "integer",
                                                          "format": "int32"
                                                        }
                                                      }
                                                    }
                                                  },
                                                  "requiredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.",
                                                    "type": "array",
                                                    "items": {
                                                      "description": "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running",
                                                      "type": "object",
                                                      "required": [
                                                        "topologyKey"
                                                      ],
                                                      "properties": {
                                                        "labelSelector": {
                                                          "description": "A label query over a set of resources, in this case pods.",
                                                          "type": "object",
                                                          "properties": {
                                                            "matchExpressions": {
                                                              "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                              "type": "array",
                                                              "items": {
                                                                "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "type": "object",
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "key is the label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                    "type": "array",
                                                                    "items": {
                                                                      "type": "string"
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            "matchLabels": {
                                                              "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                              "type": "object",
                                                              "additionalProperties": {
                                                                "type": "string"
                                                              }
                                                            }
                                                          }
                                                        },
                                                        "namespaces": {
                                                          "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                          "type": "array",
                                                          "items": {
                                                            "type": "string"
                                                          }
                                                        },
                                                        "topologyKey": {
                                                          "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                          "type": "string"
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              },
                                              "podAntiAffinity": {
                                                "description": "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).",
                                                "type": "object",
                                                "properties": {
                                                  "preferredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.",
                                                    "type": "array",
                                                    "items": {
                                                      "description": "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)",
                                                      "type": "object",
                                                      "required": [
                                                        "podAffinityTerm",
                                                        "weight"
                                                      ],
                                                      "properties": {
                                                        "podAffinityTerm": {
                                                          "description": "Required. A pod affinity term, associated with the corresponding weight.",
                                                          "type": "object",
                                                          "required": [
                                                            "topologyKey"
                                                          ],
                                                          "properties": {
                                                            "labelSelector": {
                                                              "description": "A label query over a set of resources, in this case pods.",
                                                              "type": "object",
                                                              "properties": {
                                                                "matchExpressions": {
                                                                  "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                                  "type": "array",
                                                                  "items": {
                                                                    "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                    "type": "object",
                                                                    "required": [
                                                                      "key",
                                                                      "operator"
                                                                    ],
                                                                    "properties": {
                                                                      "key": {
                                                                        "description": "key is the label key that the selector applies to.",
                                                                        "type": "string"
                                                                      },
                                                                      "operator": {
                                                                        "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                        "type": "string"
                                                                      },
                                                                      "values": {
                                                                        "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                        "type": "array",
                                                                        "items": {
                                                                          "type": "string"
                                                                        }
                                                                      }
                                                                    }
                                                                  }
                                                                },
                                                                "matchLabels": {
                                                                  "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                                  "type": "object",
                                                                  "additionalProperties": {
                                                                    "type": "string"
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            "namespaces": {
                                                              "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                              "type": "array",
                                                              "items": {
                                                                "type": "string"
                                                              }
                                                            },
                                                            "topologyKey": {
                                                              "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                              "type": "string"
                                                            }
                                                          }
                                                        },
                                                        "weight": {
                                                          "description": "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.",
                                                          "type": "integer",
                                                          "format": "int32"
                                                        }
                                                      }
                                                    }
                                                  },
                                                  "requiredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.",
                                                    "type": "array",
                                                    "items": {
                                                      "description": "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running",
                                                      "type": "object",
                                                      "required": [
                                                        "topologyKey"
                                                      ],
                                                      "properties": {
                                                        "labelSelector": {
                                                          "description": "A label query over a set of resources, in this case pods.",
                                                          "type": "object",
                                                          "properties": {
                                                            "matchExpressions": {
                                                              "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                              "type": "array",
                                                              "items": {
                                                                "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "type": "object",
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "key is the label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                    "type": "array",
                                                                    "items": {
                                                                      "type": "string"
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            "matchLabels": {
                                                              "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                              "type": "object",
                                                              "additionalProperties": {
                                                                "type": "string"
                                                              }
                                                            }
                                                          }
                                                        },
                                                        "namespaces": {
                                                          "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                          "type": "array",
                                                          "items": {
                                                            "type": "string"
                                                          }
                                                        },
                                                        "topologyKey": {
                                                          "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                          "type": "string"
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          },
                                          "nodeSelector": {
                                            "description": "NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/",
                                            "type": "object",
                                            "additionalProperties": {
                                              "type": "string"
                                            }
                                          },
                                          "tolerations": {
                                            "description": "If specified, the pod's tolerations.",
                                            "type": "array",
                                            "items": {
                                              "description": "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>.",
                                              "type": "object",
                                              "properties": {
                                                "effect": {
                                                  "description": "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.",
                                                  "type": "string"
                                                },
                                                "key": {
                                                  "description": "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys.",
                                                  "type": "string"
                                                },
                                                "operator": {
                                                  "description": "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category.",
                                                  "type": "string"
                                                },
                                                "tolerationSeconds": {
                                                  "description": "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system.",
                                                  "type": "integer",
                                                  "format": "int64"
                                                },
                                                "value": {
                                                  "description": "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.",
                                                  "type": "string"
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  },
                                  "serviceType": {
                                    "description": "Optional service type for Kubernetes solver service",
                                    "type": "string"
                                  }
                                }
                              }
                            }
                          },
                          "selector": {
                            "description": "Selector selects a set of DNSNames on the Certificate resource that should be solved using this challenge solver.",
                            "type": "object",
                            "properties": {
                              "dnsNames": {
                                "description": "List of DNSNames that this solver will be used to solve. If specified and a match is found, a dnsNames selector will take precedence over a dnsZones selector. If multiple solvers match with the same dnsNames value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected.",
                                "type": "array",
                                "items": {
                                  "type": "string"
                                }
                              },
                              "dnsZones": {
                                "description": "List of DNSZones that this solver will be used to solve. The most specific DNS zone match specified here will take precedence over other DNS zone matches, so a solver specifying sys.example.com will be selected over one specifying example.com for the domain www.sys.example.com. If multiple solvers match with the same dnsZones value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected.",
                                "type": "array",
                                "items": {
                                  "type": "string"
                                }
                              },
                              "matchLabels": {
                                "description": "A label selector that is used to refine the set of certificate's that this challenge solver will apply to.",
                                "type": "object",
                                "additionalProperties": {
                                  "type": "string"
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                },
                "ca": {
                  "type": "object",
                  "required": [
                    "secretName"
                  ],
                  "properties": {
                    "secretName": {
                      "description": "SecretName is the name of the secret used to sign Certificates issued by this Issuer.",
                      "type": "string"
                    }
                  }
                },
                "selfSigned": {
                  "type": "object"
                },
                "vault": {
                  "type": "object",
                  "required": [
                    "auth",
                    "path",
                    "server"
                  ],
                  "properties": {
                    "auth": {
                      "description": "Vault authentication",
                      "type": "object",
                      "properties": {
                        "appRole": {
                          "description": "This Secret contains a AppRole and Secret",
                          "type": "object",
                          "required": [
                            "path",
                            "roleId",
                            "secretRef"
                          ],
                          "properties": {
                            "path": {
                              "description": "Where the authentication path is mounted in Vault.",
                              "type": "string"
                            },
                            "roleId": {
                              "type": "string"
                            },
                            "secretRef": {
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            }
                          }
                        },
                        "kubernetes": {
                          "description": "This contains a Role and Secret with a ServiceAccount token to authenticate with vault.",
                          "type": "object",
                          "required": [
                            "role",
                            "secretRef"
                          ],
                          "properties": {
                            "mountPath": {
                              "description": "The Vault mountPath here is the mount path to use when authenticating with Vault. For example, setting a value to `/v1/auth/foo`, will use the path `/v1/auth/foo/login` to authenticate with Vault. If unspecified, the default value \"/v1/auth/kubernetes\" will be used.",
                              "type": "string"
                            },
                            "role": {
                              "description": "A required field containing the Vault Role to assume. A Role binds a Kubernetes ServiceAccount with a set of Vault policies.",
                              "type": "string"
                            },
                            "secretRef": {
                              "description": "The required Secret field containing a Kubernetes ServiceAccount JWT used for authenticating with Vault. Use of 'ambient credentials' is not supported.",
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            }
                          }
                        },
                        "tokenSecretRef": {
                          "description": "This Secret contains the Vault token key",
                          "type": "object",
                          "required": [
                            "name"
                          ],
                          "properties": {
                            "key": {
                              "description": "The key of the secret to select from. Must be a valid secret key.",
                              "type": "string"
                            },
                            "name": {
                              "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                              "type": "string"
                            }
                          }
                        }
                      }
                    },
                    "caBundle": {
                      "description": "Base64 encoded CA bundle to validate Vault server certificate. Only used if the Server URL is using HTTPS protocol. This parameter is ignored for plain HTTP protocol connection. If not set the system root certificates are used to validate the TLS connection.",
                      "type": "string",
                      "format": "byte"
                    },
                    "path": {
                      "description": "Vault URL path to the certificate role",
                      "type": "string"
                    },
                    "server": {
                      "description": "Server is the vault connection address",
                      "type": "string"
                    }
                  }
                },
                "venafi": {
                  "description": "VenafiIssuer describes issuer configuration details for Venafi Cloud.",
                  "type": "object",
                  "required": [
                    "zone"
                  ],
                  "properties": {
                    "cloud": {
                      "description": "Cloud specifies the Venafi cloud configuration settings. Only one of TPP or Cloud may be specified.",
                      "type": "object",
                      "required": [
                        "apiTokenSecretRef"
                      ],
                      "properties": {
                        "apiTokenSecretRef": {
                          "description": "APITokenSecretRef is a secret key selector for the Venafi Cloud API token.",
                          "type": "object",
                          "required": [
                            "name"
                          ],
                          "properties": {
                            "key": {
                              "description": "The key of the secret to select from. Must be a valid secret key.",
                              "type": "string"
                            },
                            "name": {
                              "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                              "type": "string"
                            }
                          }
                        },
                        "url": {
                          "description": "URL is the base URL for Venafi Cloud",
                          "type": "string"
                        }
                      }
                    },
                    "tpp": {
                      "description": "TPP specifies Trust Protection Platform configuration settings. Only one of TPP or Cloud may be specified.",
                      "type": "object",
                      "required": [
                        "credentialsRef",
                        "url"
                      ],
                      "properties": {
                        "caBundle": {
                          "description": "CABundle is a PEM encoded TLS certifiate to use to verify connections to the TPP instance. If specified, system roots will not be used and the issuing CA for the TPP instance must be verifiable using the provided root. If not specified, the connection will be verified using the cert-manager system root certificates.",
                          "type": "string",
                          "format": "byte"
                        },
                        "credentialsRef": {
                          "description": "CredentialsRef is a reference to a Secret containing the username and password for the TPP server. The secret must contain two keys, 'username' and 'password'.",
                          "type": "object",
                          "required": [
                            "name"
                          ],
                          "properties": {
                            "name": {
                              "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                              "type": "string"
                            }
                          }
                        },
                        "url": {
                          "description": "URL is the base URL for the Venafi TPP instance",
                          "type": "string"
                        }
                      }
                    },
                    "zone": {
                      "description": "Zone is the Venafi Policy Zone to use for this issuer. All requests made to the Venafi platform will be restricted by the named zone policy. This field is required.",
                      "type": "string"
                    }
                  }
                }
              }
            },
            "status": {
              "description": "IssuerStatus contains status information about an Issuer",
              "type": "object",
              "properties": {
                "acme": {
                  "type": "object",
                  "properties": {
                    "lastRegisteredEmail": {
                      "description": "LastRegisteredEmail is the email associated with the latest registered ACME account, in order to track changes made to registered account associated with the  Issuer",
                      "type": "string"
                    },
                    "uri": {
                      "description": "URI is the unique account identifier, which can also be used to retrieve account details from the CA",
                      "type": "string"
                    }
                  }
                },
                "conditions": {
                  "type": "array",
                  "items": {
                    "description": "IssuerCondition contains condition information for an Issuer.",
                    "type": "object",
                    "required": [
                      "status",
                      "type"
                    ],
                    "properties": {
                      "lastTransitionTime": {
                        "description": "LastTransitionTime is the timestamp corresponding to the last status change of this condition.",
                        "type": "string",
                        "format": "date-time"
                      },
                      "message": {
                        "description": "Message is a human readable description of the details of the last transition, complementing reason.",
                        "type": "string"
                      },
                      "reason": {
                        "description": "Reason is a brief machine readable explanation for the condition's last transition.",
                        "type": "string"
                      },
                      "status": {
                        "description": "Status of the condition, one of ('True', 'False', 'Unknown').",
                        "type": "string",
                        "enum": [
                          "True",
                          "False",
                          "Unknown"
                        ]
                      },
                      "type": {
                        "description": "Type of the condition, currently ('Ready').",
                        "type": "string"
                      }
                    }
                  }
                }
              }
            }
          }
        }
      },
      "version": "v1alpha2",
      "versions": [
        {
          "name": "v1alpha2",
          "served": true,
          "storage": true
        }
      ]
    }
  },
  "cert-manager-4": {
    "apiVersion": "apiextensions.k8s.io/v1beta1",
    "kind": "CustomResourceDefinition",
    "metadata": {
      "name": "issuers.cert-manager.io"
    },
    "spec": {
      "additionalPrinterColumns": [
        {
          "JSONPath": ".status.conditions[?(@.type==\"Ready\")].status",
          "name": "Ready",
          "type": "string"
        },
        {
          "JSONPath": ".status.conditions[?(@.type==\"Ready\")].message",
          "name": "Status",
          "priority": 1,
          "type": "string"
        },
        {
          "JSONPath": ".metadata.creationTimestamp",
          "description": "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC.",
          "name": "Age",
          "type": "date"
        }
      ],
      "group": "cert-manager.io",
      "preserveUnknownFields": false,
      "names": {
        "kind": "Issuer",
        "listKind": "IssuerList",
        "plural": "issuers",
        "singular": "issuer"
      },
      "scope": "Namespaced",
      "subresources": {
        "status": {}
      },
      "validation": {
        "openAPIV3Schema": {
          "type": "object",
          "properties": {
            "apiVersion": {
              "description": "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources",
              "type": "string"
            },
            "kind": {
              "description": "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds",
              "type": "string"
            },
            "metadata": {
              "type": "object"
            },
            "spec": {
              "description": "IssuerSpec is the specification of an Issuer. This includes any configuration required for the issuer.",
              "type": "object",
              "properties": {
                "acme": {
                  "description": "ACMEIssuer contains the specification for an ACME issuer",
                  "type": "object",
                  "required": [
                    "privateKeySecretRef",
                    "server"
                  ],
                  "properties": {
                    "email": {
                      "description": "Email is the email for this account",
                      "type": "string"
                    },
                    "externalAccountBinding": {
                      "description": "ExternalAcccountBinding is a reference to a CA external account of the ACME server.",
                      "type": "object",
                      "required": [
                        "keyAlgorithm",
                        "keyID",
                        "keySecretRef"
                      ],
                      "properties": {
                        "keyAlgorithm": {
                          "description": "keyAlgorithm is the MAC key algorithm that the key is used for. Valid values are \"HS256\", \"HS384\" and \"HS512\".",
                          "type": "string",
                          "enum": [
                            "HS256",
                            "HS384",
                            "HS512"
                          ]
                        },
                        "keyID": {
                          "description": "keyID is the ID of the CA key that the External Account is bound to.",
                          "type": "string"
                        },
                        "keySecretRef": {
                          "description": "keySecretRef is a Secret Key Selector referencing a data item in a Kubernetes Secret which holds the symmetric MAC key of the External Account Binding. The `key` is the index string that is paired with the key data in the Secret and should not be confused with the key data itself, or indeed with the External Account Binding keyID above. The secret key stored in the Secret **must** be un-padded, base64 URL encoded data.",
                          "type": "object",
                          "required": [
                            "name"
                          ],
                          "properties": {
                            "key": {
                              "description": "The key of the secret to select from. Must be a valid secret key.",
                              "type": "string"
                            },
                            "name": {
                              "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                              "type": "string"
                            }
                          }
                        }
                      }
                    },
                    "privateKeySecretRef": {
                      "description": "PrivateKey is the name of a secret containing the private key for this user account.",
                      "type": "object",
                      "required": [
                        "name"
                      ],
                      "properties": {
                        "key": {
                          "description": "The key of the secret to select from. Must be a valid secret key.",
                          "type": "string"
                        },
                        "name": {
                          "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                          "type": "string"
                        }
                      }
                    },
                    "server": {
                      "description": "Server is the ACME server URL",
                      "type": "string"
                    },
                    "skipTLSVerify": {
                      "description": "If true, skip verifying the ACME server TLS certificate",
                      "type": "boolean"
                    },
                    "solvers": {
                      "description": "Solvers is a list of challenge solvers that will be used to solve ACME challenges for the matching domains.",
                      "type": "array",
                      "items": {
                        "type": "object",
                        "properties": {
                          "dns01": {
                            "type": "object",
                            "properties": {
                              "acmedns": {
                                "description": "ACMEIssuerDNS01ProviderAcmeDNS is a structure containing the configuration for ACME-DNS servers",
                                "type": "object",
                                "required": [
                                  "accountSecretRef",
                                  "host"
                                ],
                                "properties": {
                                  "accountSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "host": {
                                    "type": "string"
                                  }
                                }
                              },
                              "akamai": {
                                "description": "ACMEIssuerDNS01ProviderAkamai is a structure containing the DNS configuration for Akamai DNS\u2014Zone Record Management API",
                                "type": "object",
                                "required": [
                                  "accessTokenSecretRef",
                                  "clientSecretSecretRef",
                                  "clientTokenSecretRef",
                                  "serviceConsumerDomain"
                                ],
                                "properties": {
                                  "accessTokenSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "clientSecretSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "clientTokenSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "serviceConsumerDomain": {
                                    "type": "string"
                                  }
                                }
                              },
                              "azuredns": {
                                "description": "ACMEIssuerDNS01ProviderAzureDNS is a structure containing the configuration for Azure DNS",
                                "type": "object",
                                "required": [
                                  "clientID",
                                  "clientSecretSecretRef",
                                  "resourceGroupName",
                                  "subscriptionID",
                                  "tenantID"
                                ],
                                "properties": {
                                  "clientID": {
                                    "type": "string"
                                  },
                                  "clientSecretSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "environment": {
                                    "type": "string",
                                    "enum": [
                                      "AzurePublicCloud",
                                      "AzureChinaCloud",
                                      "AzureGermanCloud",
                                      "AzureUSGovernmentCloud"
                                    ]
                                  },
                                  "hostedZoneName": {
                                    "type": "string"
                                  },
                                  "resourceGroupName": {
                                    "type": "string"
                                  },
                                  "subscriptionID": {
                                    "type": "string"
                                  },
                                  "tenantID": {
                                    "type": "string"
                                  }
                                }
                              },
                              "clouddns": {
                                "description": "ACMEIssuerDNS01ProviderCloudDNS is a structure containing the DNS configuration for Google Cloud DNS",
                                "type": "object",
                                "required": [
                                  "project"
                                ],
                                "properties": {
                                  "project": {
                                    "type": "string"
                                  },
                                  "serviceAccountSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  }
                                }
                              },
                              "cloudflare": {
                                "description": "ACMEIssuerDNS01ProviderCloudflare is a structure containing the DNS configuration for Cloudflare",
                                "type": "object",
                                "required": [
                                  "email"
                                ],
                                "properties": {
                                  "apiKeySecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "apiTokenSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  },
                                  "email": {
                                    "type": "string"
                                  }
                                }
                              },
                              "cnameStrategy": {
                                "description": "CNAMEStrategy configures how the DNS01 provider should handle CNAME records when found in DNS zones.",
                                "type": "string",
                                "enum": [
                                  "None",
                                  "Follow"
                                ]
                              },
                              "digitalocean": {
                                "description": "ACMEIssuerDNS01ProviderDigitalOcean is a structure containing the DNS configuration for DigitalOcean Domains",
                                "type": "object",
                                "required": [
                                  "tokenSecretRef"
                                ],
                                "properties": {
                                  "tokenSecretRef": {
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  }
                                }
                              },
                              "rfc2136": {
                                "description": "ACMEIssuerDNS01ProviderRFC2136 is a structure containing the configuration for RFC2136 DNS",
                                "type": "object",
                                "required": [
                                  "nameserver"
                                ],
                                "properties": {
                                  "nameserver": {
                                    "description": "The IP address of the DNS supporting RFC2136. Required. Note: FQDN is not a valid value, only IP.",
                                    "type": "string"
                                  },
                                  "tsigAlgorithm": {
                                    "description": "The TSIG Algorithm configured in the DNS supporting RFC2136. Used only when ``tsigSecretSecretRef`` and ``tsigKeyName`` are defined. Supported values are (case-insensitive): ``HMACMD5`` (default), ``HMACSHA1``, ``HMACSHA256`` or ``HMACSHA512``.",
                                    "type": "string"
                                  },
                                  "tsigKeyName": {
                                    "description": "The TSIG Key name configured in the DNS. If ``tsigSecretSecretRef`` is defined, this field is required.",
                                    "type": "string"
                                  },
                                  "tsigSecretSecretRef": {
                                    "description": "The name of the secret containing the TSIG value. If ``tsigKeyName`` is defined, this field is required.",
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  }
                                }
                              },
                              "route53": {
                                "description": "ACMEIssuerDNS01ProviderRoute53 is a structure containing the Route 53 configuration for AWS",
                                "type": "object",
                                "required": [
                                  "region"
                                ],
                                "properties": {
                                  "accessKeyID": {
                                    "description": "The AccessKeyID is used for authentication. If not set we fall-back to using env vars, shared credentials file or AWS Instance metadata see: https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials",
                                    "type": "string"
                                  },
                                  "hostedZoneID": {
                                    "description": "If set, the provider will manage only this zone in Route53 and will not do an lookup using the route53:ListHostedZonesByName api call.",
                                    "type": "string"
                                  },
                                  "region": {
                                    "description": "Always set the region when using AccessKeyID and SecretAccessKey",
                                    "type": "string"
                                  },
                                  "role": {
                                    "description": "Role is a Role ARN which the Route53 provider will assume using either the explicit credentials AccessKeyID/SecretAccessKey or the inferred credentials from environment variables, shared credentials file or AWS Instance metadata",
                                    "type": "string"
                                  },
                                  "secretAccessKeySecretRef": {
                                    "description": "The SecretAccessKey is used for authentication. If not set we fall-back to using env vars, shared credentials file or AWS Instance metadata https://docs.aws.amazon.com/sdk-for-go/v1/developer-guide/configuring-sdk.html#specifying-credentials",
                                    "type": "object",
                                    "required": [
                                      "name"
                                    ],
                                    "properties": {
                                      "key": {
                                        "description": "The key of the secret to select from. Must be a valid secret key.",
                                        "type": "string"
                                      },
                                      "name": {
                                        "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                        "type": "string"
                                      }
                                    }
                                  }
                                }
                              },
                              "webhook": {
                                "description": "ACMEIssuerDNS01ProviderWebhook specifies configuration for a webhook DNS01 provider, including where to POST ChallengePayload resources.",
                                "type": "object",
                                "required": [
                                  "groupName",
                                  "solverName"
                                ],
                                "properties": {
                                  "config": {
                                    "description": "Additional configuration that should be passed to the webhook apiserver when challenges are processed. This can contain arbitrary JSON data. Secret values should not be specified in this stanza. If secret values are needed (e.g. credentials for a DNS service), you should use a SecretKeySelector to reference a Secret resource. For details on the schema of this field, consult the webhook provider implementation's documentation.",
                                    "x-kubernetes-preserve-unknown-fields": true
                                  },
                                  "groupName": {
                                    "description": "The API group name that should be used when POSTing ChallengePayload resources to the webhook apiserver. This should be the same as the GroupName specified in the webhook provider implementation.",
                                    "type": "string"
                                  },
                                  "solverName": {
                                    "description": "The name of the solver to use, as defined in the webhook provider implementation. This will typically be the name of the provider, e.g. 'cloudflare'.",
                                    "type": "string"
                                  }
                                }
                              }
                            }
                          },
                          "http01": {
                            "description": "ACMEChallengeSolverHTTP01 contains configuration detailing how to solve HTTP01 challenges within a Kubernetes cluster. Typically this is accomplished through creating 'routes' of some description that configure ingress controllers to direct traffic to 'solver pods', which are responsible for responding to the ACME server's HTTP requests.",
                            "type": "object",
                            "properties": {
                              "ingress": {
                                "description": "The ingress based HTTP01 challenge solver will solve challenges by creating or modifying Ingress resources in order to route requests for '/.well-known/acme-challenge/XYZ' to 'challenge solver' pods that are provisioned by cert-manager for each Challenge to be completed.",
                                "type": "object",
                                "properties": {
                                  "class": {
                                    "description": "The ingress class to use when creating Ingress resources to solve ACME challenges that use this challenge solver. Only one of 'class' or 'name' may be specified.",
                                    "type": "string"
                                  },
                                  "name": {
                                    "description": "The name of the ingress resource that should have ACME challenge solving routes inserted into it in order to solve HTTP01 challenges. This is typically used in conjunction with ingress controllers like ingress-gce, which maintains a 1:1 mapping between external IPs and ingress resources.",
                                    "type": "string"
                                  },
                                  "podTemplate": {
                                    "description": "Optional pod template used to configure the ACME challenge solver pods used for HTTP01 challenges",
                                    "type": "object",
                                    "properties": {
                                      "metadata": {
                                        "description": "ObjectMeta overrides for the pod used to solve HTTP01 challenges. Only the 'labels' and 'annotations' fields may be set. If labels or annotations overlap with in-built values, the values here will override the in-built values.",
                                        "type": "object",
                                        "properties": {
                                          "annotations": {
                                            "description": "Annotations that should be added to the create ACME HTTP01 solver pods.",
                                            "type": "object",
                                            "additionalProperties": {
                                              "type": "string"
                                            }
                                          },
                                          "labels": {
                                            "description": "Labels that should be added to the created ACME HTTP01 solver pods.",
                                            "type": "object",
                                            "additionalProperties": {
                                              "type": "string"
                                            }
                                          }
                                        }
                                      },
                                      "spec": {
                                        "description": "PodSpec defines overrides for the HTTP01 challenge solver pod. Only the 'nodeSelector', 'affinity' and 'tolerations' fields are supported currently. All other fields will be ignored.",
                                        "type": "object",
                                        "properties": {
                                          "affinity": {
                                            "description": "If specified, the pod's scheduling constraints",
                                            "type": "object",
                                            "properties": {
                                              "nodeAffinity": {
                                                "description": "Describes node affinity scheduling rules for the pod.",
                                                "type": "object",
                                                "properties": {
                                                  "preferredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node matches the corresponding matchExpressions; the node(s) with the highest sum are the most preferred.",
                                                    "type": "array",
                                                    "items": {
                                                      "description": "An empty preferred scheduling term matches all objects with implicit weight 0 (i.e. it's a no-op). A null preferred scheduling term matches no objects (i.e. is also a no-op).",
                                                      "type": "object",
                                                      "required": [
                                                        "preference",
                                                        "weight"
                                                      ],
                                                      "properties": {
                                                        "preference": {
                                                          "description": "A node selector term, associated with the corresponding weight.",
                                                          "type": "object",
                                                          "properties": {
                                                            "matchExpressions": {
                                                              "description": "A list of node selector requirements by node's labels.",
                                                              "type": "array",
                                                              "items": {
                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "type": "object",
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "The label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                    "type": "array",
                                                                    "items": {
                                                                      "type": "string"
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            "matchFields": {
                                                              "description": "A list of node selector requirements by node's fields.",
                                                              "type": "array",
                                                              "items": {
                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "type": "object",
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "The label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                    "type": "array",
                                                                    "items": {
                                                                      "type": "string"
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          }
                                                        },
                                                        "weight": {
                                                          "description": "Weight associated with matching the corresponding nodeSelectorTerm, in the range 1-100.",
                                                          "type": "integer",
                                                          "format": "int32"
                                                        }
                                                      }
                                                    }
                                                  },
                                                  "requiredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to an update), the system may or may not try to eventually evict the pod from its node.",
                                                    "type": "object",
                                                    "required": [
                                                      "nodeSelectorTerms"
                                                    ],
                                                    "properties": {
                                                      "nodeSelectorTerms": {
                                                        "description": "Required. A list of node selector terms. The terms are ORed.",
                                                        "type": "array",
                                                        "items": {
                                                          "description": "A null or empty node selector term matches no objects. The requirements of them are ANDed. The TopologySelectorTerm type implements a subset of the NodeSelectorTerm.",
                                                          "type": "object",
                                                          "properties": {
                                                            "matchExpressions": {
                                                              "description": "A list of node selector requirements by node's labels.",
                                                              "type": "array",
                                                              "items": {
                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "type": "object",
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "The label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                    "type": "array",
                                                                    "items": {
                                                                      "type": "string"
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            "matchFields": {
                                                              "description": "A list of node selector requirements by node's fields.",
                                                              "type": "array",
                                                              "items": {
                                                                "description": "A node selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "type": "object",
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "The label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "Represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists, DoesNotExist. Gt, and Lt.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "An array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. If the operator is Gt or Lt, the values array must have a single element, which will be interpreted as an integer. This array is replaced during a strategic merge patch.",
                                                                    "type": "array",
                                                                    "items": {
                                                                      "type": "string"
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
                                                          }
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              },
                                              "podAffinity": {
                                                "description": "Describes pod affinity scheduling rules (e.g. co-locate this pod in the same node, zone, etc. as some other pod(s)).",
                                                "type": "object",
                                                "properties": {
                                                  "preferredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "The scheduler will prefer to schedule pods to nodes that satisfy the affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.",
                                                    "type": "array",
                                                    "items": {
                                                      "description": "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)",
                                                      "type": "object",
                                                      "required": [
                                                        "podAffinityTerm",
                                                        "weight"
                                                      ],
                                                      "properties": {
                                                        "podAffinityTerm": {
                                                          "description": "Required. A pod affinity term, associated with the corresponding weight.",
                                                          "type": "object",
                                                          "required": [
                                                            "topologyKey"
                                                          ],
                                                          "properties": {
                                                            "labelSelector": {
                                                              "description": "A label query over a set of resources, in this case pods.",
                                                              "type": "object",
                                                              "properties": {
                                                                "matchExpressions": {
                                                                  "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                                  "type": "array",
                                                                  "items": {
                                                                    "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                    "type": "object",
                                                                    "required": [
                                                                      "key",
                                                                      "operator"
                                                                    ],
                                                                    "properties": {
                                                                      "key": {
                                                                        "description": "key is the label key that the selector applies to.",
                                                                        "type": "string"
                                                                      },
                                                                      "operator": {
                                                                        "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                        "type": "string"
                                                                      },
                                                                      "values": {
                                                                        "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                        "type": "array",
                                                                        "items": {
                                                                          "type": "string"
                                                                        }
                                                                      }
                                                                    }
                                                                  }
                                                                },
                                                                "matchLabels": {
                                                                  "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                                  "type": "object",
                                                                  "additionalProperties": {
                                                                    "type": "string"
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            "namespaces": {
                                                              "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                              "type": "array",
                                                              "items": {
                                                                "type": "string"
                                                              }
                                                            },
                                                            "topologyKey": {
                                                              "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                              "type": "string"
                                                            }
                                                          }
                                                        },
                                                        "weight": {
                                                          "description": "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.",
                                                          "type": "integer",
                                                          "format": "int32"
                                                        }
                                                      }
                                                    }
                                                  },
                                                  "requiredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "If the affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.",
                                                    "type": "array",
                                                    "items": {
                                                      "description": "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running",
                                                      "type": "object",
                                                      "required": [
                                                        "topologyKey"
                                                      ],
                                                      "properties": {
                                                        "labelSelector": {
                                                          "description": "A label query over a set of resources, in this case pods.",
                                                          "type": "object",
                                                          "properties": {
                                                            "matchExpressions": {
                                                              "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                              "type": "array",
                                                              "items": {
                                                                "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "type": "object",
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "key is the label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                    "type": "array",
                                                                    "items": {
                                                                      "type": "string"
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            "matchLabels": {
                                                              "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                              "type": "object",
                                                              "additionalProperties": {
                                                                "type": "string"
                                                              }
                                                            }
                                                          }
                                                        },
                                                        "namespaces": {
                                                          "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                          "type": "array",
                                                          "items": {
                                                            "type": "string"
                                                          }
                                                        },
                                                        "topologyKey": {
                                                          "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                          "type": "string"
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              },
                                              "podAntiAffinity": {
                                                "description": "Describes pod anti-affinity scheduling rules (e.g. avoid putting this pod in the same node, zone, etc. as some other pod(s)).",
                                                "type": "object",
                                                "properties": {
                                                  "preferredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "The scheduler will prefer to schedule pods to nodes that satisfy the anti-affinity expressions specified by this field, but it may choose a node that violates one or more of the expressions. The node that is most preferred is the one with the greatest sum of weights, i.e. for each node that meets all of the scheduling requirements (resource request, requiredDuringScheduling anti-affinity expressions, etc.), compute a sum by iterating through the elements of this field and adding \"weight\" to the sum if the node has pods which matches the corresponding podAffinityTerm; the node(s) with the highest sum are the most preferred.",
                                                    "type": "array",
                                                    "items": {
                                                      "description": "The weights of all of the matched WeightedPodAffinityTerm fields are added per-node to find the most preferred node(s)",
                                                      "type": "object",
                                                      "required": [
                                                        "podAffinityTerm",
                                                        "weight"
                                                      ],
                                                      "properties": {
                                                        "podAffinityTerm": {
                                                          "description": "Required. A pod affinity term, associated with the corresponding weight.",
                                                          "type": "object",
                                                          "required": [
                                                            "topologyKey"
                                                          ],
                                                          "properties": {
                                                            "labelSelector": {
                                                              "description": "A label query over a set of resources, in this case pods.",
                                                              "type": "object",
                                                              "properties": {
                                                                "matchExpressions": {
                                                                  "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                                  "type": "array",
                                                                  "items": {
                                                                    "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                    "type": "object",
                                                                    "required": [
                                                                      "key",
                                                                      "operator"
                                                                    ],
                                                                    "properties": {
                                                                      "key": {
                                                                        "description": "key is the label key that the selector applies to.",
                                                                        "type": "string"
                                                                      },
                                                                      "operator": {
                                                                        "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                        "type": "string"
                                                                      },
                                                                      "values": {
                                                                        "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                        "type": "array",
                                                                        "items": {
                                                                          "type": "string"
                                                                        }
                                                                      }
                                                                    }
                                                                  }
                                                                },
                                                                "matchLabels": {
                                                                  "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                                  "type": "object",
                                                                  "additionalProperties": {
                                                                    "type": "string"
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            "namespaces": {
                                                              "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                              "type": "array",
                                                              "items": {
                                                                "type": "string"
                                                              }
                                                            },
                                                            "topologyKey": {
                                                              "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                              "type": "string"
                                                            }
                                                          }
                                                        },
                                                        "weight": {
                                                          "description": "weight associated with matching the corresponding podAffinityTerm, in the range 1-100.",
                                                          "type": "integer",
                                                          "format": "int32"
                                                        }
                                                      }
                                                    }
                                                  },
                                                  "requiredDuringSchedulingIgnoredDuringExecution": {
                                                    "description": "If the anti-affinity requirements specified by this field are not met at scheduling time, the pod will not be scheduled onto the node. If the anti-affinity requirements specified by this field cease to be met at some point during pod execution (e.g. due to a pod label update), the system may or may not try to eventually evict the pod from its node. When there are multiple elements, the lists of nodes corresponding to each podAffinityTerm are intersected, i.e. all terms must be satisfied.",
                                                    "type": "array",
                                                    "items": {
                                                      "description": "Defines a set of pods (namely those matching the labelSelector relative to the given namespace(s)) that this pod should be co-located (affinity) or not co-located (anti-affinity) with, where co-located is defined as running on a node whose value of the label with key <topologyKey> matches that of any node on which a pod of the set of pods is running",
                                                      "type": "object",
                                                      "required": [
                                                        "topologyKey"
                                                      ],
                                                      "properties": {
                                                        "labelSelector": {
                                                          "description": "A label query over a set of resources, in this case pods.",
                                                          "type": "object",
                                                          "properties": {
                                                            "matchExpressions": {
                                                              "description": "matchExpressions is a list of label selector requirements. The requirements are ANDed.",
                                                              "type": "array",
                                                              "items": {
                                                                "description": "A label selector requirement is a selector that contains values, a key, and an operator that relates the key and values.",
                                                                "type": "object",
                                                                "required": [
                                                                  "key",
                                                                  "operator"
                                                                ],
                                                                "properties": {
                                                                  "key": {
                                                                    "description": "key is the label key that the selector applies to.",
                                                                    "type": "string"
                                                                  },
                                                                  "operator": {
                                                                    "description": "operator represents a key's relationship to a set of values. Valid operators are In, NotIn, Exists and DoesNotExist.",
                                                                    "type": "string"
                                                                  },
                                                                  "values": {
                                                                    "description": "values is an array of string values. If the operator is In or NotIn, the values array must be non-empty. If the operator is Exists or DoesNotExist, the values array must be empty. This array is replaced during a strategic merge patch.",
                                                                    "type": "array",
                                                                    "items": {
                                                                      "type": "string"
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            },
                                                            "matchLabels": {
                                                              "description": "matchLabels is a map of {key,value} pairs. A single {key,value} in the matchLabels map is equivalent to an element of matchExpressions, whose key field is \"key\", the operator is \"In\", and the values array contains only \"value\". The requirements are ANDed.",
                                                              "type": "object",
                                                              "additionalProperties": {
                                                                "type": "string"
                                                              }
                                                            }
                                                          }
                                                        },
                                                        "namespaces": {
                                                          "description": "namespaces specifies which namespaces the labelSelector applies to (matches against); null or empty list means \"this pod's namespace\"",
                                                          "type": "array",
                                                          "items": {
                                                            "type": "string"
                                                          }
                                                        },
                                                        "topologyKey": {
                                                          "description": "This pod should be co-located (affinity) or not co-located (anti-affinity) with the pods matching the labelSelector in the specified namespaces, where co-located is defined as running on a node whose value of the label with key topologyKey matches that of any node on which any of the selected pods is running. Empty topologyKey is not allowed.",
                                                          "type": "string"
                                                        }
                                                      }
                                                    }
                                                  }
                                                }
                                              }
                                            }
                                          },
                                          "nodeSelector": {
                                            "description": "NodeSelector is a selector which must be true for the pod to fit on a node. Selector which must match a node's labels for the pod to be scheduled on that node. More info: https://kubernetes.io/docs/concepts/configuration/assign-pod-node/",
                                            "type": "object",
                                            "additionalProperties": {
                                              "type": "string"
                                            }
                                          },
                                          "tolerations": {
                                            "description": "If specified, the pod's tolerations.",
                                            "type": "array",
                                            "items": {
                                              "description": "The pod this Toleration is attached to tolerates any taint that matches the triple <key,value,effect> using the matching operator <operator>.",
                                              "type": "object",
                                              "properties": {
                                                "effect": {
                                                  "description": "Effect indicates the taint effect to match. Empty means match all taint effects. When specified, allowed values are NoSchedule, PreferNoSchedule and NoExecute.",
                                                  "type": "string"
                                                },
                                                "key": {
                                                  "description": "Key is the taint key that the toleration applies to. Empty means match all taint keys. If the key is empty, operator must be Exists; this combination means to match all values and all keys.",
                                                  "type": "string"
                                                },
                                                "operator": {
                                                  "description": "Operator represents a key's relationship to the value. Valid operators are Exists and Equal. Defaults to Equal. Exists is equivalent to wildcard for value, so that a pod can tolerate all taints of a particular category.",
                                                  "type": "string"
                                                },
                                                "tolerationSeconds": {
                                                  "description": "TolerationSeconds represents the period of time the toleration (which must be of effect NoExecute, otherwise this field is ignored) tolerates the taint. By default, it is not set, which means tolerate the taint forever (do not evict). Zero and negative values will be treated as 0 (evict immediately) by the system.",
                                                  "type": "integer",
                                                  "format": "int64"
                                                },
                                                "value": {
                                                  "description": "Value is the taint value the toleration matches to. If the operator is Exists, the value should be empty, otherwise just a regular string.",
                                                  "type": "string"
                                                }
                                              }
                                            }
                                          }
                                        }
                                      }
                                    }
                                  },
                                  "serviceType": {
                                    "description": "Optional service type for Kubernetes solver service",
                                    "type": "string"
                                  }
                                }
                              }
                            }
                          },
                          "selector": {
                            "description": "Selector selects a set of DNSNames on the Certificate resource that should be solved using this challenge solver.",
                            "type": "object",
                            "properties": {
                              "dnsNames": {
                                "description": "List of DNSNames that this solver will be used to solve. If specified and a match is found, a dnsNames selector will take precedence over a dnsZones selector. If multiple solvers match with the same dnsNames value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected.",
                                "type": "array",
                                "items": {
                                  "type": "string"
                                }
                              },
                              "dnsZones": {
                                "description": "List of DNSZones that this solver will be used to solve. The most specific DNS zone match specified here will take precedence over other DNS zone matches, so a solver specifying sys.example.com will be selected over one specifying example.com for the domain www.sys.example.com. If multiple solvers match with the same dnsZones value, the solver with the most matching labels in matchLabels will be selected. If neither has more matches, the solver defined earlier in the list will be selected.",
                                "type": "array",
                                "items": {
                                  "type": "string"
                                }
                              },
                              "matchLabels": {
                                "description": "A label selector that is used to refine the set of certificate's that this challenge solver will apply to.",
                                "type": "object",
                                "additionalProperties": {
                                  "type": "string"
                                }
                              }
                            }
                          }
                        }
                      }
                    }
                  }
                },
                "ca": {
                  "type": "object",
                  "required": [
                    "secretName"
                  ],
                  "properties": {
                    "secretName": {
                      "description": "SecretName is the name of the secret used to sign Certificates issued by this Issuer.",
                      "type": "string"
                    }
                  }
                },
                "selfSigned": {
                  "type": "object"
                },
                "vault": {
                  "type": "object",
                  "required": [
                    "auth",
                    "path",
                    "server"
                  ],
                  "properties": {
                    "auth": {
                      "description": "Vault authentication",
                      "type": "object",
                      "properties": {
                        "appRole": {
                          "description": "This Secret contains a AppRole and Secret",
                          "type": "object",
                          "required": [
                            "path",
                            "roleId",
                            "secretRef"
                          ],
                          "properties": {
                            "path": {
                              "description": "Where the authentication path is mounted in Vault.",
                              "type": "string"
                            },
                            "roleId": {
                              "type": "string"
                            },
                            "secretRef": {
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            }
                          }
                        },
                        "kubernetes": {
                          "description": "This contains a Role and Secret with a ServiceAccount token to authenticate with vault.",
                          "type": "object",
                          "required": [
                            "role",
                            "secretRef"
                          ],
                          "properties": {
                            "mountPath": {
                              "description": "The Vault mountPath here is the mount path to use when authenticating with Vault. For example, setting a value to `/v1/auth/foo`, will use the path `/v1/auth/foo/login` to authenticate with Vault. If unspecified, the default value \"/v1/auth/kubernetes\" will be used.",
                              "type": "string"
                            },
                            "role": {
                              "description": "A required field containing the Vault Role to assume. A Role binds a Kubernetes ServiceAccount with a set of Vault policies.",
                              "type": "string"
                            },
                            "secretRef": {
                              "description": "The required Secret field containing a Kubernetes ServiceAccount JWT used for authenticating with Vault. Use of 'ambient credentials' is not supported.",
                              "type": "object",
                              "required": [
                                "name"
                              ],
                              "properties": {
                                "key": {
                                  "description": "The key of the secret to select from. Must be a valid secret key.",
                                  "type": "string"
                                },
                                "name": {
                                  "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                                  "type": "string"
                                }
                              }
                            }
                          }
                        },
                        "tokenSecretRef": {
                          "description": "This Secret contains the Vault token key",
                          "type": "object",
                          "required": [
                            "name"
                          ],
                          "properties": {
                            "key": {
                              "description": "The key of the secret to select from. Must be a valid secret key.",
                              "type": "string"
                            },
                            "name": {
                              "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                              "type": "string"
                            }
                          }
                        }
                      }
                    },
                    "caBundle": {
                      "description": "Base64 encoded CA bundle to validate Vault server certificate. Only used if the Server URL is using HTTPS protocol. This parameter is ignored for plain HTTP protocol connection. If not set the system root certificates are used to validate the TLS connection.",
                      "type": "string",
                      "format": "byte"
                    },
                    "path": {
                      "description": "Vault URL path to the certificate role",
                      "type": "string"
                    },
                    "server": {
                      "description": "Server is the vault connection address",
                      "type": "string"
                    }
                  }
                },
                "venafi": {
                  "description": "VenafiIssuer describes issuer configuration details for Venafi Cloud.",
                  "type": "object",
                  "required": [
                    "zone"
                  ],
                  "properties": {
                    "cloud": {
                      "description": "Cloud specifies the Venafi cloud configuration settings. Only one of TPP or Cloud may be specified.",
                      "type": "object",
                      "required": [
                        "apiTokenSecretRef"
                      ],
                      "properties": {
                        "apiTokenSecretRef": {
                          "description": "APITokenSecretRef is a secret key selector for the Venafi Cloud API token.",
                          "type": "object",
                          "required": [
                            "name"
                          ],
                          "properties": {
                            "key": {
                              "description": "The key of the secret to select from. Must be a valid secret key.",
                              "type": "string"
                            },
                            "name": {
                              "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                              "type": "string"
                            }
                          }
                        },
                        "url": {
                          "description": "URL is the base URL for Venafi Cloud",
                          "type": "string"
                        }
                      }
                    },
                    "tpp": {
                      "description": "TPP specifies Trust Protection Platform configuration settings. Only one of TPP or Cloud may be specified.",
                      "type": "object",
                      "required": [
                        "credentialsRef",
                        "url"
                      ],
                      "properties": {
                        "caBundle": {
                          "description": "CABundle is a PEM encoded TLS certifiate to use to verify connections to the TPP instance. If specified, system roots will not be used and the issuing CA for the TPP instance must be verifiable using the provided root. If not specified, the connection will be verified using the cert-manager system root certificates.",
                          "type": "string",
                          "format": "byte"
                        },
                        "credentialsRef": {
                          "description": "CredentialsRef is a reference to a Secret containing the username and password for the TPP server. The secret must contain two keys, 'username' and 'password'.",
                          "type": "object",
                          "required": [
                            "name"
                          ],
                          "properties": {
                            "name": {
                              "description": "Name of the referent. More info: https://kubernetes.io/docs/concepts/overview/working-with-objects/names/#names TODO: Add other useful fields. apiVersion, kind, uid?",
                              "type": "string"
                            }
                          }
                        },
                        "url": {
                          "description": "URL is the base URL for the Venafi TPP instance",
                          "type": "string"
                        }
                      }
                    },
                    "zone": {
                      "description": "Zone is the Venafi Policy Zone to use for this issuer. All requests made to the Venafi platform will be restricted by the named zone policy. This field is required.",
                      "type": "string"
                    }
                  }
                }
              }
            },
            "status": {
              "description": "IssuerStatus contains status information about an Issuer",
              "type": "object",
              "properties": {
                "acme": {
                  "type": "object",
                  "properties": {
                    "lastRegisteredEmail": {
                      "description": "LastRegisteredEmail is the email associated with the latest registered ACME account, in order to track changes made to registered account associated with the  Issuer",
                      "type": "string"
                    },
                    "uri": {
                      "description": "URI is the unique account identifier, which can also be used to retrieve account details from the CA",
                      "type": "string"
                    }
                  }
                },
                "conditions": {
                  "type": "array",
                  "items": {
                    "description": "IssuerCondition contains condition information for an Issuer.",
                    "type": "object",
                    "required": [
                      "status",
                      "type"
                    ],
                    "properties": {
                      "lastTransitionTime": {
                        "description": "LastTransitionTime is the timestamp corresponding to the last status change of this condition.",
                        "type": "string",
                        "format": "date-time"
                      },
                      "message": {
                        "description": "Message is a human readable description of the details of the last transition, complementing reason.",
                        "type": "string"
                      },
                      "reason": {
                        "description": "Reason is a brief machine readable explanation for the condition's last transition.",
                        "type": "string"
                      },
                      "status": {
                        "description": "Status of the condition, one of ('True', 'False', 'Unknown').",
                        "type": "string",
                        "enum": [
                          "True",
                          "False",
                          "Unknown"
                        ]
                      },
                      "type": {
                        "description": "Type of the condition, currently ('Ready').",
                        "type": "string"
                      }
                    }
                  }
                }
              }
            }
          }
        }
      },
      "version": "v1alpha2",
      "versions": [
        {
          "name": "v1alpha2",
          "served": true,
          "storage": true
        }
      ]
    }
  },
  "cert-manager-5": {
    "apiVersion": "apiextensions.k8s.io/v1beta1",
    "kind": "CustomResourceDefinition",
    "metadata": {
      "name": "orders.acme.cert-manager.io"
    },
    "spec": {
      "additionalPrinterColumns": [
        {
          "JSONPath": ".status.state",
          "name": "State",
          "type": "string"
        },
        {
          "JSONPath": ".spec.issuerRef.name",
          "name": "Issuer",
          "priority": 1,
          "type": "string"
        },
        {
          "JSONPath": ".status.reason",
          "name": "Reason",
          "priority": 1,
          "type": "string"
        },
        {
          "JSONPath": ".metadata.creationTimestamp",
          "description": "CreationTimestamp is a timestamp representing the server time when this object was created. It is not guaranteed to be set in happens-before order across separate operations. Clients may not set this value. It is represented in RFC3339 form and is in UTC.",
          "name": "Age",
          "type": "date"
        }
      ],
      "group": "acme.cert-manager.io",
      "preserveUnknownFields": false,
      "names": {
        "kind": "Order",
        "listKind": "OrderList",
        "plural": "orders",
        "singular": "order"
      },
      "scope": "Namespaced",
      "subresources": {
        "status": {}
      },
      "validation": {
        "openAPIV3Schema": {
          "description": "Order is a type to represent an Order with an ACME server",
          "type": "object",
          "required": [
            "metadata"
          ],
          "properties": {
            "apiVersion": {
              "description": "APIVersion defines the versioned schema of this representation of an object. Servers should convert recognized schemas to the latest internal value, and may reject unrecognized values. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#resources",
              "type": "string"
            },
            "kind": {
              "description": "Kind is a string value representing the REST resource this object represents. Servers may infer this from the endpoint the client submits requests to. Cannot be updated. In CamelCase. More info: https://git.k8s.io/community/contributors/devel/sig-architecture/api-conventions.md#types-kinds",
              "type": "string"
            },
            "metadata": {
              "type": "object"
            },
            "spec": {
              "type": "object",
              "required": [
                "csr",
                "issuerRef"
              ],
              "properties": {
                "commonName": {
                  "description": "CommonName is the common name as specified on the DER encoded CSR. If CommonName is not specified, the first DNSName specified will be used as the CommonName. At least one of CommonName or a DNSNames must be set. This field must match the corresponding field on the DER encoded CSR.",
                  "type": "string"
                },
                "csr": {
                  "description": "Certificate signing request bytes in DER encoding. This will be used when finalizing the order. This field must be set on the order.",
                  "type": "string",
                  "format": "byte"
                },
                "dnsNames": {
                  "description": "DNSNames is a list of DNS names that should be included as part of the Order validation process. If CommonName is not specified, the first DNSName specified will be used as the CommonName. At least one of CommonName or a DNSNames must be set. This field must match the corresponding field on the DER encoded CSR.",
                  "type": "array",
                  "items": {
                    "type": "string"
                  }
                },
                "issuerRef": {
                  "description": "IssuerRef references a properly configured ACME-type Issuer which should be used to create this Order. If the Issuer does not exist, processing will be retried. If the Issuer is not an 'ACME' Issuer, an error will be returned and the Order will be marked as failed.",
                  "type": "object",
                  "required": [
                    "name"
                  ],
                  "properties": {
                    "group": {
                      "type": "string"
                    },
                    "kind": {
                      "type": "string"
                    },
                    "name": {
                      "type": "string"
                    }
                  }
                }
              }
            },
            "status": {
              "type": "object",
              "properties": {
                "authorizations": {
                  "description": "Authorizations contains data returned from the ACME server on what authoriations must be completed in order to validate the DNS names specified on the Order.",
                  "type": "array",
                  "items": {
                    "description": "ACMEAuthorization contains data returned from the ACME server on an authorization that must be completed in order validate a DNS name on an ACME Order resource.",
                    "type": "object",
                    "required": [
                      "url"
                    ],
                    "properties": {
                      "challenges": {
                        "description": "Challenges specifies the challenge types offered by the ACME server. One of these challenge types will be selected when validating the DNS name and an appropriate Challenge resource will be created to perform the ACME challenge process.",
                        "type": "array",
                        "items": {
                          "description": "Challenge specifies a challenge offered by the ACME server for an Order. An appropriate Challenge resource can be created to perform the ACME challenge process.",
                          "type": "object",
                          "required": [
                            "token",
                            "type",
                            "url"
                          ],
                          "properties": {
                            "token": {
                              "description": "Token is the token that must be presented for this challenge. This is used to compute the 'key' that must also be presented.",
                              "type": "string"
                            },
                            "type": {
                              "description": "Type is the type of challenge being offered, e.g. http-01, dns-01",
                              "type": "string"
                            },
                            "url": {
                              "description": "URL is the URL of this challenge. It can be used to retrieve additional metadata about the Challenge from the ACME server.",
                              "type": "string"
                            }
                          }
                        }
                      },
                      "identifier": {
                        "description": "Identifier is the DNS name to be validated as part of this authorization",
                        "type": "string"
                      },
                      "url": {
                        "description": "URL is the URL of the Authorization that must be completed",
                        "type": "string"
                      },
                      "wildcard": {
                        "description": "Wildcard will be true if this authorization is for a wildcard DNS name. If this is true, the identifier will be the *non-wildcard* version of the DNS name. For example, if '*.example.com' is the DNS name being validated, this field will be 'true' and the 'identifier' field will be 'example.com'.",
                        "type": "boolean"
                      }
                    }
                  }
                },
                "certificate": {
                  "description": "Certificate is a copy of the PEM encoded certificate for this Order. This field will be populated after the order has been successfully finalized with the ACME server, and the order has transitioned to the 'valid' state.",
                  "type": "string",
                  "format": "byte"
                },
                "failureTime": {
                  "description": "FailureTime stores the time that this order failed. This is used to influence garbage collection and back-off.",
                  "type": "string",
                  "format": "date-time"
                },
                "finalizeURL": {
                  "description": "FinalizeURL of the Order. This is used to obtain certificates for this order once it has been completed.",
                  "type": "string"
                },
                "reason": {
                  "description": "Reason optionally provides more information about a why the order is in the current state.",
                  "type": "string"
                },
                "state": {
                  "description": "State contains the current state of this Order resource. States 'success' and 'expired' are 'final'",
                  "type": "string",
                  "enum": [
                    "valid",
                    "ready",
                    "pending",
                    "processing",
                    "invalid",
                    "expired",
                    "errored"
                  ]
                },
                "url": {
                  "description": "URL of the Order. This will initially be empty when the resource is first created. The Order controller will populate this field when the Order is first processed. This field will be immutable after it is initially set.",
                  "type": "string"
                }
              }
            }
          }
        }
      },
      "version": "v1alpha2",
      "versions": [
        {
          "name": "v1alpha2",
          "served": true,
          "storage": true
        }
      ]
    }
  },
  "cert-manager-6": null,
  "cert-manager-7": {
    "apiVersion": "v1",
    "kind": "Namespace",
    "metadata": {
      "name": "cert-manager"
    }
  },
  "cert-manager-8": {
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
      "name": "cert-manager-cainjector",
      "namespace": "cert-manager",
      "labels": {
        "app": "cainjector",
        "app.kubernetes.io/name": "cainjector",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    }
  },
  "cert-manager-9": {
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
      "name": "cert-manager",
      "namespace": "cert-manager",
      "annotations": null,
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    }
  },
  "cert-manager-10": {
    "apiVersion": "v1",
    "kind": "ServiceAccount",
    "metadata": {
      "name": "cert-manager-webhook",
      "namespace": "cert-manager",
      "labels": {
        "app": "webhook",
        "app.kubernetes.io/name": "webhook",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    }
  },
  "cert-manager-11": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRole",
    "metadata": {
      "name": "cert-manager-cainjector",
      "labels": {
        "app": "cainjector",
        "app.kubernetes.io/name": "cainjector",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "rules": [
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "certificates"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "secrets"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "events"
        ],
        "verbs": [
          "get",
          "create",
          "update",
          "patch"
        ]
      },
      {
        "apiGroups": [
          "admissionregistration.k8s.io"
        ],
        "resources": [
          "validatingwebhookconfigurations",
          "mutatingwebhookconfigurations"
        ],
        "verbs": [
          "get",
          "list",
          "watch",
          "update"
        ]
      },
      {
        "apiGroups": [
          "apiregistration.k8s.io"
        ],
        "resources": [
          "apiservices"
        ],
        "verbs": [
          "get",
          "list",
          "watch",
          "update"
        ]
      },
      {
        "apiGroups": [
          "apiextensions.k8s.io"
        ],
        "resources": [
          "customresourcedefinitions"
        ],
        "verbs": [
          "get",
          "list",
          "watch",
          "update"
        ]
      }
    ]
  },
  "cert-manager-12": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRoleBinding",
    "metadata": {
      "name": "cert-manager-cainjector",
      "labels": {
        "app": "cainjector",
        "app.kubernetes.io/name": "cainjector",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "roleRef": {
      "apiGroup": "rbac.authorization.k8s.io",
      "kind": "ClusterRole",
      "name": "cert-manager-cainjector"
    },
    "subjects": [
      {
        "name": "cert-manager-cainjector",
        "namespace": "cert-manager",
        "kind": "ServiceAccount"
      }
    ]
  },
  "cert-manager-13": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "Role",
    "metadata": {
      "name": "cert-manager-cainjector:leaderelection",
      "namespace": "kube-system",
      "labels": {
        "app": "cainjector",
        "app.kubernetes.io/name": "cainjector",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "rules": [
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "configmaps"
        ],
        "verbs": [
          "get",
          "create",
          "update",
          "patch"
        ]
      }
    ]
  },
  "cert-manager-14": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "RoleBinding",
    "metadata": {
      "name": "cert-manager-cainjector:leaderelection",
      "namespace": "kube-system",
      "labels": {
        "app": "cainjector",
        "app.kubernetes.io/name": "cainjector",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "roleRef": {
      "apiGroup": "rbac.authorization.k8s.io",
      "kind": "Role",
      "name": "cert-manager-cainjector:leaderelection"
    },
    "subjects": [
      {
        "kind": "ServiceAccount",
        "name": "cert-manager-cainjector",
        "namespace": "cert-manager"
      }
    ]
  },
  "cert-manager-15": null,
  "cert-manager-16": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRoleBinding",
    "metadata": {
      "name": "cert-manager-webhook:auth-delegator",
      "labels": {
        "app": "webhook",
        "app.kubernetes.io/name": "webhook",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "roleRef": {
      "apiGroup": "rbac.authorization.k8s.io",
      "kind": "ClusterRole",
      "name": "system:auth-delegator"
    },
    "subjects": [
      {
        "apiGroup": "",
        "kind": "ServiceAccount",
        "name": "cert-manager-webhook",
        "namespace": "cert-manager"
      }
    ]
  },
  "cert-manager-17": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "RoleBinding",
    "metadata": {
      "name": "cert-manager-webhook:webhook-authentication-reader",
      "namespace": "kube-system",
      "labels": {
        "app": "webhook",
        "app.kubernetes.io/name": "webhook",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "roleRef": {
      "apiGroup": "rbac.authorization.k8s.io",
      "kind": "Role",
      "name": "extension-apiserver-authentication-reader"
    },
    "subjects": [
      {
        "apiGroup": "",
        "kind": "ServiceAccount",
        "name": "cert-manager-webhook",
        "namespace": "cert-manager"
      }
    ]
  },
  "cert-manager-18": {
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "kind": "ClusterRole",
    "metadata": {
      "name": "cert-manager-webhook:webhook-requester",
      "labels": {
        "app": "webhook",
        "app.kubernetes.io/name": "webhook",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "rules": [
      {
        "apiGroups": [
          "admission.cert-manager.io"
        ],
        "resources": [
          "certificates",
          "certificaterequests",
          "issuers",
          "clusterissuers"
        ],
        "verbs": [
          "create"
        ]
      }
    ]
  },
  "cert-manager-19": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "Role",
    "metadata": {
      "name": "cert-manager:leaderelection",
      "namespace": "kube-system",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "rules": [
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "configmaps"
        ],
        "verbs": [
          "get",
          "create",
          "update",
          "patch"
        ]
      }
    ]
  },
  "cert-manager-20": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "RoleBinding",
    "metadata": {
      "name": "cert-manager:leaderelection",
      "namespace": "kube-system",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "roleRef": {
      "apiGroup": "rbac.authorization.k8s.io",
      "kind": "Role",
      "name": "cert-manager:leaderelection"
    },
    "subjects": [
      {
        "apiGroup": "",
        "kind": "ServiceAccount",
        "name": "cert-manager",
        "namespace": "cert-manager"
      }
    ]
  },
  "cert-manager-21": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRole",
    "metadata": {
      "name": "cert-manager-controller-issuers",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "rules": [
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "issuers",
          "issuers/status"
        ],
        "verbs": [
          "update"
        ]
      },
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "issuers"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "secrets"
        ],
        "verbs": [
          "get",
          "list",
          "watch",
          "create",
          "update",
          "delete"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "events"
        ],
        "verbs": [
          "create",
          "patch"
        ]
      }
    ]
  },
  "cert-manager-22": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRole",
    "metadata": {
      "name": "cert-manager-controller-clusterissuers",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "rules": [
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "clusterissuers",
          "clusterissuers/status"
        ],
        "verbs": [
          "update"
        ]
      },
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "clusterissuers"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "secrets"
        ],
        "verbs": [
          "get",
          "list",
          "watch",
          "create",
          "update",
          "delete"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "events"
        ],
        "verbs": [
          "create",
          "patch"
        ]
      }
    ]
  },
  "cert-manager-23": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRole",
    "metadata": {
      "name": "cert-manager-controller-certificates",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "rules": [
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "certificates",
          "certificates/status",
          "certificaterequests",
          "certificaterequests/status"
        ],
        "verbs": [
          "update"
        ]
      },
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "certificates",
          "certificaterequests",
          "clusterissuers",
          "issuers"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "certificates/finalizers",
          "certificaterequests/finalizers"
        ],
        "verbs": [
          "update"
        ]
      },
      {
        "apiGroups": [
          "acme.cert-manager.io"
        ],
        "resources": [
          "orders"
        ],
        "verbs": [
          "create",
          "delete",
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "secrets"
        ],
        "verbs": [
          "get",
          "list",
          "watch",
          "create",
          "update",
          "delete"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "events"
        ],
        "verbs": [
          "create",
          "patch"
        ]
      }
    ]
  },
  "cert-manager-24": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRole",
    "metadata": {
      "name": "cert-manager-controller-orders",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "rules": [
      {
        "apiGroups": [
          "acme.cert-manager.io"
        ],
        "resources": [
          "orders",
          "orders/status"
        ],
        "verbs": [
          "update"
        ]
      },
      {
        "apiGroups": [
          "acme.cert-manager.io"
        ],
        "resources": [
          "orders",
          "challenges"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "clusterissuers",
          "issuers"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          "acme.cert-manager.io"
        ],
        "resources": [
          "challenges"
        ],
        "verbs": [
          "create",
          "delete"
        ]
      },
      {
        "apiGroups": [
          "acme.cert-manager.io"
        ],
        "resources": [
          "orders/finalizers"
        ],
        "verbs": [
          "update"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "secrets"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "events"
        ],
        "verbs": [
          "create",
          "patch"
        ]
      }
    ]
  },
  "cert-manager-25": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRole",
    "metadata": {
      "name": "cert-manager-controller-challenges",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "rules": [
      {
        "apiGroups": [
          "acme.cert-manager.io"
        ],
        "resources": [
          "challenges",
          "challenges/status"
        ],
        "verbs": [
          "update"
        ]
      },
      {
        "apiGroups": [
          "acme.cert-manager.io"
        ],
        "resources": [
          "challenges"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "issuers",
          "clusterissuers"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "secrets"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "events"
        ],
        "verbs": [
          "create",
          "patch"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "pods",
          "services"
        ],
        "verbs": [
          "get",
          "list",
          "watch",
          "create",
          "delete"
        ]
      },
      {
        "apiGroups": [
          "extensions"
        ],
        "resources": [
          "ingresses"
        ],
        "verbs": [
          "get",
          "list",
          "watch",
          "create",
          "delete",
          "update"
        ]
      },
      {
        "apiGroups": [
          "acme.cert-manager.io"
        ],
        "resources": [
          "challenges/finalizers"
        ],
        "verbs": [
          "update"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "secrets"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      }
    ]
  },
  "cert-manager-26": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRole",
    "metadata": {
      "name": "cert-manager-controller-ingress-shim",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "rules": [
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "certificates",
          "certificaterequests"
        ],
        "verbs": [
          "create",
          "update",
          "delete"
        ]
      },
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "certificates",
          "certificaterequests",
          "issuers",
          "clusterissuers"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          "extensions"
        ],
        "resources": [
          "ingresses"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      },
      {
        "apiGroups": [
          "extensions"
        ],
        "resources": [
          "ingresses/finalizers"
        ],
        "verbs": [
          "update"
        ]
      },
      {
        "apiGroups": [
          ""
        ],
        "resources": [
          "events"
        ],
        "verbs": [
          "create",
          "patch"
        ]
      }
    ]
  },
  "cert-manager-27": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRoleBinding",
    "metadata": {
      "name": "cert-manager-controller-issuers",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "roleRef": {
      "apiGroup": "rbac.authorization.k8s.io",
      "kind": "ClusterRole",
      "name": "cert-manager-controller-issuers"
    },
    "subjects": [
      {
        "name": "cert-manager",
        "namespace": "cert-manager",
        "kind": "ServiceAccount"
      }
    ]
  },
  "cert-manager-28": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRoleBinding",
    "metadata": {
      "name": "cert-manager-controller-clusterissuers",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "roleRef": {
      "apiGroup": "rbac.authorization.k8s.io",
      "kind": "ClusterRole",
      "name": "cert-manager-controller-clusterissuers"
    },
    "subjects": [
      {
        "name": "cert-manager",
        "namespace": "cert-manager",
        "kind": "ServiceAccount"
      }
    ]
  },
  "cert-manager-29": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRoleBinding",
    "metadata": {
      "name": "cert-manager-controller-certificates",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "roleRef": {
      "apiGroup": "rbac.authorization.k8s.io",
      "kind": "ClusterRole",
      "name": "cert-manager-controller-certificates"
    },
    "subjects": [
      {
        "name": "cert-manager",
        "namespace": "cert-manager",
        "kind": "ServiceAccount"
      }
    ]
  },
  "cert-manager-30": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRoleBinding",
    "metadata": {
      "name": "cert-manager-controller-orders",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "roleRef": {
      "apiGroup": "rbac.authorization.k8s.io",
      "kind": "ClusterRole",
      "name": "cert-manager-controller-orders"
    },
    "subjects": [
      {
        "name": "cert-manager",
        "namespace": "cert-manager",
        "kind": "ServiceAccount"
      }
    ]
  },
  "cert-manager-31": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRoleBinding",
    "metadata": {
      "name": "cert-manager-controller-challenges",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "roleRef": {
      "apiGroup": "rbac.authorization.k8s.io",
      "kind": "ClusterRole",
      "name": "cert-manager-controller-challenges"
    },
    "subjects": [
      {
        "name": "cert-manager",
        "namespace": "cert-manager",
        "kind": "ServiceAccount"
      }
    ]
  },
  "cert-manager-32": {
    "apiVersion": "rbac.authorization.k8s.io/v1beta1",
    "kind": "ClusterRoleBinding",
    "metadata": {
      "name": "cert-manager-controller-ingress-shim",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "roleRef": {
      "apiGroup": "rbac.authorization.k8s.io",
      "kind": "ClusterRole",
      "name": "cert-manager-controller-ingress-shim"
    },
    "subjects": [
      {
        "name": "cert-manager",
        "namespace": "cert-manager",
        "kind": "ServiceAccount"
      }
    ]
  },
  "cert-manager-33": {
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "kind": "ClusterRole",
    "metadata": {
      "name": "cert-manager-view",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1",
        "rbac.authorization.k8s.io/aggregate-to-view": "true",
        "rbac.authorization.k8s.io/aggregate-to-edit": "true",
        "rbac.authorization.k8s.io/aggregate-to-admin": "true"
      }
    },
    "rules": [
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "certificates",
          "certificaterequests",
          "issuers"
        ],
        "verbs": [
          "get",
          "list",
          "watch"
        ]
      }
    ]
  },
  "cert-manager-34": {
    "apiVersion": "rbac.authorization.k8s.io/v1",
    "kind": "ClusterRole",
    "metadata": {
      "name": "cert-manager-edit",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1",
        "rbac.authorization.k8s.io/aggregate-to-edit": "true",
        "rbac.authorization.k8s.io/aggregate-to-admin": "true"
      }
    },
    "rules": [
      {
        "apiGroups": [
          "cert-manager.io"
        ],
        "resources": [
          "certificates",
          "certificaterequests",
          "issuers"
        ],
        "verbs": [
          "create",
          "delete",
          "deletecollection",
          "patch",
          "update"
        ]
      }
    ]
  },
  "cert-manager-35": {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
      "name": "cert-manager",
      "namespace": "cert-manager",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "spec": {
      "type": "ClusterIP",
      "ports": [
        {
          "protocol": "TCP",
          "port": 9402,
          "targetPort": 9402
        }
      ],
      "selector": {
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager"
      }
    }
  },
  "cert-manager-36": {
    "apiVersion": "v1",
    "kind": "Service",
    "metadata": {
      "name": "cert-manager-webhook",
      "namespace": "cert-manager",
      "labels": {
        "app": "webhook",
        "app.kubernetes.io/name": "webhook",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "spec": {
      "type": "ClusterIP",
      "ports": [
        {
          "name": "https",
          "port": 443,
          "targetPort": 10250
        }
      ],
      "selector": {
        "app": "webhook",
        "app.kubernetes.io/name": "webhook",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller"
      }
    }
  },
  "cert-manager-37": {
    "apiVersion": "apps/v1",
    "kind": "Deployment",
    "metadata": {
      "name": "cert-manager-cainjector",
      "namespace": "cert-manager",
      "labels": {
        "app": "cainjector",
        "app.kubernetes.io/name": "cainjector",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "spec": {
      "replicas": 1,
      "selector": {
        "matchLabels": {
          "app": "cainjector",
          "app.kubernetes.io/name": "cainjector",
          "app.kubernetes.io/instance": "cert-manager",
          "app.kubernetes.io/managed-by": "Tiller"
        }
      },
      "template": {
        "metadata": {
          "labels": {
            "app": "cainjector",
            "app.kubernetes.io/name": "cainjector",
            "app.kubernetes.io/instance": "cert-manager",
            "app.kubernetes.io/managed-by": "Tiller",
            "helm.sh/chart": "cert-manager-v0.13.1"
          },
          "annotations": null
        },
        "spec": {
          "serviceAccountName": "cert-manager-cainjector",
          "containers": [
            {
              "name": "cert-manager",
              "image": "quay.io/jetstack/cert-manager-cainjector:v0.13.1",
              "imagePullPolicy": "IfNotPresent",
              "args": [
                "--v=2",
                "--leader-election-namespace=kube-system"
              ],
              "env": [
                {
                  "name": "POD_NAMESPACE",
                  "valueFrom": {
                    "fieldRef": {
                      "fieldPath": "metadata.namespace"
                    }
                  }
                }
              ],
              "resources": {}
            }
          ]
        }
      }
    }
  },
  "cert-manager-38": {
    "apiVersion": "apps/v1",
    "kind": "Deployment",
    "metadata": {
      "name": "cert-manager",
      "namespace": "cert-manager",
      "labels": {
        "app": "cert-manager",
        "app.kubernetes.io/name": "cert-manager",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "spec": {
      "replicas": 1,
      "selector": {
        "matchLabels": {
          "app": "cert-manager",
          "app.kubernetes.io/name": "cert-manager",
          "app.kubernetes.io/instance": "cert-manager",
          "app.kubernetes.io/managed-by": "Tiller"
        }
      },
      "template": {
        "metadata": {
          "labels": {
            "app": "cert-manager",
            "app.kubernetes.io/name": "cert-manager",
            "app.kubernetes.io/instance": "cert-manager",
            "app.kubernetes.io/managed-by": "Tiller",
            "helm.sh/chart": "cert-manager-v0.13.1"
          },
          "annotations": {
            "prometheus.io/path": "/metrics",
            "prometheus.io/scrape": "true",
            "prometheus.io/port": "9402"
          }
        },
        "spec": {
          "serviceAccountName": "cert-manager",
          "containers": [
            {
              "name": "cert-manager",
              "image": "quay.io/jetstack/cert-manager-controller:v0.13.1",
              "imagePullPolicy": "IfNotPresent",
              "args": [
                "--v=2",
                "--cluster-resource-namespace=$(POD_NAMESPACE)",
                "--leader-election-namespace=kube-system",
                "--webhook-namespace=$(POD_NAMESPACE)",
                "--webhook-ca-secret=cert-manager-webhook-ca",
                "--webhook-serving-secret=cert-manager-webhook-tls",
                "--webhook-dns-names=cert-manager-webhook,cert-manager-webhook.cert-manager,cert-manager-webhook.cert-manager.svc"
              ],
              "ports": [
                {
                  "containerPort": 9402,
                  "protocol": "TCP"
                }
              ],
              "env": [
                {
                  "name": "POD_NAMESPACE",
                  "valueFrom": {
                    "fieldRef": {
                      "fieldPath": "metadata.namespace"
                    }
                  }
                }
              ],
              "resources": {
                "requests": {
                  "cpu": "10m",
                  "memory": "32Mi"
                }
              }
            }
          ]
        }
      }
    }
  },
  "cert-manager-39": {
    "apiVersion": "apps/v1",
    "kind": "Deployment",
    "metadata": {
      "name": "cert-manager-webhook",
      "namespace": "cert-manager",
      "labels": {
        "app": "webhook",
        "app.kubernetes.io/name": "webhook",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      }
    },
    "spec": {
      "replicas": 1,
      "selector": {
        "matchLabels": {
          "app": "webhook",
          "app.kubernetes.io/name": "webhook",
          "app.kubernetes.io/instance": "cert-manager",
          "app.kubernetes.io/managed-by": "Tiller"
        }
      },
      "template": {
        "metadata": {
          "labels": {
            "app": "webhook",
            "app.kubernetes.io/name": "webhook",
            "app.kubernetes.io/instance": "cert-manager",
            "app.kubernetes.io/managed-by": "Tiller",
            "helm.sh/chart": "cert-manager-v0.13.1"
          },
          "annotations": null
        },
        "spec": {
          "serviceAccountName": "cert-manager-webhook",
          "containers": [
            {
              "name": "cert-manager",
              "image": "quay.io/jetstack/cert-manager-webhook:v0.13.1",
              "imagePullPolicy": "IfNotPresent",
              "args": [
                "--v=2",
                "--secure-port=10250",
                "--tls-cert-file=/certs/tls.crt",
                "--tls-private-key-file=/certs/tls.key"
              ],
              "livenessProbe": {
                "httpGet": {
                  "path": "/livez",
                  "port": 6080,
                  "scheme": "HTTP"
                }
              },
              "readinessProbe": {
                "httpGet": {
                  "path": "/healthz",
                  "port": 6080,
                  "scheme": "HTTP"
                }
              },
              "env": [
                {
                  "name": "POD_NAMESPACE",
                  "valueFrom": {
                    "fieldRef": {
                      "fieldPath": "metadata.namespace"
                    }
                  }
                }
              ],
              "resources": {},
              "volumeMounts": [
                {
                  "name": "certs",
                  "mountPath": "/certs"
                }
              ]
            }
          ],
          "volumes": [
            {
              "name": "certs",
              "secret": {
                "secretName": "cert-manager-webhook-tls"
              }
            }
          ]
        }
      }
    }
  },
  "cert-manager-40": {
    "apiVersion": "admissionregistration.k8s.io/v1beta1",
    "kind": "MutatingWebhookConfiguration",
    "metadata": {
      "name": "cert-manager-webhook",
      "labels": {
        "app": "webhook",
        "app.kubernetes.io/name": "webhook",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      },
      "annotations": {
        "cert-manager.io/inject-ca-from-secret": "cert-manager/cert-manager-webhook-tls"
      }
    },
    "webhooks": [
      {
        "name": "webhook.cert-manager.io",
        "rules": [
          {
            "apiGroups": [
              "cert-manager.io",
              "acme.cert-manager.io"
            ],
            "apiVersions": [
              "v1alpha2"
            ],
            "operations": [
              "CREATE",
              "UPDATE"
            ],
            "resources": [
              "*/*"
            ]
          }
        ],
        "failurePolicy": "Fail",
        "sideEffects": "None",
        "clientConfig": {
          "service": {
            "name": "cert-manager-webhook",
            "namespace": "cert-manager",
            "path": "/mutate"
          }
        }
      }
    ]
  },
  "cert-manager-41": {
    "apiVersion": "admissionregistration.k8s.io/v1beta1",
    "kind": "ValidatingWebhookConfiguration",
    "metadata": {
      "name": "cert-manager-webhook",
      "labels": {
        "app": "webhook",
        "app.kubernetes.io/name": "webhook",
        "app.kubernetes.io/instance": "cert-manager",
        "app.kubernetes.io/managed-by": "Tiller",
        "helm.sh/chart": "cert-manager-v0.13.1"
      },
      "annotations": {
        "cert-manager.io/inject-ca-from-secret": "cert-manager/cert-manager-webhook-tls"
      }
    },
    "webhooks": [
      {
        "name": "webhook.cert-manager.io",
        "namespaceSelector": {
          "matchExpressions": [
            {
              "key": "cert-manager.io/disable-validation",
              "operator": "NotIn",
              "values": [
                "true"
              ]
            },
            {
              "key": "name",
              "operator": "NotIn",
              "values": [
                "cert-manager"
              ]
            }
          ]
        },
        "rules": [
          {
            "apiGroups": [
              "cert-manager.io",
              "acme.cert-manager.io"
            ],
            "apiVersions": [
              "v1alpha2"
            ],
            "operations": [
              "CREATE",
              "UPDATE"
            ],
            "resources": [
              "*/*"
            ]
          }
        ],
        "failurePolicy": "Fail",
        "sideEffects": "None",
        "clientConfig": {
          "service": {
            "name": "cert-manager-webhook",
            "namespace": "cert-manager",
            "path": "/mutate"
          }
        }
      }
    ]
  }
}