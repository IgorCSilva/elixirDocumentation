defmodule ElixirDocumentation do
  @moduledoc """
  Este módulo realiza algumas operações matemáticas.
  """

  @doc """
  Retorna a soma de dois valores.

  ## Exemplos

      iex> ElixirDocumentation.sum(3, 4)
      7
  """
  def sum(a, b) do
    a + b
  end

  @doc """
  Retorna a subtração entre o primeiro e o segundo parâmetro.

  ## Parâmetros

    - a: Um número qualquer.
    - b: Outro número qualquer.

  """
  def sub(a, b) do
    a - b
  end
end
