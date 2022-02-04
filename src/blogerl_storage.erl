-module(blogerl_storage).
-export([start_link/0, init/1, handle_call/3, handle_cast/2, get/1, add/2, all_titles/0]).

-behaviour(gen_server).

% #{title => body}
% API
get(T) ->
    gen_server:call(storage, {get, T}).

add(T,B) ->
    gen_server:call(storage, {add, {T, B}}).


all_titles() ->
    gen_server:call(storage, list).

% Implementations
start_link() ->
    gen_server:start_link({local, storage}, ?MODULE, #{"first" => "post"}, []).

init(InitialPosts) ->
    {ok, InitialPosts}.

handle_call({get, PostTitle}, _From, State) ->
    #{PostTitle := PostObj } = State,
    {reply, PostObj, State};

handle_call(list, _From, State) ->
    {reply, maps:keys(State), State}.

handle_cast({add, {PostTitle, PostBody}}, State) ->
    {noreply, State#{ PostTitle := PostBody }}.
    