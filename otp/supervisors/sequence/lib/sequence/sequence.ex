defmodule Sequence.Server do

  use GenServer

  @server __MODULE__
  
  #### Funções para as APIs externas acessarem.
  # Dando nome ao processo podemos trabalhar com ele sem manipular seu pid.
  def start_link(_) do
    IO.puts "Lançando Server"
    GenServer.start_link(__MODULE__, nil, name: @server)
  end

  def next_number do
    GenServer.call(@server, :next_number)
  end

  def increment_number(delta) do
    GenServer.cast(@server, {:increment_number, delta})
  end


  ######
  # Implementação GenServer.
  alias Sequence.Stash


  @doc """
  Função chamada ao inicializar o módulo, definindo
  seu estado inicial.
  """
  def init(_) do
    {:ok, Stash.get()}
  end

  @doc """
  Retorna o número salvo no state e o atualiza com o valor incrementado.
  """
  def handle_call(:next_number, _from, current_number) do
    {:reply, current_number, current_number + 1}
  end

  @doc """
  Incrementa o atual valor do state e não retorna.
  """
  def handle_cast({:increment_number, delta}, current_number) do
    {:noreply, current_number + delta}
  end

  @doc """
  Enviando estado atual para o Stash para ser salvo
  antes de finalizar o processo.
  """
  def terminate(_reason, current_number) do
    Stash.update(current_number)
  end

end
