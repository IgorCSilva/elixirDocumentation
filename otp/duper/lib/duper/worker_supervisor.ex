defmodule Duper.WorkerSupervisor do
  # Trazendo as funcionalidades de supervisão.
  use DynamicSupervisor

  @me WorkerSupervisor

  @doc """
  Inicia o módulo contendo o código do supervisor.
  """
  def start_link(_) do
    DynamicSupervisor.start_link(__MODULE__, :no_args, name: @me)
  end

  @doc """
  Função chamada ao se iniciar o módulo.
  """
  def init(:no_args) do
    # Inicia o código do supervisor.
    DynamicSupervisor.init(strategy: :one_for_one)
  end

  @doc """
  Adiciona um novo filho worker.
  """
  def add_worker() do
    # Iniciando um novo Duper.Worker. A cada chamada um novo server é lançado.
    {:ok, _pid} = DynamicSupervisor.start_child(@me, Duper.Worker)
  end
end
