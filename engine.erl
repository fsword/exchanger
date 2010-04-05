-module(pv).
-export([start/0,each_pv/3]).

start() -> spawn(fun() -> serv() end).

serv() ->
    receive
        { Pid, RequestId, Catalog } ->
            spawn(pv,each_pv,[Pid,RequestId,Catalog]),
        serv()
    end.

each_pv(none, RequestId,Catalog) -> 
    {_, Msg} = exchange:disp(
        inner:campaign(RequestId,Catalog),
        RequestId,
        Catalog
    ),
    io:format("request: ~p~n", [Msg] );
each_pv(Pid, RequestId,Catalog) -> 
    Pid ! exchange:disp(
        inner:campaign(RequestId,Catalog),
        RequestId,
        Catalog
    ).

    



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
