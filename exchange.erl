-module(exchange).
-export([each_pv/4]).

each_pv(none, ACookie, EnvTags, AdZoneTags) -> 
    {script, Scripts} = campaign(ACookie,EnvTags,AdZoneTags),
    io:format("response: ~p~n", [Scripts] );
each_pv(Pid, ACookie, EnvTags, AdZoneTags) -> 
    Pid ! campaign(ACookie,EnvTags,AdZoneTags).

campaign(ACookie,EnvTags,AdZoneTags) ->
    X = lists:member("Sport",EnvTags) or lists:member("Sport",AdZoneTags),
    if
        X ->
            {script,string:concat("Sport:",ACookie)};
        true -> 
            {script,disp({ACookie,EnvTags,AdZoneTags})}
    end.

disp({ACookie,_EnvTags,_AdZoneTags}) ->
    string:concat("exchange script for:",ACookie).

