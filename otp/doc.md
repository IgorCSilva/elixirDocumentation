## Ao se trabalhar com GenServer

- Podemos implementar um loop no Elixir usando uma chamada de função recursiva.
O tempo de execução do Elixir não permite nenhuma invocação
de um servidor para monopolizar a CPU para sempre. Em vez disso, define um tempo limite em cada
call ou cast para um GenServer (por padrão, 5 segundos). Se não retornar nesse período é assumido que
algo deu errado e o servidor é finalizado. Por exemplo, processamento de um milhão de arquivos em loop
leva mais de 5 segundos. Então, apenas processamos um arquivo por entrada no servidor e
em seguida, enfileire outra mensagem para processar a próxima em uma nova
entrada.