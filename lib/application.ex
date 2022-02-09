defmodule Blogerl.Application do
  use Application

  def start(_type, _args) do
    Blogerl.Supervisor.start_link([])
  end
end
