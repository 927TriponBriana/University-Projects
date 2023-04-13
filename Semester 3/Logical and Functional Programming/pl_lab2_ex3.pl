% 3.
%a. Merge two storted lists with removing the double values.

% my_merge(l1...ln, s1...sm)=
%				[], if n=0 and m=0
%				l1...ln, if m=0
%				s1...sm, if n=0
%				l1 + my_merge(l2...ln, s1...sm) if l1<s1
%				s1 + my_merge(l1...ln, s2...sm) if l1>s1
%				my_merge(l1...ln, s2...sm) if l1=s1

%  my_merge(L:list, S:list, R:list)
%  (i,i,o)
my_merge([], [], []).
my_merge(L, [], L).
my_merge([], S, S).
my_merge([HL|TL], [HS|TS], [HL|R]) :-
    HL < HS,
    my_merge(TL, [HS|TS], R).
my_merge([HL|TL], [HS|TS], [HS|R]) :-
    HL > HS,
    my_merge([HL|TL], TS, R).
my_merge([HL|TL], [HS|TS], R) :-
    HL =:= HS,
    my_merge([HL|TL], TS, R).


%b. For a heterogeneous list, formed from integer numbers and list of numbers,
% merge all sublists with removing the double values.
%  [1, [2, 3], 4, 5, [1, 4, 6], 3, [1, 3, 7, 9, 10], 5, [1, 1, 11], 8] =>
%  [1, 2, 3, 4, 6, 7, 9, 10, 11]

% sublists(l1...ln) = 
%			[], if n=0
%			my_merge(l1, sublists(l2...ln)), if is_list(l1)=True
%			sublists(l2...ln), otherwise

%  sublists(L:list, R:list)
%  (i,o)

sublists([], []).
sublists([H|T], R):-
    is_list(H),
    !,
    sublists(T, R1),
    my_merge(H, R1, R).
sublists([_|T], R):-
    sublists(T, R).