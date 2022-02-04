-module(blogerl_index_h).
-export([init/2]).
-compile({inline, [headers/0]}).
-define(STORAGE, blogerl_storage_dets).

headers() ->
    #{<<"content-type">> => <<"text/plain; charset=utf-8">>}.

init(#{method := <<"POST">>} = Req0, _) ->
    {ok, RawBody, _} = cowboy_req:read_body(Req0),
    #{<<"title">> := Title, <<"body">> := Body} = jsone:decode(RawBody),
    add_post(Req0, Title, Body);
    
init(#{method := <<"GET">>} = Req0, _) ->    
    Title = cowboy_req:binding(title, Req0),
    get_post(Req0, Title).

add_post(Req0, Title, Body) ->
    ?STORAGE:add(Title, Body),
    cowboy_req:reply(201, headers(), <<>>, Req0).

get_post(Req0, undefined) ->
    cowboy_req:reply(200, headers(), ?STORAGE:all_titles(), Req0);


get_post(Req0, Title) ->
    cowboy_req:reply(200, headers(), ?STORAGE:get(erlang:binary_to_list(Title)), Req0).
