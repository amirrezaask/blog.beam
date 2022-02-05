-module(blogerl_storage_dets).
-behaviour(blogerl_storage).
-define(DEFAULT_TABLE, blogerl_dets_table).
-export([connect/1, get/2, add/2, list/1]).

% Storage impl
connect(Options) ->
    dets:open_file(?DEFAULT_TABLE, [
        {access, read_write}, {auto_save, 1000} | Options
    ]).

list(Conn) ->
    io_lib:format("~p", [titles(Conn)]).

add(Conn, {Title, Body}) ->
    dets:insert(Conn, {binary_to_list(Title), Body}),
    dets:sync(Conn).

get(Conn, Title) ->
    [{Title, Body}] = dets:lookup(Conn, Title),
    {ok, {Title, Body}}.

titles(TableName) ->
    FirstKey = dets:first(TableName),
    titles(TableName, FirstKey, [FirstKey]).

titles(_TableName, '$end_of_table', ['$end_of_table' | Acc]) ->
    Acc;
titles(TableName, CurrentKey, Acc) ->
    NextKey = dets:next(TableName, CurrentKey),
    titles(TableName, NextKey, [NextKey | Acc]).
