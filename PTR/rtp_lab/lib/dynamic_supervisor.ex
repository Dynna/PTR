defmodule DynamicSupervisor do
  use DynamicSupervisor

  def start_link(_arg) do
    DynamicSupervisor.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(:ok) do
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  # start worker process & add it to supervision
  def add_worker(message) do
    child_spec = {Worker, {message}}

    DynamicSupervisor.start_child(__MODULE__, child_spec)
  end

  # terminate worker process and remove it from supervision
  def remove_worker(worker_pid) do
    DynamicSupervisor.terminate_child(__MODULE__, worker_pid)
  end

  # check which processes are under supervision
  def children do
    DynamicSupervisor.which_children(__MODULE__)
  end

  # check how many processes are under supervision
  def count_children do
    DynamicSupervisor.count_children(__MODULE__)
  end
end
