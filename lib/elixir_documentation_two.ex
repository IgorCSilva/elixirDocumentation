defmodule ElixirDocumentationTwo do
  @moduledoc """
  Módulo que realiza operações mais avançadas.
  """

  @doc """
  Returna a multiplicação entre dois números.
  ## Parâmetros

    - a: Um número qualquer.
    - b: Outro número qualquer.

  ## Exemplos

      iex> ElixirDocumentationTwo.mult(2, 4)
      8

      iex> ElixirDocumentationTwo.mult(-3, 5)
      -15
  """
  def mult(a, b) do
    a * b
  end
end