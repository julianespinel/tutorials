-module(hello_world).
-export([hello/0, ping/0]).

%% Steps to run this file:
%%
%% 1. In a terminal, go to the directory containing this file.
%% 2. Start the Erlang shell: `erl`
%% 3. Compile the module: `c(hello_world).` %% Do not forget the stop.
%% 4. Call the hello function: `hello_world:hello().`
%% 5. Call the ping function: `hello_world:ping().`
%%
%% Here is an exaple of the inputs and outputs of the Erlang shell:
%%
%% 1> c(hello_world).
%% {ok,hello_world}
%% 2> hello_world:hello().
%% hello world
%% ok
%% 3> hello_world:ping().
%% pong
%% ok

hello() ->
    io:format("hello world~n").

ping() ->
    io:format("pong~n").
