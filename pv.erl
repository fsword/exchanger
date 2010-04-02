-module(pv).
-export([start/0,inner_network/2,exchange_ad/3]).

start() -> spawn(fun() -> serv() end).

serv() ->
    receive
        { Pid, RequestId, Catalog } ->
            spawn(fun() -> pv_process(Pid,RequestId,Catalog) end),
        serv()
    end.

pv_process(none, RequestId,Catalog) -> 
    {_, Msg} = exchange_ad(
        inner_network(RequestId,Catalog),
        RequestId,
        Catalog
    ),
    io:format("request: ~p~n", [Msg] );
pv_process(Pid, RequestId,Catalog) -> 
    Pid ! exchange_ad(
        inner_network(RequestId,Catalog),
        RequestId,
        Catalog
    ).

inner_network(RequestId,"S") ->
    {ad,string:concat("Sport:",RequestId)};
inner_network(RequestId,"R") ->
    {ad,string:concat("Reading:",RequestId)};
inner_network(_,_) -> null.
    
exchange_ad(null,RequestId,"S") ->
    {ad,string:concat("network Sport:",RequestId)};
exchange_ad(null,RequestId,"R") ->
    {ad,string:concat("network Reading:",RequestId)};
exchange_ad(null,RequestId,_) ->
    {ad,string:concat("network others:",RequestId)};
exchange_ad(Ad,_,_) -> Ad.


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
