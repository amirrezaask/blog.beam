-module(blogerl_storage_dets).
-behaviour(blogerl_storage).
-behaviour(gen_server).
-define(DEFAULT_TABLE, blog_table).
-export([init/1, handle_call/3, handle_cast/2, start_link/0]).
-export([add/3, get/2, list/1]).

% API
start_link() ->
    gen_server:start_link({local, ?MODULE}, ?MODULE, [], []).

add(Pid, Title, Body) ->
    gen_server:cast(Pid, {add, {Title, Body}}).
get(Pid, Title) ->
    gen_server:call(Pid, {get, Title}).
list(Pid) ->
    gen_server:call(Pid, list).

% Gen Server
handle_cast({add, {Title, Body}}, #{conn := Conn} = State) ->
    dets:insert(Conn, {binary_to_list(Title), Body}),
    dets:sync(Conn),
    {noreply, State}.

handle_call({get, Title}, _From, #{conn := Conn} = State) ->
    [{Title, Body}] = dets:lookup(Conn, Title),
    {reply, Body, State};
handle_call(list, _From, #{conn := Conn} = State) ->
    {reply, io_lib:format("~p", [titles(Conn)]), State}.

init(Options) ->
    {ok, Conn} = dets:open_file(?DEFAULT_TABLE, [
        {access, read_write}, {auto_save, 1000} | Options
    ]),
    {ok, #{conn => Conn}}.

titles(TableName) ->
    FirstKey = dets:first(TableName),
    titles(TableName, FirstKey, [FirstKey]).

titles(_TableName, '$end_of_table', ['$end_of_table' | Acc]) ->
    Acc;
titles(TableName, CurrentKey, Acc) ->
    NextKey = dets:next(TableName, CurrentKey),
    titles(TableName, NextKey, [NextKey | Acc]).
