-module(blogerl_storage).
-export([start_link/1, handle_call/3, handle_cast/2, init/1, behaviour_info/1]).
-export([add/3, get/2, list/1]).
-behaviour(gen_server).

behaviour_info(callbacks) ->
    [{add, 1}, {get, 1}, {list, 0}, {init, 1}].

add(Storage, Title, Body) ->
    gen_server:cast(Storage, {Title, Body}).

get(Storage, Title) ->
    gen_server:call(Storage, {get, Title}).

list(Storage) ->
    gen_server:call(Storage, list).

start_link(Mod) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, Mod, []).

init(Mod) ->
    apply(Mod, init, [[]]),
    {ok, Mod}.

handle_cast(Request, Mod) ->
    apply(Mod, add, [Request]),
    {noreply, Mod}.

handle_call({get, Title}, _, Mod) ->
    {reply, apply(Mod, get, Title), Mod};
handle_call(list, _, Mod) ->
    {reply, apply(Mod, list, []), Mod}.
