defmodule Connection do
  def start_link(url) do
    {:ok, pid} = EventsourceEx.new(url, stream_to: self)

    receive()
  end

  



end
