-module(blogerl_index_h).
-export([init/2]).
headers() ->
    #{<<"content-type">> => <<"text/plain; charset=utf-8">>}.


init(Req0, _) ->
    #{method := _Method} = Req0,
    #{title := Title } = cowboy_req:match_qs([{title, [], undefined}], Req0),
    respond(Req0, Title).

respond(Req0, undefined) ->
    cowboy_req:reply(400, headers(), blogerl_storage:all_titles(), Req0);

respond(Req0, Title) ->
    cowboy_req:reply(200, headers(), blogerl_storage:get(erlang:binary_to_list(Title)), Req0).