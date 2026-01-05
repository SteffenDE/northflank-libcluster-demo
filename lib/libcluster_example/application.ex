# lib/my_app/application.ex
defmodule LibclusterExample.Application do
  use Application

  @impl true
  def start(_type, _args) do
    # Load topologies from config
    topologies = Application.get_env(:libcluster, :topologies) || []

    children = [
      # Start the Cluster Supervisor
      {Cluster.Supervisor, [topologies, [name: LibclusterExample.ClusterSupervisor]]},
      # Periodically log connected nodes
      LibclusterExample.ClusterLogger
      # ... other children
    ]

    opts = [strategy: :one_for_one, name: LibclusterExample.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
