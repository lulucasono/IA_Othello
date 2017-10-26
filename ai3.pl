:-module('ai3',[chooseMove3/4]).
:-use_module([library(apply),io,fill,utils,ai_utils]).


fillAndFlipTemp(Board,AI,[X,Y],NewBoard):-
    fillAndFlip(X,Y,AI,Board,NewBoard).

chooseMove3(AI,X,Y,Board):-
    findall([X,Y],getLegalMove(AI,X,Y,Board),MoveList),
    maplist(fillAndFlipTemp(Board,AI),MoveList,BoardList),
    maplist(ai_utils:eval(AI),BoardList,EvalList),
    listMax(EvalList,Max),
    getLegalMove(AI,X,Y,Board),
    fillAndFlip(X,Y,AI,Board,NewBoard),
    ai_utils:eval(AI,NewBoard,Max),
    utils:retransformeX(N,X),
    utils:retransformeY(Al,Y),
    reportMove(AI,N,Al),
    !.
