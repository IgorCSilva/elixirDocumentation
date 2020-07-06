defmodule FibSolver do
  @moduledoc """
  Calcula o valor da sequência fibonacci na posição n.
  """
  def fib(scheduler) do
    # Enviando ao Scheduler que o processo está pronto.
    send(scheduler, {:ready, self()})

    # Esperando pela tarefa enviada pelo Scheduler.
    receive do
      # Calculando o fibonacci e enviando de volta ao Scheduler.
      {:fib, n, client} ->
        send(client, {:answer, n, fib_calc(n), self()})
        # Utilizando recursão para esperar uma nova tarefa.
        fib(scheduler)

      # Quando não houver mais tarefa o Scheduler diz ao processo que ele 
      # pode ser finalizado.
      {:shutdown} ->
        exit(:normal)
    end
  end

  # Forma ineficiente de calcular Fibonacci.
  defp fib_calc(0), do: 0
  defp fib_calc(1), do: 1
  defp fib_calc(n), do: fib_calc(n - 1) + fib_calc(n - 2)
end


defmodule Scheduler do
  @moduledoc """
  Gerencia atividades, envidando tarefas e coletando respostas dos processos lançados.
  """

  @doc """
  Lança a quantidade de processos desejados.
  """
  def run(num_processes, module, func, to_calculate) do
    (1..num_processes) # Lista com a quantidade de processos.
    |> Enum.map(fn(_) -> spawn(module, func, [self()]) end) # Lançamento dos processos.
    |> schedule_processes(to_calculate, []) # Chama a função que irá gerenciar as tarefas.
  end

  @doc """
  Gerencia as taferas designadas aos processos.
  """
  defp schedule_processes(processes, queue, results) do
    # Esperando receber alguma mensagem.
    receive do
      # Caso o padrão da mensagem indique que um processo está pronto
      # para realizar uma tarefa '{:ready, pid}' e ainda há tarefa a
      # ser realizada 'queue != []'.
      {:ready, pid} when (queue != []) ->
        [next | tail] = queue # Pegando a próxima tarefa.
        send(pid, {:fib, next, self()}) # Enviando a tarefa ao processo que sinalizou estar pronto.
        schedule_processes(processes, tail, results) # Volta para esperar novas mensagens.
      
      # Caso o processo esteja pronto e não haja mais tarefa.
      {:ready, pid} ->
        # Sinalizando ao processo que ele pode ser finalizado.
        send(pid, {:shutdown})
        # Se esse não foi o último processo a ser finalizado,
        # voltar e esperar por mais mensagens de resposta.
        if (length(processes) > 1) do
          schedule_processes(List.delete(processes, pid), queue, results)
        else
          # Caso tenha sido o último processo, retornar o resultado ordenado.
          Enum.sort(results, fn({n1, _}, {n2, _}) -> n1 <= n2 end)
        end

      # Recebendo mensagem de resultado enviada por algum processo.
      {:answer, number, result, _pid} ->
        schedule_processes(processes, queue, [{number, result} | results])
    end
  end
end

# Gerando uma lista de números 37, 20 vezes.
to_process = List.duplicate(37, 20)

# Executando o programa utilizando de 1 processo a 10, para analisar quanto tempo cada caso leva.
Enum.each(1..10, fn(num_processes) ->
  
  # Executando o Scheduler e medindo seu tempo de execução.
  {time, result} = :timer.tc(Scheduler, :run, [num_processes, FibSolver, :fib, to_process])
  
  # Mostrando resultado para o caso de 1 processo e colocando cabeçalho da medida de tempo.
  if (num_processes == 1) do
    IO.puts inspect result
    IO.puts "\n # time (s)"
  end
  
  # Mostrando tempo formatado.
  :io.format("~2B  ~.2f~n", [num_processes, time/1000000.0])
end)