-module(pv).
-export([start/0,  inner_network/0]).

start() -> register(serv, spawn(fun() -> inner_network(), wait() end)).
inner_network() -> register(network1, spawn(fun() -> network_wait() end)).

wait() ->
    receive
        { _, RequestId, _ } ->
            network1 ! { request, RequestId },
            wait()
    end.
           
network_wait() ->
    receive
        { request, RequestId } ->
            io:format("request: ~p~n", [RequestId] )
    end.


