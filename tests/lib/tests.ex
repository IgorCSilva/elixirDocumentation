defmodule Tests do
  @moduledoc """
  Manipulando strings.
  """

  @doc """
  Retira todos caracteres 'a' de uma string.

  ## Examples

      iex> Tests.remove_a("balada")
      "bld"
      
      iex> Tests.remove_a("bondade")
      "bondde"
      
      iex> Tests.remove_a("continente")
      "continente"

  """
  def remove_a(str) do
    Regex.replace ~r{[a]}, str, ""
  end

  @doc """
  Coloca todos os caracteres em minúsculo.

  ## Examples

      iex> Tests.str_downcase("Floresta")
      "floresta"
      
      iex> Tests.str_downcase("A Casa CAIU")
      "a casa caiu"

  """
  def str_downcase(str) do
    String.downcase(str)
  end
end
