-module(engine).
-export([start/0,each_pv/4,test/0]).

start() -> spawn(fun() -> serv(engine) end).

serv(Mod) ->
    receive
        { update, NewMod } ->
            io:format("module updated: ~p~n", [NewMod] ),
            serv(NewMod);
        { Pid, ACookie, EnvTags, AdZoneTags } ->
            spawn(Mod,each_pv,[Pid,ACookie,EnvTags, AdZoneTags]),
            serv(Mod)
    end.

each_pv(Pid, ACookie, EnvTags, AdZoneTags) -> 
    io:format("request: Pid = ~p, ACookie = ~p, EnvTags = ~p, AdZoneTags =~p.~n", [Pid,ACookie,EnvTags,AdZoneTags] ).

test() ->
    X = engine:start(),
    X ! { update, exchange },
    X ! { none, '121383931', ["Sport",fds,f,dsfsd,fsdaf,sa],['adsa',cosls] },
    X ! { none, '121383931', ["Sport",fds,f,dsf,fsdaf,sa],['adsa',cosls] },
    X.

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
