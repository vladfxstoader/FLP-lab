fib(0,1).
fib(1,1).
fib(N, Res):- 
	N1 is N-1, 
	N2 is N-2, 
	fib(N1, Res1), 
	fib(N2, Res2), 	
	Res is Res1+Res2.

fib1(0,1).
fib1(1,1).
fib1(N, Res):- fib1(1,N,1,1,Res).

fib1(N,N,_,Res,Res). % cand am ajuns la al n-lea termen avem rezultatul
fib1(I,N,A,B,Res):-
	J is I+1, % daca nu am ajuns la al n-lea termen, facem suma celor doi anteriori si mergem mai departe
	C is A+B,
	fib1(J,N,B,C,Res).

% square / 2
% primeste dim unei matrice si un caracter

squareAux(N, N, N, Ch):-
	write(Ch),
	nl. 

squareAux(N, I, N, Ch) :-
	write(Ch),
	nl,
	I1 is I+1,
	squareAux(N, I1, 1, Ch).

squareAux(N, I, J, Ch) :-
	write(Ch),
	J1 is J+1,
	squareAux(N, I, J1, Ch).
	

square(N, Ch) :-
	squareAux(N, 1, 1, Ch).

element_of(H,[H|_]).
element_of(H,[_|T]):-element_of(H,T).

% flush la terminalul din prolog
cls :- write('\33\[2J').

concat_lists([],L,L).
concat_lists([Elem|L1], L2, [Elem|L3]) :- concat_lists(L1,L2,L3).

%all_a/1
%ret true daca toate elementele sunt a

all_a([a]).
all_a([a|T]) :- all_a(T).

%trans_a_b/2
%transforma o lista de a-uri intr-o lista de b-uri

trans_a_b([a],[b]).
trans_a_b([a|T1],[b|T2]) :- trans_a_b(T1,T2).

% scararMult / 3
% scalarMult(+Scalar, +ListaInput, -ListaOutput).
% inmultirea fiecarui element cu scalar

scalarMult(_,[],[]).
scalarMult(Scalar,[HI|TI],[HO|TO]) :-
	HO is Scalar * HI,
	scalarMult(Scalar, TI, TO).

% produsul scalar a 2 vectori
% dot/3
% dot(+List1, +List2, Res).
% dot([1,2,3],[4,5,6], Res).
% Res = 32
% produsul scalar = suma produsului pe componente

dot([],[],0).
dot([H1|T1],[H2|T2],Res):-
	dot(T1,T2,ResTail),
	Res is ResTail + H1*H2.

% maximul dintr-o lista
% max/2
%max(+List, -Max).
max([],0).
max([X],X).
max([H|T], Max):-
	max(T, TailMax),
	H>TailMax,
	Max = H.
max([H|T], Max):-
	max(T, TailMax),
	H =< TailMax,
	Max = TailMax.

% palindrome/1
% true sau false daca lista e palindrom sau nu

% reverse/2 - pentru o lista intoarce lista cu elementele inversate

palindrome(X) :- reverse(X,X). % inversatul listei e egala cu lista initiala (reverse e implementat deja in Prolog)

% reverse_of/2
% reverse_of(+List, -ListInversata)

reverse_of([], L, L).
reverse_of([H|T], ListTemp, ListRes) :-
	reverse_of(T, [H|ListTemp], ListRes).

reverse_of(L, LR) :-
	reverse_of(L, [], LR).
	

palindrome_of(X) :- reverse_of(X,X).

% remove_duplicates / 2
% pastreaza o singura aparitie a elementelor in lista
% remove_duplicates(+LI, -LO).
% member - ret true daca un element apartine unei liste (deja implementat in Prolog)

remove_duplicates([],[]).
remove_duplicates([H|T], Res) :-
	member(H,T),
	remove_duplicates(T,Res).
remove_duplicates([H|T], [H|TailRes]):-
	not(member(H,T)),
	remove_duplicates(T, TailRes).

% replace/4
%replace(+Lista, +Car1, +Car2, -ListaOutput).

replace([],_,_,[]).
replace([X1|T], X1, X2, [X2|TailRes]):-
	replace(T,X1,X2,TailRes).
replace([H|T], X1, X2, [H|T1]):-
	replace(T,X1,X2,T1).	