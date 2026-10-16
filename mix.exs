defmodule LibclusterExample.MixProject do
  use Mix.Project

  def project do
    [
      app: :libcluster_example,
      version: "0.1.0",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {LibclusterExample.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dns_cluster, "~> 0.3"}
    ]
  end
end
