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

- Para gerar a documentação execute:
```console
$> mix docs
```

- Agora você pode abrir o arquivo `root/docs/index.html`.

### Importante

- Para manter as boas práticas é recomendável sempre documentar um módulo. Caso não se queira documentá-lo pelo menos não o deixe em branco, digitando `@moduledoc false` como foi feito no `ElixirDocumentationThree`. Desta forma o módulo(incluindo suas funções) não serão mostrados na documentação gerada.