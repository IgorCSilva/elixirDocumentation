defmodule ConcatTest do
  use ExUnit.Case
  doctest Concat

  test "concatenando com TT" do
    assert Concat.concat_TT("Vamos", "embora") == "VamosdTembora"
  end

  describe "(Concatenando com letras minúsculas)" do

    setup do [
      str1: "Vamos",
      str2: "embora",
      concat_aa: "Vamosaaembora",
      concat_bb: "Vamosbbembora"
    ]
    end
    
    test "concatenando com aa", fixture do
      assert Concat.concat_aa(fixture.str1, fixture.str2) == fixture.concat_aa
    end

    test "concatenando com bb", fixture do
      assert Concat.concat_bb(fixture.str1, fixture.str2) == fixture.concat_bb
    end
  end
end