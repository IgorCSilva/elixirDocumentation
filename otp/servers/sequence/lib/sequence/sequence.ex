defmodule Sequence.Server do
  @moduledoc """
  Using GenServer.
  """
  use GenServer

  @doc """
  Função chamada ao inicializar o módulo, definindo
  seu estado inicial.
  """
  def init(initial_state) do
    {:ok, initial_state}
  end

  @doc """
  Retorna o número salvo no state e o atualiza com o valor incrementado.
  """
  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  @doc """
  Incrementa o atual valor do state.
  """
  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end

end
