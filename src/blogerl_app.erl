%%%-------------------------------------------------------------------
%% @doc blogerl public API
%% @end
%%%-------------------------------------------------------------------

-module(blogerl_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    blogerl_sup:start_link(blogerl_storage_dets),
    setup_cowboy(blogerl_storage_dets).

setup_cowboy(Storage_mod) ->
    Dispatch = cowboy_router:compile([
        {'_', [
            {"/:title", blogerl_index_h, #{storage_mod => Storage_mod, storage_pid => Storage_mod}},
            {"/", blogerl_index_h, #{storage_mod => Storage_mod, storage_pid => Storage_mod}}
        ]}
    ]),
    {ok, _} = cowboy:start_clear(http, [{port, 8080}], #{
        env => #{dispatch => Dispatch}
    }).
stop(_State) ->
    ok.

%% internal functions
