-module(blogerl_storage).
-export([start_link/1, behaviour_info/1]).
-export([add/3, get/2, list/1]).

behaviour_info(callbacks) ->
    [{add, 3}, {get, 2}, {list, 1}, {start_link, 0}].

add({Mod, Pid}, Title, Body) ->
    apply(Mod, add, [Pid, Title, Body]).

get({Mod, Pid}, Title) ->
    apply(Mod, get, [Pid, Title]).

list({Mod, Pid}) ->
    apply(Mod, list, [Pid]).

start_link(Mod) ->
    {ok, Pid} = apply(Mod, start_link, []),
    {ok, Pid}.
