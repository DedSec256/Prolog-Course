/* 
 * Max and Alex
 * All rights reserved.
 */

append([], Y, [Y]). 
append([H|T], Y, [H|Z]) :- append(T, Y, Z).

appendRange([H|T], [], [H|T]).
appendRange([], [H|T], [H|T]).
appendRange([H|T], X, [H|Z]) :- appendRange(T, X, Z). 

contains(X,[X|_]). 
contains(X,[_|T]) :- contains(X,T). 

subContains([], _). 
subContains([Hx|Tx], [Hx|T]) :- subContains(Tx, T). 
subContains(X, [_|T])        :- subContains(X, T).

insert(L, 0, X, [X|L]). 
insert([Hl|Tl], I, X, [Hl|R]) :- I1 is I - 1, 
				 insert(Tl, I1, X, R).

reverse([], []).
reverse([H|T], Z) :- reverse(T, Y),
    		     append(Y, H, Z).

remove([], _, []).
remove([_|T], 0, T).
remove([H|T], I, Z) :-  I1 is I-1,
    			remove(T, I1, Y),
			appendRange([H], Y, Z).

get([], _, false). 
get([H|_], 0, H).
get([_|T], I, Z) :-  I1 is I-1,
    		     get(T, I1, Z).

truncate(_, 0, -1, []). 
truncate([H|T], 0, E, [H|R]) :- E1 is E - 1, 
				truncate(T, 0, E1, R). 
truncate([_|T], S, E, R) :- S1 is S - 1, 
		            E1 is E - 1, 
			    truncate(T, S1, E1, R).
 
isEmpty([]).

/* Sort */

internalOrderInsert([], X, Acc, Z) :- appendRange(Acc, [X] , Z).
internalOrderInsert([H|T], X, Acc, Z) :- X > H,
    					appendRange(Acc, [H], Acc1),
    					internalOrderInsert(T, X, Acc1, Z).
internalOrderInsert([H|T], X, Acc, Z) :- X =< H,
    					appendRange(Acc, [X|[H|T]], Z).
  
orderInsert([H|T], X, Z) :- internalOrderInsert([H|T], X, [], Z).
    					   
innerSort([], Acc, Acc).
innerSort([H|T], Acc, Z) :- orderInsert(Acc, H, Acc1),
    			    innerSort(T, Acc1, Z).

mySort([], []).
mySort([H|T], Z) :- innerSort(T, [H], Z).
