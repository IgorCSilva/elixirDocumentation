
# Links para aprender elixir
https://github.com/adolfont/elixir_cop/blob/master/companies/countries/brazil/resources.md

# Instalando o Elixir
https://elixir-lang.org/install.html


# Bom ver primeiro.
https://elixirschool.com/pt/lessons/basics/iex-helpers/ (mostra como ler documentação dos módulos e como utilizá-los com exemplos.)

# Dicas
- Os dados são imutáveis. Codar em elixir é transformar os dados a cada passo(função) para se obter o resultado no final.
- Funções padrões do Elixir e Erlang utilizam (_). Ex.: String.to_integer().
- Sempre documentar os módulos. Utilizando @moduledoc false quando não quiser descrever algo.

# Tutorial
- Executando iex no terminal você entra no terminal iterativo do elixir.

```console
$ iex

  Erlang/OTP 20 [erts-9.1] [source] [64-bit] [smp:4:4] [ds:4:4:10]
  [async-threads:10] [hipe] [kernel-poll:false]h
  Interactive Elixir (x.y.z) - press Ctrl+C to exit (type h() ENTER for h
  elp)

iex(1)>
```

### Compilando seus arquivos.
- Fora do iex:
```console
$ elixir hello.exs
```

- Dentro do iex:
```console
iex(1)> c "hello.exs"
```
# Aprendizado
- Maior parte dos conceitos e código abaixo foram extraídos do livro `Programming Elixir ≥ 1.6_ Functional __Concurrent __Pragmatic __Fun`, de Dave Thomas.

### Exemplos de Regex
```console
iex> Regex.run ~r{[aeiou]}, "caterpillar"
["a"]
iex> Regex.scan ~r{[aeiou]}, "caterpillar"
[["a"], ["e"], ["i"], ["a"]]
iex> Regex.split ~r{[aeiou]}, "caterpillar"
["c", "t", "rp", "ll", "r"]
iex> Regex.replace ~r{[aeiou]}, "caterpillar", "*"
"c*t*rp*ll*r"
```

### Parâmetros default
defmodule Example do
  def func(p1, p2 \\ 2, p3 \\ 3, p4) do
    IO.inspect [p1, p2, p3, p4]
  end
end

```console
Example.func("a", "b") # => ["a",2,3,"b"]
Example.func("a", "b", "c") # => ["a","b",3,"c"]
Example.func("a", "b", "c", "d") # => ["a","b","c","d"]
```

### Operador Pipe |>
- Sem ele:
filing = prepare_filing(sales_tax(Orders.for_customers(DB.find_customers), 2018))

- ou
people = DB.find_customers
orders = Orders.for_customers(people)
tax = sales_tax(orders, 2018)
filing = prepare_filing(tax)

- Com ele:
filing = DB.find_customers
  |> Orders.for_customers
  |> sales_tax(2018)
  |> prepare_filing


### Qual escolher entre Maps, Structs, e lista de palavras chaves.
siga a ordem:
• Você quer realizar pattern-match com o conteúdo? (por exemplo dar match em :name onde quer que ele esteja)
  Se sim use map.
• Deseja mais de uma entrada com a mesma chave?
  Se sim lista de palavras chaves.
• Precisa garantir que os elementos estão em ordem?
  Se sim lista de palavras chaves.
• A estrutura do dado deve ser sempre a mesma?
  Se sim use Struct.
• Se você chegou até aqui ent:
  Use a map.

### 'string' vs "string"
- Usando '' temos uma lista de caracteres.
- Usando "" temos uma lista de bytes. (Pode-se utilizar mais de um byte para representar um único caracter)

### Tornando o projeto executável por linha de comando.

- Crie um projeto.
```console
$> mix new escript
```

- Siga os seguintes passos:
  - Em escript > lib cria uma pasta chamada escript. Nela crie o arquivo cli.ex. Em cli.ex crie um módulo chamado Escript.CLI e uma função main que vai receber os argumentos enviados pelo terminal.
  ```js
  defmodule Escript.CLI do
    def main(argv) do
      OptionParser.parse(argv, switches: [help: :boolean], aliases: [h: :help])
      |> IO.inspect
    end
  end
  ```
  - No arquivo mix.exs adicione 'escript: escrip_config(),' em def project.
  - Adicione a função abaixo:
  ```js
    defp escript_config do
      [
      main_module: Escript.CLI
      ]
    end
  ```
  - Compile e empacote a aplicação:
  ```console
  $> mix escript.build
  ```
  - Agora você pode executar
  ```console
  $> ./escript arg1 arg2
  $> ./escript -h
  ```

### Interagir com um projeto usando o iex.
```console
$> iex -S mix
```

### Usar Logger é uma boa para seguir o fluxo de sua aplicação

### Debugging

- Adicionando breakpoint
```js
require IEx; IEx.pry
```

- Ao entrar no modo pry e chamar binding veremos as variáveis locais.

### Testes
- Podemos criar testes nos comentários das funções, como:
```js
defmodule OpSum do

  @doc"""
  Recebe dois números e os soma.
  ## Example
    iex> OpSum.sum(8, 4)
    12
    iex> OpSum.sum(1, 7)
    3
  """
  def sum(a, b) do
    a + b
  end
end
```
- Aqui podemos criar um arquivo chamado doc_test.exs dentro da pasta test do projeto criado e adicionar o seguinte código a ele:
```js
defmodule DocTest do
  use ExUnit.Case
  doctest OpSum
end
```
- Após isso podemos rodar os doctests separadamente, executando a partir da raíz do projeto:
```console
$> mix test test/doc_test.exs
```
- Estes testes também ficam inclusos ao executar os testes gerais:
```console
$> mix test
```

### Estrutura do projeto
- Árvore de dependências da aplicação.
```console
$> mix xref graph
```

- Árvore de dependências da aplicação e gerando sequência de dependências no formato dot.
```console
$> mix xref graph --format dot
```

- Instalar visualizador de gráficos para gerar imagens das dependências.
```console
$> sudo apt install graphviz
```

- Gerando imagem com grafo de dependências.
```console
$> dot -Grankdir=LR -Epenwidth=2 -Ecolor=#a0a0a0 -Tpng xref_graph.dot -o xref_graph.png
```

### Monitorando servidor
- Monitorar alocação de memória, processos e muito mais.
```console
iex> :observer.start()
```

## Processos
- Para lançar um processo podemos usar spawn.
```elixir
defmodule Spawn1 do
  def greet do
    receive do
      {:ok, msg} -> IO.puts msg
      greet()
    end
  end
end

# The client.
pid = spawn(Spawn1, :greet, [])
send pid, {:ok, "World!"}
```
- O spawn retorna o id do processo(pid). Aqui o `send` foi utilizado para mandar uma mensagem para o processo lançado. Assim a função lançada `greet` vai receber a mensagem e mostrá-la usando `IO.puts`.

- Para linkar dois processos, com o objetivo de um ficar sabendo quando o outro apresentar problema, usamos o `spawn_link`. Caso um processo apresente algum problema o outro também parará de executar.
```elixir

defmodule Link1 do
  import :timer, only: [sleep: 1]

  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run do
    # Quando um processo finaliza sua execução de forma inesperada(usando exit, por exemplo)
    # toda a aplicação para. Para que isso não aconteça precisamos fazer com que o exit nos
    # envie uma mensagem, e para isso usamos trap_exit.
    Process.flag(:trap_exit, true)

    # Lançando processo linkado. Com isso, quando um processo
    # é finalizado o outro fica sabendo.
    spawn_link(Link1, :sad_function, [])
    
    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing heppened as far as I am concerned"
    end
  end
end

Link1.run
```

- Também temos como fazer com que um processo monitore outro com `spawn_monitor`. Diferente do `spawn_link`, este possui apenas uma direção. Apenas o processo que criou monitora o processo criado, além de quando o processo criado parar de executar por algum motivo o processo que monitora continuará sua execução normalmente.
```elixir
defmodule Monitor1 do
  import :timer, only: [ sleep: 1 ]

  def sad_function do
    sleep 500
    exit(:boom)
  end

  def run do
    res = spawn_monitor(Monitor1, :sad_function, [])
    IO.puts inspect res

    receive do
      msg ->
        IO.puts "MESSAGE RECEIVED: #{inspect msg}"
    after 1000 ->
      IO.puts "Nothing heppened as far as I am concerned"
    end
  end

end

Monitor1.run
```

- Então devemos utilizar `spawn_link` quando algum processo apresentar problema e for necessário finalizar a execução do outro. Já o `spawn_monitor` deve ser utilizado quando se quer saber quando algum outro processo foi finalizado por qualquer razão. Utilizando
`exit` temos informações de qual problema ocorreu e qual o id do processo. Já utilizando `raise` temos uma informação adicional, que é a função onde ocorreu o problema.

### Map Parallel

- Podemos usar a função map para lançar vários processos e coletar suas mensagens depois. O símbolo ^ faz com que as mensagens sejam coletadas na ordem que os processos foram lançados.
```elixir
defmodule Parallel do
  def pmap(collection, fun) do
  me = self()
  collection
  |> Enum.map(fn (elem) ->
    spawn_link fn -> (send me, { self(), fun.(elem) }) end
  end)
  |> Enum.map(fn (pid) ->
    receive do { ^pid, result } -> result end
  end)
  end
end
```

## Nodes
- Quando se pensa em escala devemos ter em mente o conceito de nós, que é uma abstração para uma máquina. Aprendendo a trabalhar com vários nós estaremos nos habiliando a trabalhar de forma distribuída.

# OTP
- OTP (Open Telecom Protocol) é um método que facilita o desenvolvimento e gerenciamento de projetos.

- Com o GenServer podemos lançar um processo linkado.
```console
iex> {:ok, pid} = GenServer.start_link(Module.Name, initial_state)
```
- Podemos rastrear o fluxo de chamadas usando o :trace:
```console
iex> {:ok,pid} = GenServer.start_link(Sequence.Server, 100, [debug: [:trace]])
```
- ou ativando ele durante a execução:
```console
iex> :sys.trace pid, true
```
- Obtendo dados estatísticos de sua execução:
```console
iex> {:ok,pid} = GenServer.start_link(Sequence.Server, 100, [debug: [:statistics]])
iex> code...
iex> more code...
iex> :sys.statistics pid, :get
```
- Obtendo status:
```console
iex> :sys.get_status pid
```

# Supervisores
- Supervisores têm a função de gerenciar outros processos, que podem ser workers(processos que realizam alguma tarefa) ou outros supervisores.
- Supervisores possuem rotinas para "ressucitar" um processo quando ele sofre algum problema e para de funcionar.
- Quando um processo revive ele volta para o seu estado inicial. Para que isso não ocorra e o seu estado logo antes de morrer seja mantido usamos o ideia de `Stash`, que é um processo que armazena o estado do processo `Server` antes dele morrer.