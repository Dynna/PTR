defmodule Process do
  use GenServer

  def init(process_id) do
    {:ok, %{process_id: process_id}}
  end

  def start_link(process_id) do
    GenServer.start_link(__MODULE__, process_id, name: {:global, "process:#{process_id}"})
  end

  def add_worker(pid, message) do
    GenServer.call(pid, {:add_worker, message})
  end

  def handle_call({:add_worker, message}, _from, %{process_id: process_id} = state) do
   start_status = Worker.start_link({message, process_id})
   #start_status = WorkerSupervisor.add_worker(message, process_id)
    {:reply, start_status, state}
  end

end
