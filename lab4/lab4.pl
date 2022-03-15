% Laborator 4

% -------------------------------------
% 2 probleme -> zebra puzzle, countdown

% -----------------------------------------------------------------------------------------------------------------------
% zebra puzzle: o strada cu 5 case, numerotate in ordine de la 1 la 5
% Strada = [casa 1, casa 2, casa 3, casa 4, casa 5]
% pt. fiecare casa, avem urmatoarele caracteristici:
% 	numarul casei
% 	nationalitatea celui care locuieste in casa
% 	culoarea casei
% 	animalul de companie
% 	bautura preferata
% 	ce tigari fumeaza
% avem o serie de constrangeri
% cerinta = sa determinam cine este posesorul zebrei.

% casa(Numar, Nationalitate, Culoare, Animal, Bautura, Tigari).

la_dreapta(X, Y) :-
	X is Y+1.

la_stanga(X, Y) :- la_dreapta(Y, X).

langa(X, Y) :- la_stanga(X, Y) ; la_dreapta(X, Y).

solutie(PosesorZebra, Strada) :-
	Strada = [
		casa(1, _, _, _, _, _),
		casa(2, _, _, _, _, _),
		casa(3, _, _, _, _, _),
		casa(4, _, _, _, _, _),
		casa(5, _, _, _, _, _)
	],
	member(casa(_, englez, rosie, _, _, _), Strada), % sa apartina strazii
	member(casa(_, spaniol, _, caine, _, _), Strada),
	member(casa(A, _, verde, _, _, _), Strada),
	member(casa(B, _, bej, _, _, _), Strada),
	la_dreapta(A, B),
	member(casa(_, _, verde, _, cafea, _), Strada),
	member(casa(_, ucrainian, _, _, ceai, _), Strada),
	member(casa(_, _, _, melci, _, 'Old Gold'), Strada),
	member(casa(_, _, galbena, _, _, 'Kools'), Strada),
	member(casa(3, _, _, _, lapte, _), Strada),
	member(casa(1, norvegian, _, _, _, _), Strada),
	member(casa(C, _, _, _, _, 'Chesterfields'), Strada),
	member(casa(D, _, _, vulpe, _, _), Strada),
	langa(C, D),
	member(casa(G, _, _, cal, _, _), Strada),
	member(casa(H, _, _, _, _, 'Kools'), Strada),
	langa(G, H),
	member(casa(_, _, _, _, 'suc de portocale', 'Lucky Strike'), Strada),
	member(casa(_, japonez, _, _, _, 'Parliaments'), Strada),
	member(casa(E, norvegian, _, _, _, _), Strada),
	member(casa(F, _, albastra, _, _, _), Strada),
	langa(E, F),
	member(casa(_, PosesorZebra, _, zebra, _, _), Strada).	

% -------------------------------------------------------------------------------------------------------------------
% countdown
% fiind data o lista de litere, sa se gaseasca cel mai lung cuvant (din lb. engleza) care se poate forma
% folosind literele primite. nu este necesar sa se utilizeze toate literele. literele primite nu sunt
% neaparat distincte.

% baza de cunostinte contine word/1 - word(hello).

% pt. a include un fisier prolog intr-un alt fisier prolog, vom scrie:

:- include('words.pl').

% predicate prolog utile pt. acest exercitiu:
% atom_chars/2, atom_chars(+Word, -Letters). primeste un cuvant si returneaza lista literelor acelui cuvant
% select/3, select(+Elem, +List, -List). primeste un element, o lista si returneaza lista din care s-a eliminat
% 	prima aparitie a lui Elem.
% select(8, [1, 3, 8, 5, 8, 9], LR) => LR = [1, 3, 5, 8, 9].

% o prima solutie ar fi sa generam toate permutarile posibile de litere, si sa verificam daca macar o varianta
% 	este un cuvant valid in limba engleza.
% dar putem forma cuvinte cu mai putine litere decat cele primite.
% nr. operatii = SUM(Aranjamente de N luate cate I) > 2**n

% am nevoie de o solutie eficienta.

% cover/2 - verifica daca lista de litere de pe primul argument acopera lista de litere din al doilea argument.
% i.e. verific daca toate literele din prima lista apar si in a doua.
% nu trebuie sa am acoperire completa pe a doua lista!

cover([], _).
cover([H | T], L) :-
	select(H, L, R),
	cover(T, R).

solution(ListLetters, Word, Score) :- % Score = lungimea cuvantului
	word(Word),
	atom_chars(Word, Letters),
	length(Letters, Score),
	cover(Letters, ListLetters).

search_solution(_, 'no solution', 0).
search_solution(ListLetters, Word, Score) :-
	solution(ListLetters, Word, Score).
search_solution(ListLetters, Word, Score) :-
	NewScore is Score - 1,
	search_solution(ListLetters, Word, NewScore).

topsolution(ListLetters, Word) :-
	length(ListLetters, Score),
	search_solution(ListLetters, Word, Score).



