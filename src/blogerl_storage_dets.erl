-module(blogerl_storage_dets).
-behaviour(gen_server).
-export([init/1, handle_call/3, handle_cast/2, get/1, add/2, all_titles/0, start_link/0]).

add(Title, Body) ->
    gen_server:cast(storage, {Title, Body}).

get(Title) ->
    gen_server:call(storage, Title).

all_titles() ->
    gen_server:call(storage, list).

start_link() ->
    gen_server:start_link({local, storage}, ?MODULE, #{}, []).

init(_) ->
    dets:open_file(blogerl_dets_storage, [{access, read_write}, {auto_save, 1000}]).
    

handle_call(list, _From, State) ->
    {reply, dets:match_object(State, "_"), State};

handle_call(Key, _From, State) ->
    [{Key, Body}] = dets:lookup(State, Key),
    {reply, Body , State}.


handle_cast({Title, Body}, State) ->
    dets:insert(State, {binary_to_list(Title), Body}),
    dets:sync(State),
    {noreply, State}.

