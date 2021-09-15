defmodule Pow.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Pow.Repo,
      # Start the Telemetry supervisor
      PowWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Pow.PubSub},
      # Start the Endpoint (http/https)
      PowWeb.Endpoint
      # Start a worker by calling: Pow.Worker.start_link(arg)
      # {Pow.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Pow.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    PowWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
