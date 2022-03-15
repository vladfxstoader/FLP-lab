% Laboratorul 3 FLP

% Lab1: sintaxa limbajului Prolog.

% Lab2: recursivitate, liste in Prolog.
% concat_lists/3, reverse/3.

% Lab3: cum raspunde Prolog intrebarilor?

% ALGORITMUL DE UNIFICARE.

% Substitutia este o functie partiala de la multimea variabilelor in multimea termenilor.
% sigma : Var -> Trm(L) (termenii unui limbaj).

% Spunem ca 2 termeni t2 si t2 unifica daca exista o substitutie theta astfel incat
% theta(t1) = theta(t2).


% Algoritmul de unificare

% x variabila, t termen
% T[t/x] = t il substituie pe x in T

% Operatie in algoritm			Multimea solutiei				Lista de rezolvat (termenii pe care vreau sa ii unific)
%							  S						  			R
% ============================================================================================================================
%       Initial				   multimea vida				  t1=t1', t2=t2', ..., tn=tn' (egalitate ecuationala)
% ----------------------------------------------------------------------------------------------------------------------------
%	  SCOATE					  S								   R', t=t
%							  S								      R'
% ----------------------------------------------------------------------------------------------------------------------------
%	 DESCOMPUNE					  S					     R', f(t1, t2, ..., tn) = f(t1', t2', ..., tn')
%							  S							R', t1=t1', t2=t2', ..., tn=tn'
% ----------------------------------------------------------------------------------------------------------------------------
%	  REZOLVA					  S					      R', x=t sau t=x astfel incat x nu apare in t
%					          x=t, S[t/x]							   R'[t/x]
% ----------------------------------------------------------------------------------------------------------------------------
% 	   FINAL					  S                                             multimea vida
% ----------------------------------------------------------------------------------------------------------------------------
% S este unificatorul pentru termenii dati initial in multimea (lista) de rezolvat

% Algoritmul nu gaseste un unificator, respectiv aplica ESEC in urmatoarele situatii:

% daca incercam sa unificam simboluri de functii diferite, obtinem ESEC
% f(t1, t2, ..., tn) = g(t1', t2', ..., tk')
% constantele sunt simboluri de functii de aritate 0
% a constanta, f simbol de functie de aritate 1, f(x) = a ESEC

% daca avem o egalitate in lista de rezolvat de forma x = t sau t = x, dar x este variabila in t.

% Exercitii:
% simboluri de variabile: x, y, z, u, v.
% constante: a, b, c.
% functii de aritate 1: h, g, (_)^(-1) (inversarea unei functii).
% functii de aritate 2: f, +, *.
% functii de aritate 3: p.

% Ex. 1: Sa se gaseasca un unificator pentru termenii p(a, x, h(g(y))) si p(z, h(z), h(u)).

% Lista solutiei				Lista de rezolvat					Operatie
% multimea vida		    p(a, x, h(g(y))) = p(z, h(z), h(u))		     DESCOMPUNE
% multimea vida			a = z, x = h(z), h(g(y)) = h(u)		     DESCOMPUNE
% multimea vida			   a = z, x = h(z), g(y) = u				REZOLVA
%    z = a				      x = h(a), g(y) = u                        REZOLVA
% z = a, x = h(a) 	                 g(y) = u					REZOLVA
% z = a, x = h(a), u = g(y) 		   multimea vida					 FINAL

% Am gasit unificatorul { a/z, h(a)/x, g(y)/u }.


% Ex. 2: Sa se gaseasca un unificator pentru termenii f(h(a), g(x)) = f(y, y).

% Lista solutiei				Lista de rezolvat					Operatie
% multimea vida			    f(h(a), g(x)) = f(y, y)			     DESCOMPUNE
% multimea vida			     	h(a) = y, g(x) = y				REZOLVA
%   y = h(a)				   g(x) = h(a)					 ESEC

% Nu exista un unificator pentru cei doi termeni.


% Ex. 3: Sa se gaseasca un unificator pentru termenii p(a, x, g(x)) = p(a, y, y).

% Lista solutiei				Lista de rezolvat					Operatie
% multimea vida		          p(a, x, g(x)) = p(a, y, y)		     DESCOMPUNE
% multimea vida			    a = a, x = y, g(x) = y				SCOATE
% multimea vida				  x = y, g(x) = y					REZOLVA
%    x = y					   g(y) = y						 ESEC

% Nu exista un unificator pentru cei doi termeni.

% Ex. 4: Sa se gaseasca un unificator pentru termenii x + (y * y) = (y * y) + z.

% Lista solutiei				Lista de rezolvat					Operatie
% multimea vida		        x + (y * y) = (y * y) + z                    DESCOMPUNE
% multimea vida			    x = y * y, y * y = z	   			REZOLVA
%   x = y * y				    y * y = z					REZOLVA
% x = y * y, z = y * y			  multimea vida					 FINAL

% Am gasit unificatorul { y*y/x, y*y/z }.

TEMA: (x*y)*z = u*(u)^(-1)