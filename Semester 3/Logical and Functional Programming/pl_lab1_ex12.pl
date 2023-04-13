% 12.
% a. Write a predicate to substitute in a list a value with all the elements of
% another list.

% insert(l1...ln, InitialList)=
%				InitialList if n=0
%				l1 + insert(l2...ln, InitialList) otherwise

% subtitute_elem(l1...ln, e, ResList)=
%				[] if n = 0
%				insert(ResList, substitute_elem(l2...ln, e, ResList)) if l1=e
%				l1 + substitute_elem(l2...ln, e, ResList) l1!=e

% insert(L:list, List:list, R:list)
% (i,i,i), (i,i,o)

% substitue_elem(L:list, Elem:number, ReplacementList:list, R:list)
% (i,i,i,o)

insert([], List, List).
insert([H|T], List, [H|R]) :- insert(T, List, R).

substitute_elem([],_,_,[]).
substitute_elem([H|T], Elem, RList, R) :- H =:= Elem,
    substitute_elem(T, Elem, RList, Temp),
    insert(RList, Temp, R).
substitute_elem([H|T], Elem, RList, [H|R]) :- H =\= Elem,
    substitute_elem(T, Elem, RList, R).


res([],_,_,[]).
res([H|T],E,L,R):-H=:=E,
    res(T,E,L,R1),
    R=[L|R1].
res([H|T],E,L,R):-H=\=E,
    res(T,E,L,R1),
    R=[H|R1].




% b. Remove the n-th element of a list.

% remove_kth_elem(l1...ln, k) = 
%				[] if n=0
%				l2...ln if k=1
%				l1 + remove_kth_elem(l2...ln, k-1) otherwise

% remove_kth_elem(L:list, K:number, R:list)
% (i,i,i), (i,i,o)

remove_kth_elem([], _, []).
remove_kth_elem([_|T], 1, T).
remove_kth_elem([H|T], K, [H|R]) :-
    K1 is K-1,
    remove_kth_elem(T, K1, R).

%remove_kth_elem([1,2,4,3], 3, R).