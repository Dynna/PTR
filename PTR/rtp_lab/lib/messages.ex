defmodule BaseMessages do
  defstruct [:header, :topic, :body]
end

defprotocol Serializable do
  def serialize(msg)
end

defimpl Serializable, for: [BaseMessages, BitString] do
  def serialize(msg) do
    Poison.encode!(%BaseMessages{header: msg.header, topic: msg.topic, body: msg.body})
  end
end
