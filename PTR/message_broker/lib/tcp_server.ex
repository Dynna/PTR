defmodule TcpServer do

  def listen(port) do
      :gen_tcp.listen(port, [:binary, active: false, packet: 0, reuseaddr: true])
  end

  def accept(socket) do
      :gen_tcp.accept(socket)
  end

  def connect(host, port) do
      :gen_tcp.connect(host, port, [:binary, active: false])
  end

  def send(socket, data) do
      :gen_tcp.send(socket, data)
      IO.puts("Send")
  end

  defp read(socket) do
      {:ok, msg} = :gen_tcp.recv(socket, 0)
      IO.puts("Read")
      msg
  end

end
