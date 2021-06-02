defmodule Send do

  def connect() do
    {:ok, socket} = TcpServer.connect(:localhost, 17017)
    ff_data = Serializable.serialize(%BaseMessages{header: :subscribe, topic: "users", body: "users"})
    TcpServer.send(socket, ff_data)
    socket
  end

  def speak(sok, data) do
    f_data = %BaseMessages{header: :data, topic: "users", body: data}
    ff_data = Serializable.serialize(f_data)
    TcpServer.send(sok, ff_data)
  end

end
