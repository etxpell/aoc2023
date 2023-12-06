-module(a).

-export([do/0]).


%% Time:        44     89     96     91
%% Distance:   277   1136   1890   1768

do() ->
%%    L = [{7, 9}, {15, 40}, {30, 200}],
%%    L = [{44, 277}, {89, 1136}, {96, 1890}, {91, 1768}],
%%    L = [{71530, 940200}],
    L = [{44899691, 277113618901768}],

    multiply([count_wins(X) || X <- L]).


multiply(L) ->
    lists:foldl(fun(N, Acc) -> N*Acc end, 1, L).


count_wins({RaceTime, TopDist}) ->
    WinFun = fun(T) -> is_win(T, RaceTime, TopDist) end,
    LossesFromBelow = count_losses(1, +1, WinFun),
    LossesFromTop = count_losses(RaceTime, -1, WinFun),
    RaceTime - LossesFromTop - LossesFromBelow.

count_losses(T, Additive, F) ->
    count_losses(T, Additive, F, 0).
count_losses(T, Additive, F, C) ->
    case F(T) of
        true -> C;
        false -> count_losses(T+Additive, Additive, F, C+1)
    end.

is_win(HoldTime, RaceTime, TopDist) ->
    HoldTime*(RaceTime - HoldTime) > TopDist.
