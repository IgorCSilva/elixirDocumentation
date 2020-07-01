defmodule ElixirDocumentationThree do
  @moduledoc false

  @doc """
  Retorna o maior número de uma lista.
  ## Parâmetros

    - list: Lista de números.

  ## Exemplos

      iex> ElixirDocumentationThree.mult([2, 4, 5, 3])
      5
  """
  def maxNumber(list), do: Enum.max(list)
end