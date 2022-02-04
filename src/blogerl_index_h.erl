-module(blogerl_index_h).
-export([init/2]).

headers() ->
    #{<<"content-type">> => <<"text/plain; charset=utf-8">>}.


init(Req0, _) ->
    #{method := Method} = Req0,
    case Method of
        <<"GET">> ->
            Title = cowboy_req:binding(title, Req0),
            get_post(Req0, Title);
        <<"POST">> ->
            {ok, RawBody, _} = cowboy_req:read_body(Req0),
            #{<<"title">> := Title, <<"body">> := Body} = jsone:decode(RawBody),
            add_post(Req0, Title, Body)
    end.
    
    
add_post(Req0, Title, Body) ->
    blogerl_storage:add(Title, Body),
    cowboy_req:reply(201, headers(), <<>>, Req0).

get_post(Req0, undefined) ->
    cowboy_req:reply(200, headers(), blogerl_storage:all_titles(), Req0);


get_post(Req0, Title) ->
    cowboy_req:reply(200, headers(), blogerl_storage:get(erlang:binary_to_list(Title)), Req0).
