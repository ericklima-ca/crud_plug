defmodule Petx.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false
  require Logger
  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Starts a worker by calling: Petx.Worker.start_link(arg)
      # {Petx.Worker, arg}
      {Plug.Cowboy, scheme: :http, plug: Petx, options: [port: plug_port()]},
      {Petx.Repo, []}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Petx.Supervisor]

    Logger.info("Starting application on port: '#{plug_port()}'")
    Supervisor.start_link(children, opts)
  end

  defp plug_port(), do: Application.get_env(:petx, :port, 4001)
end
