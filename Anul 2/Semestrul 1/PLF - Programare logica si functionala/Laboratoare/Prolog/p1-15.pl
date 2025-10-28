% 15
% a. Sa se scrie un predicat care se va satisface daca o lista are numar
% par de elemente si va esua in caz contrar, fara sa se numere
% elementele listei.
% b. Sa se elimine prima aparitie a elementului minim dintr-o lista de
% numere intregi.

%a
%listaPar(L:lista)
%(i)- determinist
%L : lista pe care o vom verifica
listaPar([]):-!.
listaPar([_,_|T]):-
    listaPar(T).
%b
%gaseste(L:lista, E:int)
%(i,o) - determinist
%L: lista in care cautam elementul minim
%E: elementul minim, va fi rezultatul
gaseste([E],E).
gaseste([H|T], M):-
    gaseste(T,M),
    M=<H,
    !.
gaseste([H|_],H).

%del(L:lista, LR: lista)
%(i, o) - determinist
%L: lista in care eliminam prima aparitie a elementului minim
del([],[]).
%daca l1 este min il elim din lista si returnam restul listei
del([H|T], T) :-
    gaseste([H|T], M),
    H is M,
    !.
%daca l1 nu e min il pastram si continuam recursiv
del([H|T], [H|Rez]) :-
    del(T, Rez).










