# Tests

### Criando projeto
```console
$> mix new {project-name}
```

- Adicionar as seguintes dependências ao projeto (`root/mix.exs`):
```elixir
# Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      #...
      {:earmark, "~> 1.2", only: :dev},
      {:ex_doc, "~> 0.19", only: :dev}
    ]
  end
```

  - ex_doc possui as funcionalidades para se trabalhar com documentação e earmark é um dos conversores de Markdown para HTML.

- Podemos adicionar também o nome e uma url para o projeto no mesmo arquivo. A url servirá para o redirecionamento para o código dentro do github.
```elixir
def project do
  [
    app: :issues,
    escript: escript_config(),
    version: "0.1.0",
    name: "Documentation",
    source_url: "https://github.com/IgorCSilva/elixir_documentation",
    elixir: "~> 1.10",
    start_permanent: Mix.env() == :prod,
    deps: deps()
  ]
end
```

- Após isso precisamos baixar as dependências. Para isso executamos:
```console
$> mix deps.get
```

### Adicionando testes
- Em `/lib/tests.ex` alterei o código para:
```elixir
defmodule Tests do
  @moduledoc """
  Manipulando strings.
  """

  @doc """
  Retira todos caracteres 'a' de uma string.

  ## Examples

      iex> Tests.remove_a("balada")
      "bld"
      
      iex> Tests.remove_a("bondade")
      "bondde"
      
      iex> Tests.remove_a("continente")
      "continente"

  """
  def remove_a(str) do
    Regex.replace ~r{[a]}, str, ""
  end

  @doc """
  Coloca todos os caracteres em minúsculo.

  ## Examples

      iex> Tests.str_downcase("Floresta")
      "floresta"
      
      iex> Tests.str_downcase("A Casa CAIU")
      "a casa caiu"

  """
  def str_downcase(str) do
    String.downcase(str)
  end
end

```

- Aqui podemos ver alguns testes feitos em comentàrio. Isso é interessante porque além de ser um comentário, deixando mais claro como cada função deve funcionar, cada comando `iex>` é executado como teste.

- No arquivo de testes `/test/tests_test.exs` temos:
```elixir
defmodule TestsTest do
  use ExUnit.Case
  doctest Tests

  test "removendo a de dale" do
    assert Tests.remove_a("dale") == "dle"
  end
end
```
- Aqui temos um teste entitulado "removendo a de dale" e o `assert` verifica se ambos os lados do comparador `==` são iguais.
- Para rodar os testes apenas execute:
```console
$> mix test
```

- Para ver como o elixir se comporta quando um teste falha basta apenas forçar um erro, alterando alguma das strings de teste.

- Podemos realizar testes para um módulo específico. Para isso criamos o arquivo `/lib/concat.ex`. Para executar testes específicos dele criamos o arquivo `test/concat_test.exs` e executamos o seguinte:
```console
iex> mix test test/concat_test.exs
```
- Alguns error nos testes propositais serão mostrados.

- Podemos agrupar testes em comum com o `describe` e além disso setar variáveis com o `setup`. Fazendo isso as variáveis ficam acessíveis por uma nova variável chamada `fixture`. Ver arquivo `test/concat_test.exs`.

## Testes mais confiáveis.
- Para tornar nossos testes mais confiáveis podemos utilizar o `StreamData`. Com essa ferramenta valores aleatórios são gerados e testados em nossas funções. Para utilizarmos percisamos primeiro adicioná-lo ao projeto. Vá em `mix.exs` e o adicione em `deps`:
```elixir
defp deps do
    [
      #...
      {:stream_data, "~> 0.5", only: :test}
    ]
  end
```

- No arquivo `concat_use_property.exs` temos um exemplo de uso onde são geradas strings aleatórias. Para utilizarmos o `property` precisamos primeiro adicionar `use ExUnitProperties` no início do nosso módulo.

### Utilizando coveralls
- Para verificar se todo o código está passando por testes podemos usar o coveralls. Primeiro adicionamos à nossas dependências em `/mix.exs`:
```elixir
defp deps do
  [
    #..
    {:excoveralls, "~> 0.13.0", only: :test}
  ]
end
```

- Adicionando vários comandos e forçando a serem executados no ambiente de teste. No mesmo arquivo `/mix.exs`:
```elixir
ef project do
    [
      #...
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      deps: deps()
    ]
  end
```

- Sempre que adicionarmos uma dependência precisamos baixá-la, então execute:
```console
$> mix deps.get
```

- Apois isso, depois de tudo ok, podemos executar:
```console
$> mix coveralls
```
  - Este comando executará os testes primeiro e depois mostrará uma análise dos nossos arquivos. Veremos que o arquivo `lib/tests.ex` está com todas as suas funções testadas, já o arquivo `lib/concat` ainda há o que testar.