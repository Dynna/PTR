# adaptive batching mechanism
defmodule Backpressure do
  use GenServer

  @size 400

  def start_link(_arg) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    in_q = []
    {:ok, in_q}
  end

  def insert(element) do
    GenServer.cast(Backpressure, {:insert, element})
  end

  @impl true
  def handle_cast({:insert, element}, q) do
    up_q = [element | q]
    if Enum.count(up_q) >= @size do
      GenServer.cast(__MODULE__, :batch)
    end

    {:noreply, up_q}
  end

  @impl true
  def handle_cast(:batch, q) do
    spawn(fn ->
      Enum.each(q, fn element ->
        load(element, "messages")
      end)
    end)
    {:noreply, []}
  end

  def load(message, coll) do
    {:ok, top} = Mongo.start_link(url: "mongodb://localhost:27017/rtp-tweets")
    Mongo.insert_one!(top, coll, message)
  end

end
