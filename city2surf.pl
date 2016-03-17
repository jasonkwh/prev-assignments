friends(S) :- S=[_,_,_],
member(p(bob,_,_,_), S),
member(p(_,sport_teacher,_,1), S),
member(p(_,_,sydney,_), S),
faster_than(p(mark,doctor,_,_), p(_,_,melbourne,_), S),
faster_than(p(daren,_,perth,_), p(_,police_officer,_,_), S),
faster_than(p(_,_,_,2), p(_,_,_,3), S).

left_of(X, Y, [X, Y|_]).
left_of(X, Y, [_|T]) :- left_of(X, Y, T).

faster_than(X, Y, Lists) :- left_of(X, Y, Lists).
faster_than(X, Y, Lists) :- left_of(Y, X, Lists).