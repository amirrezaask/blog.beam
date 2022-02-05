-module(blogerl_storage_dets).
-behaviour(blogerl_storage).
-define(TABLE, blogerl_dets_table).
-export([init/1, get/1, add/1, list/0]).

add({Title, Body}) ->
    dets:insert(?TABLE, {binary_to_list(Title), Body}),
    dets:sync(?TABLE).

get(Title) ->
    [{Title, Body}] = dets:lookup(?TABLE, Title),
    {ok, {Title, Body}}.

list() ->
    io_lib:format("~p", [titles(?TABLE)]).

init(Options) ->
    dets:open_file(?TABLE, [{access, read_write}, {auto_save, 1000} | Options]).

titles(TableName) ->
    FirstKey = dets:first(TableName),
    titles(TableName, FirstKey, [FirstKey]).

titles(_TableName, '$end_of_table', ['$end_of_table' | Acc]) ->
    Acc;
titles(TableName, CurrentKey, Acc) ->
    NextKey = dets:next(TableName, CurrentKey),
    titles(TableName, NextKey, [NextKey | Acc]).
