defmodule Topics do
  use GenServer

  def start_link() do
    GenServer.start_link(__MODULE__, %{}, name: :topics)
  end

  def init(state) do
    {:ok, state}
  end

  # create topic if it doesn't exist
  def handle_cast({:subscribe, client, topic}, state) do
    new_state = Map.put(state, topic, [client|Map.get(state, topic, [])])
    {:noreply, new_state}
  end

  def handle_cast({:add_topic, topic}, state) do
    new_state = Map.put(state, topic, [])
    {:noreply, new_state}
  end

  def handle_cast({:unsubscribe, client, topic}, state) do
    new_state = Map.put(state,topic, List.delete(Map.get(state, topic), client))
    {:noreply, new_state}
  end

  def handle_cast(:tops, state) do
    :io.format("_________________________~n~p~n_______________________________",[state])
    {:noreply, state}
  end

  def handle_call({:clients, topic}, _, state) do
    {:reply, Map.get(state, topic), state}
  end

end
