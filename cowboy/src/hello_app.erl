-module(hello_app).
-behaviour(application).

-export([start/2]).
-export([stop/1]).

% remove some superflous headers
custom_onresponse(StatusCode, Headers, Body, Req)-> 
	Headers2 = lists:filter(
		fun ({<<"server">>, _}) -> false ;
				({<<"date">>, _}) -> false ;
				(_) -> true end, Headers),
	{ok, Req2} = cowboy_req:reply(StatusCode, Headers2, Body, Req),
	Req2.

start(_Type, _Args) ->
	Dispatch = cowboy_router:compile([
		{'_', [{"/", hello_handler, []}]}
	]),
	cowboy:start_http(my_http_listener, 100,
		[{port, 8080}, {max_connections, infinity}],
		[{env, [{dispatch, Dispatch}]}, {onresponse, fun custom_onresponse/4}]
	),
	hello_sup:start_link().

stop(_State) ->
	ok.
