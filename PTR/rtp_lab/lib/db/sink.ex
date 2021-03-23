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
    MyIO.my_inspect("ADDING ACTUAL TWEET")
  #  Backpressure.insert(message)

   {:noreply, %{}}
  end

  @impl true
  def handle_cast({:user, user}, _smth) do
    MyIO.my_inspect("ADDING USERS")
    Backpressure.load(%{user: user}, "users")

    {:noreply, %{}}
  end

  @impl true
  def handle_cast({:ratio, ratio}, _smth) do
    MyIO.my_inspect("ADDING ENGAGEMENT RATIO")
   # Backpressure.load(%{ratio: ratio}, "tweets")
    Backpressure.insert(ratio)
    {:noreply, %{}}
  end

  @impl true
  def handle_cast({:sentiment_score, sentiment_score}, _smth) do
    MyIO.my_inspect("ADDING SENTIMENT SCORE")
    #Backpressure.load(%{sentiment_score: sentiment_score}, "tweets")
    Backpressure.insert(sentiment_score)
    {:noreply, %{}}
  end

end
