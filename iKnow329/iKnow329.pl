% ===========================================================
% Project: iKnow329
% Author:  Hanxiang Huang
% Date:    27 October 2014
% ===========================================================

% -----------------------------------------------------------
% Use module
% -----------------------------------------------------------

:- use_module(library('readutil')).


% -----------------------------------------------------------
% Dynamic predicates
% -----------------------------------------------------------

:- dynamic student/2, teacher/1, kterm/6.


% -----------------------------------------------------------
% Style checking
% -----------------------------------------------------------

:- style_check([-singleton, -discontiguous]).


% -----------------------------------------------------------
% start/0
% -----------------------------------------------------------

start :-
  consult('kterms.pl'),
  consult('users.pl'),
  welcome,
  login(ID, Mode),
  (
     Mode = student
     ->
     main_process_student(ID)
  ;
     Mode = teacher
     ->
     main_process_teacher(ID)
  ),
  export_user_knowledge_base('users.pl').


% -----------------------------------------------------------
welcome :-
	write('====================================================='), nl,
	write('Welcome to iKnow329 - an Intelligent Tutoring System.'), nl,
	write('====================================================='), nl, nl.

% -----------------------------------------------------------
% Login, by using Student ID: s1, s2, s3 or Teacher ID: t1.
% If student ID, then student mode, or else teacher mode.
% -----------------------------------------------------------
	
	login(ID,Mode) :-
		write('Enter your ID:'),nl,
		read(ID),
		(member(ID, [s1, s2, s3])
		->
		Mode = student
		;
		member(ID, [t1])
		->
		Mode = teacher
		).
	
% -----------------------------------------------------------
% Student Mode
% use findall to load the information stored in kterms.pl
% displayQuestions shows the question
% then display the total mark.
% -----------------------------------------------------------
	
	main_process_student(ID) :-
		nl, write('Choose one of the following difficulty levels: easy, medium, or hard.'),nl,
		read(Difficulty),
		nl, write('Choose one of the following topics: parsing, prolog, propositional_logic.'),nl,
		read(Topics),
		findall([A,B,C,D,E,F,G,H],kterm(number(A),topic(Topics),level(Difficulty),question(B,C,D),answer(E,F),hint(G,H)),List),
		displayQuestion(List),
		findall(X,mark(X),Mlist),
		add_mark(Mlist,StudRes),
		write("Congratulations: you got "),
		write(StudRes),
		write(" marks.").

% -----------------------------------------------------------
% If the question is wh type and incorrect...
% the program will ask for the hints, yes or no
% if yes, display hint and do the question again in displayQuestions
% else display next question
% -----------------------------------------------------------
		
	wh_question(HData, De, Hint_use) :-
		(Hint_use = true
		->
		nl, write('Hint: '), write(HData), nl,
		nl, write('Try to answer the following question again: '), assert(mark(De)), nl,
		;
		true
		).	
	
% -----------------------------------------------------------
% Load information and display questions
% Use read_line_to_codes to read user inputs into the stream
% then check the inputs by member
% -----------------------------------------------------------
	
	displayQuestion([]).
	displayQuestion(H) :-
		member([Number, Type, Question, Mark, Answer, Others, Hint, Deduction], H),
		nl, write(Number), write(': '), write(Question), nl,
		read_line_to_codes(user_input, Codes),
		atom_codes(UserAnswer, Codes),
		downcase_atom(UserAnswer, DownList),
		tokenize_atom(DownList, ATokenList),
		clean_tokenlist(ATokenList, CTokenList),
		(member(CTokenList, Others)
			->
			nl, write('Your answer is correct.'), assert(mark(Mark)), nl
			;
			nl, write('Your answer is incorrect.'), nl,
				(member(Type,[yn])
				->
				write('')
				;
				member(Type,[wh])
				->
				nl, write('Would you like a hint? yes/no'), nl,
				read(WantHint),
				(member(WantHint, [yes])
				->
				wh_question(Hint, Deduction, true),
				displayQuestion(H)
				;
				wh_question(Hint, 0, false)
				)

			)
		),
		[Head|Tail] = H,
		displayQuestion(Tail).

% -----------------------------------------------------------
% remove the punctuation mark, or any other stopwords of user inputs by filter
% this is from week 8 practical
% -----------------------------------------------------------
		
	clean_tokenlist(NTokenList, CleanTokenList) :-
		stopword_filter(NTokenList, CleanTokenList).

	stopword_filter([], []).

	stopword_filter([Token|Tokens], Result) :-
		stopwords(StopwordList),
		member(Token, StopwordList),
		stopword_filter(Tokens, Result).

	stopword_filter([Token|Tokens], Result) :-
		punctuation_marks(PMList),
		member(Token, PMList),
		stopword_filter(Tokens, Result).
		
	stopword_filter([Token|Tokens], [Token|Result]) :-
		stopword_filter(Tokens, Result).

% -----------------------------------------------------------
% a customised stopword filter list
% -----------------------------------------------------------
		
	stopwords([a,able,about,across,after,all,almost,also,am,among,an,and,any,are,as,at,be,because,been,
  but,by,can,cannot,could,dear,did,do,does,either,else,ever,every,for,from,get,got,had,has,have,he,her,
  hers,him,his,how,however,i,if,into,is,it,its,just,least,let,like,likely,may,me,might,most,must,my,
  neither,nor,not,of,off,often,on,one,only,or,other,our,own,rather,said,say,says,she,should,since,so,
  some,than,that,the,their,them,then,there,these,they,this,tis,to,too,twas,us,wants,was,we,were,what,when,
  where,which,while,who,whom,why,will,with,would,yet,you,your]).
  
% -----------------------------------------------------------
% a customised punctuation mark filter list
% -----------------------------------------------------------
  
	punctuation_marks(['.', '?', '!', ',', ':', ';', '(', ')', '\'', '"', '/', '<', '>', '-', '{', '}']).
	
	add_mark([H|T], Sum) :-
		add_mark(T, Sum2),
		Sum is Sum2 + H.
	addmark([],0).
	
% -----------------------------------------------------------
% I tried to use subset but fail to match the answers...
% -----------------------------------------------------------
	
	subset([H|T], List) :-
		member(H, List),
		subset(T, List).
	subset([ ],_).	
	
% -----------------------------------------------------------
% File export, it's still incorrect to output at the moment...
% -----------------------------------------------------------
	
	combine(L,A,[A|L]).
	writeRecursive(Stream,[H|T]):-
	writeq(Stream,H),
	write(Stream, '.'), nl(Stream),
	writeRecursive(Stream,T).
	writeRecursive(_,[]).
	
	export_user_knowledge_base(FileName):-
		findall([A,B student(A,B), StudList),
		combine(StudList, [Topics, Difficulty, Mark], Combined),
		write(Combined),
	
		open(FileName, write, Stream),
		writeq(Stream, student(ID,Combined)),
		write(Stream, '.'), nl(Stream),
		writeq(Stream, teacher(t1)),
		write(Stream, '.'), nl(Stream),
		close(Stream).

% -----------------------------------------------------------
% Teacher Mode
% use findall to load the information stored in kterms.pl
% print_list shows the student (s1, s2, or s3) results
% -----------------------------------------------------------
	
	main_process_teacher(ID) :-
		nl, write('Which one of the following students would you like to inspect: s1, s2, s3.'),nl,
		read(X), nl,
		write('Student: '), write(X), nl, nl,
		findall(Rec,student(X,Rec),Slist),
		[Result|Tail] = Slist,
		print_list(Result),
		write('Another student? yes/no '), nl,
		read(ANO),
		(member(ANO, [yes])
		->
		main_process_teacher(ID)
		;
		member(ANO, [no])
		->
		nl, write('Thanks for using iKnow329.')
		).
	
	print_list([]).
	print_list(H) :-
		member([Topic, Level, Marks], H),
		write('Topic: '), write(Topic), nl,
		write('Level: '), write(Level), nl,
		write('Marks: '), write(Marks), nl, nl,
		[Head|Tail] = H,
		print_list(Tail).
% -----------------------------------------------------------
