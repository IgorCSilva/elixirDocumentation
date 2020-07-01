defmodule ConcatTest do
  use ExUnit.Case
  doctest Concat
  use ExUnitProperties

  describe "(Concatenando com letras minúsculas)" do
    
    test "concatenando com bb" do
      check all a <- StreamData.binary(), b <- StreamData.binary() do
        assert Concat.concat_bb(a, b) == a <> "bc" <> b
      end
    end
  end
end