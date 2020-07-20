# Duper

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `duper` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:duper, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/duper](https://hexdocs.pm/duper).

## Funcionamento

- Quando a aplicação é iniciada ela começa criando o Results, em seguida PathFinder, WorkerSupervisor e por fim o Gatherer.

- Quando Gatherer se inicia, ele diz ao WorkerSupervisor para iniciar um número de Workers.

- Quando cada Worker é iniciado eles pegam um diretório através do PathFinder, calculam o hash correspondente ao arquivo em análise e passa o resultado para Gatherer, que armazen o caminho e o hash do arquivo em Results.

- Quando não há mais arquivos para processar cada Worker manda :done para Gatherer. Quando o último Worker finalizar sua atividade o Gatherer mostra o resultado.

## Executando

- Rodando o comando `mix run` ele irá executar seu aplicativo. Depois de executá-lo, o mix finaliza, mas sua aplicação ainda está iniciando e terá que trabalhar. Por isso devemos avisar ao mix para não finalizar usando `mix run --no-halt`. 