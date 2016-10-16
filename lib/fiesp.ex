defmodule Fiesp do
  # Its an Application
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    children = [
      # Define workers and child supervisors to be supervised
      Plug.Adapters.Cowboy.child_spec(:http, Fiesp.Router, [], [port: 8000]),
      worker(Fiesp.Database.Connection, [[host: "rethinkdb", port: 28015]])
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    Supervisor.start_link(children, [strategy: :one_for_one])
  end
end
