-module(exchange).
-export([each_pv/3]).

each_pv(none, RequestId,Catalog) -> 
    {_, Msg} = disp(
        campaign(RequestId,Catalog),
        RequestId,
        Catalog
    ),
    io:format("request: ~p~n", [Msg] );
each_pv(Pid, RequestId,Catalog) -> 
    Pid ! disp(
        campaign(RequestId,Catalog),
        RequestId,
        Catalog
    ).

campaign(RequestId,"S") ->
    {ad,string:concat("Sport:",RequestId)};
campaign(RequestId,"R") ->
    {ad,string:concat("Reading:",RequestId)};
campaign(_,_) -> null.

disp(null,RequestId,"S") ->
    {ad,string:concat("network Sport:",RequestId)};
disp(null,RequestId,"R") ->
    {ad,string:concat("network Reading:",RequestId)};
disp(null,RequestId,_) ->
    {ad,string:concat("network others:",RequestId)};
disp(Ad,_,_) -> Ad.


