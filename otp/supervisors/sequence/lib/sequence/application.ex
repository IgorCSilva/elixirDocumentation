defmodule Sequence.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @doc """
  Quando a aplicação se inicia esta função é chamada para
  a criação de um supervisor. Uma lista de módulos filhos.
  """
  def start(_type, _args) do
    # Declarar os nomes dos módulos a serem supervisionados
    # e os argumentos passados à eles quando se iniciam.
    children = [
      { Sequence.Stash, 123},
      { Sequence.Server, nil}
    ]

    # Opções de suporte estratégias.
    # Ver https://hexdocs.pm/elixir/Supervisor.html
    opts = [strategy: :rest_for_one, name: Sequence.Supervisor]
    
    # Criando o processo Supervisor. Ele executará o start_link
    # para cada processo filho.
    Supervisor.start_link(children, opts)
  end
end
