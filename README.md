# ElixirDocumentation

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

- Podemos adicionar também o nome e uma url para o projeto no mesmo arquivo:
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

- Para gerar a documentação execute:
```console
$> mix docs
```

- Agora você pode abrir o arquivo `root/docs/index.html`.

**TODO: Add description**

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `elixir_documentation` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:elixir_documentation, "~> 0.1.0"}
  ]
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/elixir_documentation](https://hexdocs.pm/elixir_documentation).

