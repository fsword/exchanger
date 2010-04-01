-module(pv).
-export([serv/0,wait/0]).

start() -> spawn(fun() -> serv() end).

serv() ->
    receive
        { RequestPid, RequestId, Catalog } ->
            spawn(fun() -> pv_process(RequestPid,RequestId,Catalog) end),
            serv().
    end.
           
           
pv_process(RequestPid, RequestId,Catalog) -> 
    ResponseAd = inner_network(RequestId,Catalog),
    Ad = exchange_ad(ResponseAd, RequestId,Catalog),
    RequestPid ! Ad


inner_network(RequestId,"S") ->
    {ad,"Sport"};
inner_network(RequestId,"R") ->
    {ad,"Reading"};
inner_network(Request,_) -> null.
    
exchange_ad(null,RequestId,"S") ->
    {ad,"network Sport"};
exchange_ad(null,RequestId,"R") ->
    {ad,"network Reading"};
exchange_ad(null,RequestId,"R") ->
    {ad,"network others"}.
    

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
