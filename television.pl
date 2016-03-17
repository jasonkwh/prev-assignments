solve(S) :- S=[[_,_,_],[_,_,_],[_,_,_],[_,_,_],[_,_,_],[_,_,_]],
member(p(_,daniel,not(sports_car)), S),
member(p(1,not(mary),barbie_doll), S),
member(p(_,mark,not(paper_moustache), S)),
left_of(p(_,mark,not(barbie_doll)),p(_,_,fruit_basket), S),
left_of(p(_,_,paper_moustache),p(_,carl,_), S),
right_of(p(_,ron,laptop),p(_,_,europe_holiday_package), S).

right_of(X, Y, Lists) :- right_of(Y, X, Lists).
left_of(X, Y, Lists) :- right_of(X, Y, Lists).

left_of(X, Y, [X, Y|_]).
left_of(X, Y, [_|T]) :- left_of(X, Y, T).