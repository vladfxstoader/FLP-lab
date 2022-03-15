% 1
num_aparitii([], _, 0).
num_aparitii([H | T], H, Res) :-
	num_aparitii(T, H, Res1),
	Res is Res1 + 1.
num_aparitii([ _ | T], G, Res) :- 
	num_aparitii(T, G, Res).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 2
% listacifre/2, listacifre(+Nr, -List).
% listacifre(2421, List). List = [2, 4, 2, 1].

listacifre_aux(X, [X]) :- X < 10.
listacifre_aux(X, [C | T]) :- 
	C is X mod 10,
	D is X div 10,
	listacifre_aux(D, T).
listacifre(Nr, List) :- 
	listacifre_aux(Nr, ListRev),
	reverse(ListRev, List).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 3 - lista permutarilor circulare

% permcirc/2
permcirc([], []).
permcirc([H | T], L) :- append(T, [H], L).	

% LInit		Perm			ListaPermutarilor
% [1,2,3]		[2,3,1]		[[2,3,1]]
%			[3,1,2]		[[2,3,1],[3,1,2]]
%			[1,2,3]		[[2,3,1],[3,1,2],[1,2,3]]

%lpermcirc/3
%lpermcirc(+LInit, +PermCurenta, -LP).
lpermcirc(L, L, [L]).
lpermcirc(L, M, [M | LP]) :-
	permcirc(M, N),
	lpermcirc(L, N, LP).

listpermcirc(L, LP) :-
	permcirc(L, M),
	lpermcirc(L, M, LP).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 4 - multimi
% elimina/3
% elimina(+List, +Elem, -ListFaraElem).

elimina([], _, []).
elimina([H | T], H, R) :-
	elimina(T, H, R).
elimina([H | T], Elem, [H | R]) :-
	elimina(T, Elem, R).

% multime/2
% multime(+List, -ListFaraDuplicate).

multime([], []).
multime([H | T], R) :-
	member(H, T),
	multime(T, R).
multime([H | T], [H | R]) :-
	not(member(H, T)),
	multime(T, R).


% emult/1
% emult(+List) true daca lista e multime

emult(L) :-
	length(L, N1),
	multime(L, LM),
	length(LM, N2),
	N1 =:= N2.

emult1([]).
emult1([H | T]) :-
	emult1(T),
	not(member(H, T)).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 5
% intersectie/3
% intersectie(+M1, +M2, -MR).

intersectie([], _, []).
intersectie([H | T], L, [H | R]) :-
	member(H, L),
	intersectie(T, L, R).
intersectie([H | T], L, R) :-
	not(member(H, L)),
	intersectie(T, L, R).

% diff/3
% diff(+M1, +M2, -MR).

diff([], _, []).
diff([H | T], L, [H | R]) :-
	not(member(H, L)),
	diff(T, L, R).
diff([H | T], L, R) :-
	member(H, L),
	diff(T, L, R).

% prod_cartezian
% prod_cartezian(+M1, +M2, -MR).

% produsul carteizan dintre un singleton si o lista
% [5] x [1, 2, 3] = (5, 1), (5, 2), (5, 3).
% X		[H | T] => la fiecare pas adaug la rezultat (X, H)

element_ori_multime(_, [], []).
element_ori_multime(X, [H | T], [(X, H) | R]) :-
	element_ori_multime(X, T, R).

prod_cartezian([], _, []).
prod_cartezian([H | T], L, R) :-
	element_ori_multime(H, L, R1),
	prod_cartezian(T, L, TailRes),
	append(R1, TailRes, R).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% 6 - arbori

% In Prolog vom reprezenta arborii binari prin
% nil = arborele vid
% arb(+Radacina, +SubarboreStang, +SubarboreDrept).
% arb(Frunza, nil, nil).
% arb(5, arb(4, nil, nil), arb(3, arb(2, nil, nil), arb(1, nil, arb(10, nil, nil)))).

% parcurgeri: SRD, RSD, SDR
% srd/2
srd(nil, []).
srd(arb(R, S, D), L) :- 
	srd(S, Ls),
	srd(D, Ld),
	append(Ls, [R], LTemp),
	append(LTemp, Ld, L).

% rsd
rsd(nil, []).
rsd(arb(R, S, D), L) :-
	rsd(S, Ls),
	rsd(D, Ld),
	append([R | Ls], Ld, L).

% sdr
sdr(nil, []).
sdr(arb(R, S, D), L) :-
	sdr(S, Ls),
	sdr(D, Ld),
	append(Ls, Ld, LTemp),
	append(LTemp, [R], L).

% frunze/2
% frunze(+Arb, -ListFrunze).

frunze(nil, []).
frunze(arb(X, nil, nil), [X]).
frunze(arb(_, S, D), L) :-
	frunze(S, Ls),
	frunze(D, Ld),
	append(Ls, Ld, L).
