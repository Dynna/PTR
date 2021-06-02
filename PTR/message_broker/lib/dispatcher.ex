defmodule Dispatcher do

  def checkMsgType(%BaseMessages{header: type,topic: top, body: content}, client) do
    performAct(String.to_atom(type), content, top, client)
  end

  def performAct(:subscribe, _, top, client) do
    GenServer.cast(:topics,{:subscribe, client, String.to_atom(top)})
  end

  def performAct(:unsubscribe, _, top, client) do
    GenServer.cast(:topics,{:unsubscribe, client, String.to_atom(top)})
  end

  def performAct(:data, content, top, _) do
    clients = GenServer.call(:topics,{:clients, String.to_atom(top)})
    Enum.each(clients, fn x -> TcpServer.send(x, content) end)
  end

  def performAct(:add_topic,_, top, _) do
    GenServer.cast(:topics,{:add_topic, String.to_atom(top)})
  end

end
