# client
defmodule Connection do

  def start_link(url) do
    {:ok, _pid} = EventsourceEx.new(url, stream_to: self())
    getMessage()
  end

  def getMessage() do
    receive do
      message -> messageBehaviour(message)
     #:expected -> send(stats_pid, :ok)
     #message -> IO.inspect message, label: “received message”
    end

    getMessage()
  end

  def stats(num) do
    ts1 = Time.utc_now()

    Enum.each(1..num, fn _ ->
      receive do
        _ -> :ok
      end
    end)

    ts2 = Time.utc_now()
    diff = Time.diff(ts2, ts1, :millisecond)
    resp = Float.ceil(num / diff * 1000, 2)

    IO.puts("Throughput is: #{resp} requests per second")
  end

  def messageBehaviour(message) do
    GenServer.cast(Router, {:router, message})
    getMessage()
  end

  def child_spec(opts) do
    %{
      id: __MODULE__,
      start: {__MODULE__, :start_link, [opts]},
      type: :worker,
      restart: :permanent,
      shutdown: 500
    }
  end

end
