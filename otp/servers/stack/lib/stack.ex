defmodule Stack do
  @moduledoc """
  Api da pilha.
  """

  # Módulo do server da pilha.
  @stack Stack.Server

  # Iniciando a pilha com um estado inicial.
  def start(inicial_state) do
    GenServer.start_link(@stack, inicial_state, name: @stack)
  end

  @doc """
  Retirando um elemento da pilha.
  """
  def pop do
    GenServer.call(@stack, :pop)
  end

  @doc """
  Adiciona uma lista de elementos à pilha.
  """
  def push(value) do
    GenServer.cast(@stack, {:push, value})
  end

end