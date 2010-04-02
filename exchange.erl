-module(exchange).
-export([disp/3]).

disp(null,RequestId,"S") ->
    {ad,string:concat("network Sport:",RequestId)};
disp(null,RequestId,"R") ->
    {ad,string:concat("network Reading:",RequestId)};
disp(null,RequestId,_) ->
    {ad,string:concat("network others:",RequestId)};
disp(Ad,_,_) -> Ad.
