# Fibonacci

- Neste código recebemos como entrada uma lista de números, que indicam as posições na sequência de fibonacci, e temos como resposta o número fibonacci daquela posição. Aqui analisamos o desempenho utilizando de 1 a 10 processos e conseguirmos ver que, dependendo da quantidade de core da sua máquina, o tempos de execução diminui assim que a quantidade de processos aumenta.

- Temos aqui dois personagens em ação: o Scheduler e o Server.
  - O Scheduler tem a função de, recebendo a entrada, lançar a quantidade de Servers(processos) indicados e gerenciar as tarefas entre eles. Quando um Server estiver pronto para trabalhar o Schueduler deve fornecer um número para ele calcular. Quando um Server responder o Scheduler deve armazenar sua resposta e quando não houver mais tarefas os Servers devem ser desativados.
  - O Server receberar um número e retornará o número de fibonacci naquela posição.