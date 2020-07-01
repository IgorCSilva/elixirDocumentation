defmodule ElixirDocumentationTest do
  use ExUnit.Case
  doctest ElixirDocumentation

  test "greets the world" do
    assert ElixirDocumentation.sum(2, 6) == 8
  end
end
