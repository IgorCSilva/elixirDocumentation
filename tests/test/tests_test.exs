defmodule TestsTest do
  use ExUnit.Case
  doctest Tests

  test "removendo a de dale" do
    assert Tests.remove_a("dale") == "dle"
  end
end
