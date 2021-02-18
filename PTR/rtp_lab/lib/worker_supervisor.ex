defmodule WorkerSupervisor do
  use Supervisor

  def start_link([]) do
    Supervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  def init(:ok) do
    Supervisor.init([Worker], strategy: :simple_one_for_one())
  end

  def add_worker(message, process_id) do
    Supervisor.start_child(__MODULE__, [{message, process_id}])
  end

  def remove_worker(worker_pid) do
    Supervisor.terminate_child(__MODULE__, worker_pid)
  end

  def children do
    Supervisor.which_children(__MODULE__)
  end

  def count_children do
    Supervisor.count_children(__MODULE__)
  end

end
