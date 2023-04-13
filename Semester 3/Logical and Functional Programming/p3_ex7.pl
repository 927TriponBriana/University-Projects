%A player wants to choose the predictions for 4 games.
%The predictions can be 1, X, 2.
%Write a predicate to generate all possible variants considering that:
%last prediction can’t be 2 and no more than two possible predictions X.

candidat(1).
candidat(3).
candidat(2).

%all(n,c,p) = 
%		c, if n=4
%		all(n+1, candidat(x)+c, p*x), if p*x%27=0

%all(N:number, C:list, R:list, P:number)
%all(i, i, o, i)

all(4, R, R, _):-!.
all(I, C, R, P):-
    candidat(X),
    I1 is I+1,
    P1 is P*X,
    P1 mod 27 =\= 0,
    all(I1, [X|C], R, P1).

%rez(R:list)
%rez(o)

rez(R):-all(1, [1], R, 1).
rez(R):-all(1, [3], R, 1).

%all_sol(R:list)
%all_sol(o)

all_sol(R):-
    findall(RPartial, rez(RPartial), R).
  
