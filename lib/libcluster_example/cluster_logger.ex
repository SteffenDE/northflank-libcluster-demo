defmodule LibclusterExample.ClusterLogger do
  use GenServer
  require Logger

  def start_link(_opts) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    # Start logging loop
    schedule_logging()
    {:ok, []}
  end

  @impl true
  def handle_info(:log, state) do
    nodes = [Node.self() | Node.list()]
    Logger.info("[ClusterLogger] Connected nodes: #{inspect(nodes)}")
    schedule_logging()
    {:noreply, state}
  end

  defp schedule_logging do
    Process.send_after(self(), :log, 5_000)
  end
end
