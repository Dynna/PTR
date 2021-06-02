defmodule MessageBroker do
  use GenServer

  def start_link(socket) do
    GenServer.start_link(__MODULE__, socket, name: :server)
  end

  def init(state) do
    GenServer.cast(self(), :accept)

    {:ok, state}
  end

  def handle_cast(:accept, socket) do
    {:ok, client} = TcpServer.accept(socket)
    :gen_tcp.controlling_process(client, self())
    ConnectionSupervisor.start_child(socket)

    {:noreply, socket}
  end

  def handle_info({:tcp, socket, msg}, state) do
    Dispatcher.checkMsgType(Serializable.deserialize(msg), socket)
    TcpServer.send(socket, msg)

    {:noreply, state}
  end

end
