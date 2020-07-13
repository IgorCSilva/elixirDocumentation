defmodule Stack.Server do
  @moduledoc """
  Manipulando uma pilha.
  """

  use GenServer

  alias Stack.Impl

  @doc """
  Defini o estado inicial.
  """
  def init(initial_state) do
    {:ok, initial_state}
  end

  @doc """
  Retirando um elemento da pilha.
  """
  def handle_call(:pop, _from, current_stack) do
    {:reply, Impl.head(current_stack), Impl.tail(current_stack)}
  end

  @doc """
  Adiciona um elemento à pilha.
  """
  def handle_cast({:push, value}, current_stack) do
    {:noreply, Impl.add(value, current_stack)}
  end

  @doc """
  Captura dados quando o processo é terminado.
  """
  def terminate(reason, state) do
    IO.inspect state
    IO.puts reason
  end
end