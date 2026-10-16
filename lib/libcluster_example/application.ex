# lib/my_app/application.ex
defmodule LibclusterExample.Application do
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {DNSCluster,
       query: Application.get_env(:libcluster_example, :dns_cluster_query) || :ignore},
      # Periodically log connected nodes
      LibclusterExample.ClusterLogger
      # ... other children
    ]

    opts = [strategy: :one_for_one, name: LibclusterExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
