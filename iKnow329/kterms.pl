% -----------------------------------------------------------
% kterm/6
% -----------------------------------------------------------

kterm(number(1), 
      topic(prolog), 
      level(easy), 
      question(wh, 'What does PROLOG stand for?', 1), 
      answer('Programming in Logic', [[programming, in, logic], [logic, programming]]), 
      hint('Pro... in Log...', 0.5)).

kterm(number(2), 
      topic(prolog), 
      level(easy), 
      question(yn, 'Is PROLOG a procedural programming language?', 1), 
      answer('no', [[no], [nope], [nah]]), 
      hint(nil, nil)).

kterm(number(3), 
      topic(prolog), 
      level(easy), 
      question(yn, 'Does the following unification succeed: [a, b|[c]]=[X, Y, Z]?', 1), 
      answer('yes', [[yes], [yep], [sure]]),  
      hint(nil, nil)).

kterm(number(4), 
      topic(prolog), 
      level(easy), 
      question(wh, 'What is the most common data structure in PROLOG?', 1), 
      answer('lists', [[list], [lists]]), 
      hint('It has a head and a tail.', 0.5)).

kterm(number(5), 
      topic(prolog), 
      level(easy), 
      question(wh, 'Why does IBM Watson use PROLOG?', 1), 
      answer('Because Prolog is good at pattern matching', [[pattern, matching], ['pattern-matching']]), 
      hint('Regular expressions provide a similar functionality.', 0.5)).
	  
kterm(number(1), 
      topic(prolog), 
      level(medium), 
      question(wh, 'Prolog list contains?', 1), 
      answer('Head and Tail', [[head, tail]]), 
      hint('H.. and T..', 0.5)).
	  
kterm(number(2), 
      topic(prolog), 
      level(medium), 
      question(yn, 'simple clauses: likes(mary,food),likes(john,wine),likes(john,mary). Then, likes(john,food)?', 1), 
      answer('no', [[no], [nope], [nah]]), 
      hint(nil, nil)).
	  
kterm(number(3), 
      topic(prolog), 
      level(medium), 
      question(wh, 'Prolog is a first programming language for natural language processing. A example: if object X is closer to the observer than object Y, and Y is closer than Z, then X must be closer than Z. Prolog can reason the ____________ with respect to the general rule.', 1), 
      answer('Relationships or Consistency', [[relationships], [relationship], [consistency]]), 
      hint('R.... or C....', 0.5)).
	  
kterm(number(4), 
      topic(prolog), 
      level(medium), 
      question(yn, 'Is [Head|Tail] = Head true for finding the first element of the list?', 1), 
      answer('yes', [[true],[yes], [yep], [sure]]),  
      hint(nil, nil)).
	  
kterm(number(5), 
      topic(prolog), 
      level(medium), 
      question(yn, 'What about [Head|Tail] = Tail? Is it true for finding the last element?', 1), 
      answer('no', [[no], [nope], [nah]]), 
      hint(nil, nil)).
	  
kterm(number(1), 
      topic(prolog), 
      level(hard), 
      question(wh, 'Which predicate converts atom to list?', 1.5), 
      answer('atom_codes/2', [[atom_codes], [2]]), 
      hint('atom_.......', 1)).
	  
kterm(number(2), 
      topic(prolog), 
      level(hard), 
      question(wh, 'Which about list to atom?', 1.5), 
      answer('atomlist_concat/2', [[atomlist_concat], [2]]), 
      hint('atom_.......', 1)).
	  
kterm(number(3), 
      topic(prolog), 
      level(hard), 
      question(yn, 'When you write the codes to export outputs to a file, you can simply open and writeq.', 1), 
      answer('no', [[no], [nope], [nah]]), 
      hint(nil, nil)).
	  
kterm(number(4), 
      topic(prolog), 
      level(hard), 
      question(yn, 'When you write the codes to export outputs to a file, you can simply open and writeq.', 1), 
      answer('no', [[no], [nope], [nah]]), 
      hint(nil, nil)).
	  
kterm(number(5), 
      topic(prolog), 
      level(hard), 
      question(yn, 'Prolog single data type could be either atoms, numbers, variables or compound terms.', 3), 
      answer('yes', [[yes], [yep], [sure]]),  
      hint(nil, nil)).
	  

kterm(number(1), 
      topic(parsing), 
      level(easy), 
      question(yn, 'Parsing is important in computer science as the computer must parse object code to translate into the source code. [yes, no]', 1), 
      answer('no', [[no], [nope], [nah]]), 
      hint(nil, nil)).
 
kterm(number(2), 
      topic(parsing), 
      level(easy), 
      question(wh, 'Lexical analysis concentrates on dividing ______ into tokens.', 1), 
      answer('Strings', [['strings'], ['string']]), 
      hint('A common data type.', 0.5)).
	  
kterm(number(3), 
      topic(parsing), 
      level(easy), 
      question(wh, 'What is the constituency-based parse abbreviations (e.g., S for sentence) of a simple English sentence: Melissa ate the rabbit?', 1), 
      answer('Noun Verb Determiner Noun', [['N, V, D, N'], ['noun, verb, determiner, noun']]), 
      hint('Sample Answer: D N V N', 0.5)).
	  
kterm(number(4), 
      topic(parsing), 
      level(easy), 
      question(wh, 'She announced a program to promote safety in trucks and vans... What is the problem here?', 1), 
      answer('Ambiguity', [['ambiguity']]), 
      hint('many possible parse tree outputs', 0.5)).
	  
kterm(number(5), 
      topic(parsing), 
      level(easy), 
      question(wh, 'A list: [Telescopes, some, red, dog, man, Smith], which is the Determiner?', 1), 
      answer('some', [['some']]), 
      hint('the unique one', 0.5)).
	  
kterm(number(1), 
      topic(parsing), 
      level(medium), 
      question(wh, '2 types of parsers?', 1), 
      answer('Top down and Bottom up', [[top, down, bottom, up], [bottom, up, top, down]]), 
      hint('Up and Down', 0.5)).
	  
kterm(number(2), 
      topic(parsing), 
      level(medium), 
      question(wh, 'LL parser stands for?', 1), 
      answer('Left-to-right or Leftmost', [[left-to-right, leftmost], [leftmost,left-to-right]]), 
      hint('LEFT!', 0.5)).
	 
kterm(number(3), 
      topic(parsing), 
      level(medium), 
      question(yn, 'Bottom up parser comes from the concept of a parse tree.', 1), 
      answer('yes', [[yes], [yep], [sure]]),  
      hint(nil, nil)).
	  
kterm(number(4), 
      topic(parsing), 
      level(medium), 
      question(yn, 'Is that a centralised parser type really exist?', 1), 
      answer('no', [[no], [nope], [nah]]), 
      hint(nil, nil)).

kterm(number(5), 
      topic(parsing), 
      level(medium), 
      question(yn, 'To start parsing words, it is necessary to initialize the node count as 1 and empty list.', 1), 
      answer('yes', [[yes], [yep], [sure]]),  
      hint(nil, nil)).
	  
kterm(number(1), 
      topic(parsing), 
      level(hard), 
      question(wh, 'What is the empty parser stack?', 1), 
      answer('clear_parser', [[clear_parser], [clear, parser]]), 
      hint('c.....', 0.5)).
	  
kterm(number(2), 
      topic(parsing), 
      level(hard), 
      question(yn, 'It is unit to unit.', 1), 
      answer('yes', [[yes], [yep], [sure]]),  
      hint(nil, nil)).
	  
kterm(number(3), 
      topic(parsing), 
      level(hard), 
      question(yn, 'What about symbol_start?', 1), 
      answer('no', [[no], [nope], [nah]]), 
      hint(nil, nil)).
	  
kterm(number(4), 
      topic(parsing), 
      level(hard), 
      question(yn, 'Setup_trace controls debugging support, for the ocamlyacc-generated parser.', 1), 
      answer('no', [[no], [nope], [nah]]), 
      hint(nil, nil)).
	  
kterm(number(5), 
      topic(parsing), 
      level(hard), 
      question(yn, 'What predicate use to print out the nodes?', 1), 
      answer('write_list', [[write_list], [write_dep]]), 
      hint(nil, nil)).
	  
kterm(number(1), 
      topic(propositional_logic), 
      level(easy), 
      question(yn, 'Propositional logic concerned with the study of propositions (T or F) and form by other propositions with the use of logical connectives.', 1), 
      answer('yes', [[yes], [yep], [sure]]),  
      hint(nil, nil)).
	  
kterm(number(2), 
      topic(propositional_logic), 
      level(easy), 
      question(yn, 'P is true, Q is false, p AND q is?', 1), 
      answer('false', [[false],[no], [nope], [nah]]),  
      hint(nil, nil)).
	  
kterm(number(3), 
      topic(propositional_logic), 
      level(easy), 
      question(wh, 'All TRUE for (P->Q) v (Q->P), in another way of saying, it is a______?', 1), 
      answer('Tautology', [['tautology']]), 
      hint('Starts at T....', 0.5)).
	  
kterm(number(4), 
      topic(propositional_logic), 
      level(easy), 
      question(wh, 'What is the opposite of Q3 answer?', 1), 
      answer('Contradiction', [['contradiction']]), 
      hint('ALL FALSE', 0.5)).
	  
kterm(number(5), 
      topic(propositional_logic), 
      level(easy), 
      question(yn, 'Is it true that P and (P or Q) equilvant to P by Absorbtion Rule?', 1), 
      answer('yes', [[yes], [yep], [sure]]), 
      hint(nil, nil)).
	  
kterm(number(1), 
      topic(propositional_logic), 
      level(medium), 
      question(yn, 'Every x Some y F(x,y) = Every C251 student is a friend of at least one C251 student.', 1), 
      answer('false', [[false],[no], [nope], [nah]]),  
      hint(nil, nil)).
	  
kterm(number(2), 
      topic(propositional_logic), 
      level(medium), 
      question(yn, 'Rules of Inference, is a sequence of True statements that end in a valid conclusion.', 1), 
      answer('yes', [[yes], [yep], [sure]]), 
      hint(nil, nil)).
	  
kterm(number(3), 
      topic(propositional_logic), 
      level(medium), 
      question(yn, 'Some x Some y Some z P(x,y,z)(y=x+1 and z=y+1 and square(x) + square(y) = square(z)), if x=3, then P(x,y,z) is?', 1), 
      answer('25', [[25]]), 
      hint(nil, nil)).
	  
kterm(number(4), 
      topic(propositional_logic), 
      level(medium), 
      question(yn, 'Conjunctive normal form formula has a conjunction of clauses, where a clause is a disjunction of literals.', 1), 
      answer('yes', [[yes], [yep], [sure]]), 
      hint(nil, nil)).
	
kterm(number(5), 
      topic(propositional_logic), 
      level(medium), 
      question(yn, 'By which rule, P and (Q or R) is equilvant to P and Q or P and R?', 1), 
      answer('Distributive', [[distributive]]),  
	  hint(nil, nil)).
	
kterm(number(1), 
      topic(propositional_logic), 
      level(hard), 
      question(wh, 'what is 2 propositions that identical truth values for all possible values of their logical variables?', 1), 
      answer('Logical Equivalence', [[logical, equivalence]]), 
      hint('L...', 0.5)).
	  
kterm(number(2), 
      topic(propositional_logic), 
      level(hard), 
      question(yn, 'a function: A = not(p -> not(q or r)), the CNF is?', 1), 
      answer('p and (q or r)', [[p], [and], [q], [or], [r]]), 
      hint(nil, nil)).
	  
kterm(number(3), 
      topic(propositional_logic), 
      level(hard), 
      question(yn, 'A Disjunctive Normal Form (DNF) is a standardization (or normalization) of a logical formula which is a disjunction of literals', 1), 
      answer('false', [[false],[no], [nope], [nah]]),  
      hint(nil, nil)).
	  
kterm(number(4), 
      topic(propositional_logic), 
      level(hard), 
      question(yn, 'a function: A = not(p -> not(q or r)), the DNF is?', 1), 
      answer('(p and q) or (p and r)', [[p], [and], [q], [or], [p], [and], [r]]), 
      hint(nil, nil)).
	  
kterm(number(5), 
      topic(propositional_logic), 
      level(hard), 
      question(yn, 'All x (All y Animal(y) -> Loves(x,y)) -> (Some y Love (y,x)), the CNF is (Animal(f(x)) And Loves(g(x),x)) And (not(Loves(x,f(x))) or Loves（g(x),x))?', 1), 
      answer('false', [[false],[no], [nope], [nah]]),  
      hint(nil, nil)).