defmodule EngWorker do
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

  def get(pid) do
    GenServer.call(pid, :get)
  end

  def handle_call(:get, _from, state) do
    {:reply, {:ok, state}, state}
  end

  def handle_cast({:eng_worker, message}, _smth) do
    process_data(message)
  #  {:ok, top} = Mongo.start_link(url: "mongodb://localhost:27017/rtp-tweets")
   # Mongo.insert_one(top, "sentiment", %{sentiment: "something"})
   # {:noreply, %{}}
  end

  def process_data(message) do
    decoded_message = Poison.decode!(message.data)
    ret_status = decoded_message["message"]["tweet"]["retweeted_status"]

    if (ret_status) do
      retweets = (decoded_message["message"]["tweet"]["retweeted_status"]["retweet_count"])
      favorites = (decoded_message["message"]["tweet"]["retweeted_status"]["favorite_count"])
      followers = (decoded_message["message"]["tweet"]["user"]["followers_count"])
      eng_ratio = (retweets + favorites)/followers
      MyIO.my_inspect(%{"RECEIVED: " => ret_status})
      MyIO.my_inspect(%{"ENGAGEMENT RATIO: " => eng_ratio})
      MyIO.my_inspect("================================================================================")
    else
      MyIO.my_inspect(%{"ORIGINAL MESSAGE: " => message})
    end
  end

end