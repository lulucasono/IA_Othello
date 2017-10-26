:-module('end',[countPiece/3,winner/2,noMoreLegalSquares/1,noMoreLegalSquares/2,checkWinner/2]).
:- use_module([library(lists),io]).

%Retourne true si une colonne est pleine

isRowFull(_,8,_).

isRowFull(Board,X,Y):-
    utils:getVal(Board,X,Y,V),
    V \== 0,
    XX is X+1,
    isRowFull(Board,XX,Y).

isRowOnlyPiece(_,_,8,_,_).

isRowOnlyPiece(Player,Board,0,Y,NN) :-
    utils:getVal(Board,0,Y,V),
    %writeln(V),
    (   (V=:=0,V=:=Player) -> NN is 0;
        NN is 1).

isRowOnlyPiece(Player,Board,X,Y,N):-
    utils:getVal(Board,X,Y,V),
    %writeln(V),
    (   (V=:=0,V=:=Player) -> NN is N;
    NN is N+1),
    XX is X+1,
    isRowOnlyPiece(Player,Board,XX,Y,NN).


%Retourne true si une ligne est pleine

isLineFull(_,_,8).

isLineFull(Board,X,Y):-
    utils:getVal(Board,X,Y,V),
    %writeln(V),
    V \== 0,
    YY is Y+1,
    isLineFull(Board,X,YY).

isLineOnlyPiece(_,_,_,8,_).

isLineOnlyPiece(Player,Board,X,0,NN) :-
    utils:getVal(Board,X,0,V),
    %writeln(V),
    (   (V=:=0,V=:=Player) -> NN = 0,
        NN = 1).

isLineOnlyPiece(Player,Board,X,Y,N):-
    utils:getVal(Board,X,Y,V),
    %writeln(V),
    (   (V=:=0,V=:=Player) -> NN is N;
    NN is N+1),
    YY is Y+1,
    isLineOnlyPiece(Player,Board,X,YY,NN).

% Retourne true si il n'y a plus de coup possibles pour tous les 2
% joueur
noMoreLegalSquares(Board):-
    noMoreLegalSquares(Board,1),
    noMoreLegalSquares(Board,-1).

%Retourne true si il n'y a plus de coup possibles pour Player
noMoreLegalSquares(Board,Player):-
    not(io:getLegalMove(Player,_,_,Board)).

%Compte le nombre d'lments du tableau gaux  la variable X
count([],_,0).
count([X|T],X,Y):- count(T,X,Z), Y is 1+Z.
count([X1|T],X,Z):- X1\=X,count(T,X,Z).

%Compte les pices noires et blanches du board
countPiece(Board,NBlack,NWhite):-
    countBlack(Board,NBlack),
    countWhite(Board,NWhite).

%Compte les pices noires
countBlack(Board,N):-
    nth0(0,Board,Line1),countBlackLine(Line1,N1),
    nth0(1,Board,Line2),countBlackLine(Line2,N2),
    nth0(2,Board,Line3),countBlackLine(Line3,N3),
    nth0(3,Board,Line4),countBlackLine(Line4,N4),
    nth0(4,Board,Line5),countBlackLine(Line5,N5),
    nth0(5,Board,Line6),countBlackLine(Line6,N6),
    nth0(6,Board,Line7),countBlackLine(Line7,N7),
    nth0(7,Board,Line8),countBlackLine(Line8,N8),
    N is (N1+N2+N3+N4+N5+N6+N7+N8).



countBlackLine(List,C) :-
    count(List,-1,C).

%Compte les pices blanches
countWhite(Board,N):-
    nth0(0,Board,Line1),countWhiteLine(Line1,N1),
    nth0(1,Board,Line2),countWhiteLine(Line2,N2),
    nth0(2,Board,Line3),countWhiteLine(Line3,N3),
    nth0(3,Board,Line4),countWhiteLine(Line4,N4),
    nth0(4,Board,Line5),countWhiteLine(Line5,N5),
    nth0(5,Board,Line6),countWhiteLine(Line6,N6),
    nth0(6,Board,Line7),countWhiteLine(Line7,N7),
    nth0(7,Board,Line8),countWhiteLine(Line8,N8),
    N is (N1+N2+N3+N4+N5+N6+N7+N8).

countWhiteLine(List,C) :-
    count(List,1,C).

%Retourne le vainqueur sans l'afficher dans la console, sert pour les ia
checkWinner(Board,Winner):-
	countPiece(Board,NBlack,NWhite),
    (NBlack < NWhite->Winner is 1;
    NBlack > NWhite->Winner is -1;
    NBlack =:= NWhite->Winner is 0).

%Retourne le vainqueur et affiche son nom dans la console
winner(Board,Player):-
    countPiece(Board,NBlack,NWhite),
    (NBlack < NWhite->Player is 1,io:reportWinner(Player);
    NBlack > NWhite->Player is -1,io:reportWinner(Player);
    NBlack =:= NWhite->Player is 0,io:reportWinner(Player)).

%Affiche le score de la partie
printScore(Board):-
    countPiece(Board,NBlack,NWhite),
    write('Score of White: '),
    writeln(NWhite),
    write('Score of Black:'),
    writeln(NBlack).
