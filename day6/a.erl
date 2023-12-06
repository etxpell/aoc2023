-module(a).

-export([do/0]).


%% Time:        44     89     96     91
%% Distance:   277   1136   1890   1768

do() ->
%%    L = [{7, 9}, {15, 40}, {30, 200}],
%%    L = [{44, 277}, {89, 1136}, {96, 1890}, {91, 1768}],
    L = [{71530, 940200}],
    multiply([count_wins(X) || X <- L]).


multiply(L) ->
    lists:foldl(fun(N, Acc) -> N*Acc end, 1, L).


count_wins({RaceTime, TopDist}) ->
    CountFun = fun(T, C) ->
                       case is_win(T, RaceTime, TopDist) of
                           true -> C + 1;
                           _ -> C
                       end end,
    lists:foldl(CountFun, 0, lists:seq(1, RaceTime)).

is_win(HoldTime, RaceTime, TopDist) ->
    HoldTime*(RaceTime - HoldTime) > TopDist.
