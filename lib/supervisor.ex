defmodule Blogerl.Supervisor do
  use Supervisor
  def start_link(opts) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  def init(_) do
    children = [
      {Plug.Cowboy, scheme: :http, plug: Blogerl.Handler, options: [port: 8080]},
      Blogerl.Storage.Dets
    ]
    Supervisor.init(children, strategy: :one_for_one)
  end
end
