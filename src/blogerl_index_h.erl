-module(blogerl_index_h).
-export([init/2]).
-compile({inline, [headers/0]}).

headers() ->
    #{<<"content-type">> => <<"text/plain; charset=utf-8">>}.

init(#{method := <<"POST">>} = Req, #{storage_pid := Storage_Pid, storage_mod := Storage_Mod}) ->
    {ok, RawBody, _} = cowboy_req:read_body(Req),
    #{<<"title">> := Title, <<"body">> := Body} = jsone:decode(RawBody),
    blogerl_storage:add({Storage_Mod, Storage_Pid}, Title, Body),
    cowboy_req:reply(201, headers(), <<>>, Req);
init(#{method := <<"GET">>} = Req, #{storage_pid := Storage_Pid, storage_mod := Storage_Mod}) ->
    Title = cowboy_req:binding(title, Req),
    get_post({Storage_Mod, Storage_Pid}, Req, Title).

get_post(Storage, Req, undefined) ->
    cowboy_req:reply(200, headers(), blogerl_storage:list(Storage), Req);
get_post(Storage, Req, Title) ->
    cowboy_req:reply(
        200,
        headers(),
        blogerl_storage:get(Storage, erlang:binary_to_list(Title)),
        Req
    ).
