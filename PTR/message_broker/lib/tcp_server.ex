defmodule TcpServer do

  def listen(port) do
    IO.puts "Port is listening"
    :gen_tcp.listen(port, [:binary, active: true, packet: 0, reuseaddr: true])
  end

  def accept(socket) do
    IO.puts "Port is accepting"
    :gen_tcp.accept(socket)
  end

  def connect(host, port) do
    :gen_tcp.connect(host, port, [:binary, active: false, packet: 0])
  end

  def send(socket, data) do
    IO.puts "Sending data: #{data}"
    :gen_tcp.send(socket, data)
  end

  defp read(socket) do
    {:ok, msg} = :gen_tcp.recv(socket, 0)
    IO.puts("Read")
    msg
  end

end
