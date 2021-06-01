defmodule BrokerSupervisor do
  use DynamicSupervisor

  def start_link() do
    DynamicSupervisor.start_link(__MODULE__, [], name: __MODULE__)
  end

  def init(_) do
    {:ok, socket} = TcpServer.listen(15015)
    children = [
      %{
        id: Broker,
        start: {MessageBroker, :start_link, [socket]}
      }
    ]
    DynamicSupervisor.init(
      strategy: :one_for_one
    )

    opts = [
      strategy: :one_for_one,
      max_restarts: 60,
    ]

    Supervisor.init(children, opts)
  end

  def start_child() do
    DynamicSupervisor.start_child(__MODULE__, {})
  end
end
