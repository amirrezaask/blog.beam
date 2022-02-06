-module(blogerl_sup).

-behaviour(supervisor).

-export([start_link/1]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link(Storage_mod) ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, [Storage_mod]).

children(Storage_mod) ->
    [#{id => storage, start => {blogerl_storage, start_link, [Storage_mod]}}].

init([Storage_mod]) ->
    SupFlags = #{
        strategy => one_for_one,
        intensity => 1,
        period => 1
    },
    ChildSpecs = children(Storage_mod),
    {ok, {SupFlags, ChildSpecs}}.
