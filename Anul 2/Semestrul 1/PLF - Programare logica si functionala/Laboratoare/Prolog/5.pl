% Sa se genereze lista submultimilor cu N elemente, cu elementele unei liste date.
% Ex.: [2, 3, 4] N=2 => [[2, 3], [2, 4], [3, 4]]

/*
subset(L: Lista, N: Intreg, Rez: Lista)
model de flux: (i, i, o)
subset(l1 ... ln, N) = 1. Ø                              , daca n = 0
                       2. l1 (+) subset(l2 ... ln, N - 1), daca n >= 1, cauta o solutie unde l1 este primul element din lista solutie
                       3. subset(l2 ... ln, N)           , daca n >= 1, cauta solutii alternative
*/
subset(_, 0, []).
subset([H|T], N, [H|Rez]) :- N > 0, N1 is N - 1, subset(T, N1, Rez).
subset([_|T], N, Rez) :- N > 0, subset(T, N, Rez).

/*
main(L: Lista, N: Intreg, Subseturi: Lista de submultimi)    //colecteaza toate solutiile intr-o lista
model de flux: (i, i, o), (i, i, i)
main(l1 ... ln, N) = Ø                            , daca n = 0
                     U subset(l1 ... ln, N), daca n > 0
*/
main(_, 0, []).
main(Lista, N, Subseturi) :- N > 0, findall(Subset, subset(Lista, N, Subset), Subseturi).
