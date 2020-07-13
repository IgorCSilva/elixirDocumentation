defmodule Stack.Impl do
  
  def head([l | _ist]), do: l
  def tail([_l | ist]), do: ist
  def add(list_a, list_b), do: list_a ++ list_b
end