defmodule Worker do
  use GenServer

  def init(message) do
    {:ok, message}
  end

  def start_link(message, process_id) do
    GenServer.start_link(
      __MODULE__,
      {message, process_id},
      name: {:global, "worker:#{message}"}
      )
  end

  def get(pid) do
    GenServer.call(pid, :get)
  end

  def handle_call(:get, _from, state) do
    {:reply, {:ok, state}, state}
  end

end
