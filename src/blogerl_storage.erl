-module(blogerl_storage).
-export([start_link/1, handle_call/3, handle_cast/2, init/1, behaviour_info/1]).
-export([add/3, get/2, list/1]).
-behaviour(gen_server).
%% connect(Options :: [{}]) -> Conn :: atom() | PID | term()
%% get(Conn, Title) -> {found, Body} | {error, not_found}
%% add(Conn, {Title, Body})
%% list(Conn) -> []
behaviour_info(callbacks) ->
    [{add, 2}, {get, 2}, {list, 1}, {connect, 1}].

add(Storage, Title, Body) ->
    gen_server:cast(Storage, {Title, Body}).

get(Storage, Title) ->
    gen_server:call(Storage, {get, Title}).

list(Storage) ->
    gen_server:call(Storage, list).

start_link(Mod) ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, Mod, []).

init(Mod) ->
    {ok, Conn} = apply(Mod, connect, [[]]),
    {ok, {Mod, Conn}}.

handle_cast(Request, {Mod, Conn}) ->
    apply(Mod, add, [Conn, Request]),
    {noreply, {Mod, Conn}}.

handle_call({get, Title}, _, {Mod, Conn}) ->
    {reply, apply(Mod, get, [Conn, Title]), {Mod, Conn}};
handle_call(list, _, {Mod, Conn}) ->
    {reply, apply(Mod, list, [Conn]), {Mod, Conn}}.
