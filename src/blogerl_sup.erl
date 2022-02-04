%%%-------------------------------------------------------------------
%% @doc blogerl top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(blogerl_sup).

-behaviour(supervisor).

-export([start_link/0]).

-export([init/1]).

-define(SERVER, ?MODULE).

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).
init([]) ->
    SupFlags = #{strategy => one_for_one,
                 intensity => 1,
                 period => 1},
    ChildSpecs = [#{id => storage, start => {blogerl_storage, start_link, []}}],
    {ok, {SupFlags, ChildSpecs}}.

%% internal functions
