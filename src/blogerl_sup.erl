-module(blogerl_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

children() -> [#{id => storage, start => {blogerl_storage, start_link, [blogerl_storage_dets]}}].

init([]) ->
    SupFlags = #{
        strategy => one_for_one,
        intensity => 1,
        period => 1
    },
    ChildSpecs = children(),
    {ok, {SupFlags, ChildSpecs}}.
