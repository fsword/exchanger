-module(inner).
-export([campaign/2]).

campaign(RequestId,"S") ->
    {ad,string:concat("Sport:",RequestId)};
campaign(RequestId,"R") ->
    {ad,string:concat("Reading:",RequestId)};
campaign(_,_) -> null.

%% find a matched campaign for pv
%%   get a pv
%%   matched campaign
%%   response a campaign

