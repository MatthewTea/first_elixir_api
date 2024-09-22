defmodule MatthewApi.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MatthewApiWeb.Telemetry,
      MatthewApi.Repo,
      {DNSCluster, query: Application.get_env(:matthew_api, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MatthewApi.PubSub},
      # Start a worker by calling: MatthewApi.Worker.start_link(arg)
      # {MatthewApi.Worker, arg},
      # Start to serve requests, typically the last entry
      MatthewApiWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MatthewApi.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MatthewApiWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
