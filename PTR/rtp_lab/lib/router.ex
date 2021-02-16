# server
defmodule Router do
  use GenServer

  def start_link(state) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  @impl true
  def init(message) do
    {:ok, message}
  end

  @impl true
  def handle_cast({:router, message}, _smth) do
    #IO.inspect(%{"Received message: " => message})
    MyIO.my_inspect(%{"Received message: " => message})
    {:noreply, %{}}
  end
end
