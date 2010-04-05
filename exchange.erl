-module(exchange).
-export([each_pv/4]).

each_pv(none, ACookie, EnvTags, AdZoneTags) -> 
    {script, Scripts} = campaign(ACookie,EnvTags,AdZoneTags),
    io:format("response: ~p~n", [binary_to_term(Scripts)] );
each_pv(Pid, ACookie, EnvTags, AdZoneTags) -> 
    Pid ! campaign(ACookie,EnvTags,AdZoneTags).

campaign(ACookie,EnvTags,AdZoneTags) ->
    Support = lists:member("Sport",EnvTags) or lists:member("Sport",AdZoneTags),
    if
        Support ->
            {script,string:concat("Sport:",ACookie)};
        true -> 
            {script,disp({ACookie,EnvTags,AdZoneTags})}
    end.

disp({ACookie,EnvTags,AdZoneTags}) ->
    string:concat("exchange script for:",ACookie).

