defmodule Blogerl.Application do
  use Application

  def start(_type, _args) do
    Blogerl.Supervisor.start_link(name: Blogerl.Supervisor)
    dispatcher = :cowboy_router.compile([
      # {HostMatch, [{PathMatch, Handler, InitialState}]
      { :_,
        [
          {"/", Blogerl.HttpHandler, []},
          {"/:title", Blogerl.HttpHandler, []},
        ]
      }
    ])
    :cowboy.start_clear(:my_http_listener,
    [{:port, 8080}],
    %{:env => %{:dispatch => dispatcher}})
  end
end
