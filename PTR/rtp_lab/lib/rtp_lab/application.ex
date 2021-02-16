defmodule RtpLab.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Starts a worker by calling: RtpLab.Worker.start_link(arg)
      # {RtpLab.Worker, arg}
      %{
        id: Router,
        start: {Router, :start_link, [""]}
      },
      %{
        id: Connection,
        start: {Connection, :start_link, ["http://localhost:4000/tweets/1"]}
      }
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RtpLab.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
