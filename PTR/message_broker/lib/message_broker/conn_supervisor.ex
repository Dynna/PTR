defmodule ConnectionSupervisor do
  use DynamicSupervisor

  def start_link() do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
    {:ok, socket} = TcpServer.listen(17017)
    ConnectionSupervisor.start_child(socket)
  end

  def start_child(socket) do
    DynamicSupervisor.start_child(__MODULE__, {MessageBroker, socket})
  end

  def init(_) do
    DynamicSupervisor.init(max_restarts: 100, strategy: :one_for_one)
  end
end
