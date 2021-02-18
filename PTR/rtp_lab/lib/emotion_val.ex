defmodule EmotionValues do
  use GenServer

  def start_link(state \\ 0) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(state) do
    get_emotions(state)
    {:ok, state}
  end

  defp get_emotions(state) do
    IO.puts "Getting emotions values..."
    case HTTPPoison.get("http://localhost:4000/emotion_values") do
      {:ok, %HTTPPoison.Response{status_code: 200, word: word}} ->
        rules = Poison.decode!(word)


    end
    {:noreply, state}
  end
end
