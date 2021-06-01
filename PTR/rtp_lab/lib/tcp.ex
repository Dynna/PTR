defmodule TCP do

  def connect(host, port) do
    :gen_tcp.connect(host, port, [:binary, active: false, packet: 0])
  end

  def send(socket, data) do
    IO.puts "Sending data: #{data}"
    :gen_tcp.send(socket, data)
  end

  def close(socket) do
    :gen_tcp.close(socket)
  end

end
