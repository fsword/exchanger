-module(engine).
-export([start/0,start/1,each_pv/3]).

start() -> spawn(fun() -> serv(engine) end).

start(Name) -> register(Name,spawn(fun() -> serv(engine) end)).

serv(Mod) ->
    receive
        { update, NewMod} ->
            io:format("module updated: ~p~n", [NewMod] ),
            serv(NewMod);
        { Pid, RequestId, Catalog } ->
            spawn(Mod,each_pv,[Pid,RequestId,Catalog]),
            serv(Mod)
    end.

each_pv(Pid, RequestId,Catalog) -> 
    io:format("request: Pid = ~p, RequestId = ~p, Catalog = ~p.~n", [Pid,RequestId,Catalog] ).

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
