%%%-------------------------------------------------------------------
%% @doc blogerl public API
%% @end
%%%-------------------------------------------------------------------

-module(blogerl_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    setup_cowboy(),
    blogerl_sup:start_link().

setup_cowboy() ->
    Dispatch = cowboy_router:compile([
		{'_', [
			{"/", blogerl_index_h, []}
		]}
	]),
	{ok, _} = cowboy:start_clear(http, [{port, 8080}], #{
		env => #{dispatch => Dispatch}
	}).
stop(_State) ->
    ok.

%% internal functions
