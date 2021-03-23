defmodule Worker do
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

  def handle_cast({:worker, message}, _smth) do
    process_data(message)
    {:noreply, %{}}
  end

  def read_json(message) do
    decoded_message = Poison.decode!(message.data)
    decoded_message["message"]["tweet"]["text"]
  end

  def process_data(message) do
    if message.data =~ "panic" do
      IO.inspect("KILL MESSAGE HERE")
    else
      rm_characters = [",", ":", "?", ".", "!"]
      text = read_json(message)
      |> String.replace(rm_characters, "")
      |> String.split(" ", trim: true)

      analyzed_text = make_analysis(text)

      tweet = Poison.decode!(message.data)
      user = (tweet["message"]["tweet"]["user"]["screen_name"])
      sentiment = %{user: user, sentiment_score: analyzed_text}
      GenServer.cast(Sink, {:sentiment_score, sentiment})
    end
  end

  defp make_analysis(values) do
    values
    |> Enum.reduce(0, fn key_value, coll -> EmotionValues.get_emotion(key_value) + coll end)
    |> Kernel./(length(values))
  end

end
