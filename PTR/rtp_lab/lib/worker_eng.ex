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
    {:noreply, %{}}
  end

  def read_json(message) do
    decoded_message = Poison.decode!(message.data)
    decoded_message["message"]["tweet"]["retweeted_status"]
  end

  def process_data(message) do
    ret_status = read_json(message)
    if (ret_status) do
      retweets = (message["message"]["tweet"]["retweeted_status"]["retweeted_count"])
      favorites = (message["message"]["tweet"]["retweeted_status"]["favorite_count"])
      followers = (message["message"]["tweet"]["user"]["followers_count"])
      eng_ratio = (retweets + favorites)/followers
      MyIO.my_inspect(%{"RECEIVED: " => ret_status})
     # analyzed_text = make_analysis(text)
      MyIO.my_inspect(%{"ENGAGEMENT RATIO: " => eng_ratio})
      MyIO.my_inspect("================================================================================")
    else
      MyIO.my_inspect(%{"ORIGINAL MESSAGE: " => message})
    end
  end

  #defp make_analysis(values) do
   # values
   # |> Enum.reduce(0, fn key_value, coll -> EmotionValues.get_emotion(key_value) + coll end)
   # |> Kernel./(length(values))
  #end

end
