-module(skeleton).

-behaviour(application).
-behaviour(supervisor).

-export([start/0, stop/0]).
-export([start/2, stop/1]).
-export([init/1]).

start() ->
    ok = lager:start(),
    application:start(?MODULE).

stop()  ->
    application:stop(?MODULE).

%% Application callbacks

start(_Type, _Args) ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

stop(_State) ->
    ok.

%% Supervisor callbacks

init([]) ->
    Server = {skeleton_server, {skeleton_server, start_link, []},
              permanent, 1000, worker, [skeleton_server]},
    {ok, {{one_for_one, 10, 10}, [Server]}}.
