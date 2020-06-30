defmodule ElixirDocumentationTest do
  use ExUnit.Case
  doctest ElixirDocumentation

  test "greets the world" do
    assert ElixirDocumentation.hello() == :world
  end
end
