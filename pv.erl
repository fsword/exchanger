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
%% start a server to receive pv
%% while true 
%%   receive a pv
%%   send pv to inner network
%% end
%% 
%% receive a inner campain result
%% success: make a response
%% failure: 
%%     while retrieve all linked network
%%          create a process to send a request for campaign
%% 
%% receive a linked network campaign( timer todo )
%%     bidding
%%     make a response
