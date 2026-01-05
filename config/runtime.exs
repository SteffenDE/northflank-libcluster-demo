import Config

app_name = System.get_env("NF_RESOURCE_ID")
service_name = System.get_env("NF_DISCOVERY_SERVICE")
IO.puts("Using app_name:#{app_name} service_name:#{service_name}")

config :libcluster,
  debug: true,
  topologies: [
    k8s_dns: [
      strategy: Cluster.Strategy.Kubernetes.DNS,
      config: [
        service: service_name,
        application_name: app_name
      ]
    ]
  ]
