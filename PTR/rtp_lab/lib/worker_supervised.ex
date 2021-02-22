defmodule Worker do
  use GenServer

  def init(message) do
    {:ok, %{name: message}}
  end

  def start_link(message) do
    GenServer.start_link(
      __MODULE__,
      message,
      name: __MODULE__
      )
  end

 # def call_worker({pid, low, high}) do
 #   GenServer.cast(pid, {:set, low, high})
 # end

  def get(pid) do
    GenServer.call(pid, :get)
  end

  def handle_call(:get, _from, state) do
    {:reply, {:ok, state}, state}
  end

  def handle_cast({:worker, message}, _smth) do
    MyIO.my_inspect(%{"Worker received: " => message})
    {:noreply, %{}}
  end

  def handle_info(message, expr \\ nil) do
    MyIO.my_inspect(%{"HANDLE INFO: " => message})
    {:noreply, %{}}
  end

end
