defmodule Concat do
  @moduledoc """
  Trabalhando com concatenação de strings.
  """

  @doc """
  Concatenando duas strings separadas por "TT".

  ## Example

      iex> Concat.concat_TT("oi", "show")
      "oiUUshow"
  """
  def concat_TT(str1, str2) do
    str1 <> "TT" <> str2
  end
  
  @doc """
  Concatenando duas strings separadas por "TT".
  """
  def concat_MM(str1, str2) do
    str1 <> "MM" <> str2
  end

  @doc """
  Concatenando duas strings separadas por "aa".
  """
  def concat_aa(str1, str2) do
    str1 <> "aa" <> str2
  end
  
  @doc """
  Concatenando duas strings separadas por "bb".
  """
  def concat_bb(str1, str2) do
    str1 <> "bb" <> str2
  end
end