-module(server).
-export([start/1,start/2]).
-export([init/1,init/2]).
-export([request/2,send/2]).

% 启动一个模块，注册服务的名称为模块名称 %
start(Mod) -> spawn(server,init,[Mod]).
start(Mod,Env) -> spawn(server,init,[Mod,Env]).

%请求响应式接口，具体的实现实际上依靠Mod模块的 handle_request 方法%
request(Mod, Request) ->
    Mod ! { request, self(), Request },
    ok.
%消息发送接口，请求进程不处理后续事件%
send(Mod, Event) ->
    Mod ! { send, Event },
    ok.

% 初始化服务，注册名称，启动init方法 %
init(Mod) -> 
        register(Mod,self()),
        State = Mod:init(),
        loop(Mod,State).

% 初始化服务时接受一个参数 %
init(Mod, Env) -> 
        register(Mod,self()),
        State = Mod:init(Env),
        loop(Mod,State).

% 实际执行体 %
loop(Mod, State) ->
    receive
        { request,From,Request } ->
            {Res,State2} = Mod:handle_request(Request,State),
            From ! {Mod, Res},
            loop(Mod,State2);
        { send, Event } ->
            State2 = Mod:handle_event(Event,State),
            loop(Mod,State2)
    end.


