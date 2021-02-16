defmodule MyIO do
  def my_inspect(data) do
    data |> inspect() |> IO.puts()
    data
  end
end
