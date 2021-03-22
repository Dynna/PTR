defmodule Sink do
  use GenServer

  def start_link(message) do
    GenServer.start(__MODULE__, message, name: __MODULE__)
  end

  @impl true
  def init(_arg) do
    in_q = []
    {:ok, in_q}
  end

  @impl true
  def handle_cast({:message, message}, _smth) do
    MyIO.my_inspect("LOADING INTO DB")
    Backpressure.insert(message)

    {:noreply, %{}}
  end

  @impl true
  def handle_cast({:eng_ratio, eng_ratio}, _smth) do
    MyIO.my_inspect("ADDING ENGAGEMENT RATIO")
    load(%{eng_ratio: eng_ratio}, "eng_ratio")

    {:noreply, %{}}
  end

  @impl true
  def handle_cast({:sentiment_score, sentiment_score}, _smth) do
    MyIO.my_inspect("ADDING SENTIMENT SCORE")
    load(%{sentiment_score: sentiment_score}, "sentiment_score")

    {:noreply, %{}}
  end

  def load(message, coll) do
    MyIO.my_inspect("DB RECEIVEING")
    {:ok, top} = Mongo.start_link(url: "mongodb://localhost:27017/rtp-tweets")
    Mongo.insert_one!(top, coll, message)
  end

end
