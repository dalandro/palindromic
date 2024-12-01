defmodule Palindromic.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PalindromicWeb.Telemetry,
      # Palindromic.Repo,
      {DNSCluster, query: Application.get_env(:palindromic, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Palindromic.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Palindromic.Finch},
      # Start a worker by calling: Palindromic.Worker.start_link(arg)
      # {Palindromic.Worker, arg},
      # Start to serve requests, typically the last entry
      PalindromicWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Palindromic.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PalindromicWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
