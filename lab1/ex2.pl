female(mary).
female(sandra).
female(juliet).
female(lisa).
male(peter).
male(paul).
male(dony).
male(bob).
male(harry).
parent(bob, lisa).
parent(bob, paul).
parent(bob, mary).
parent(juliet, lisa).
parent(juliet, paul).
parent(juliet, mary).
parent(peter, harry).
parent(lisa, harry).
parent(mary, dony).
parent(mary, sandra).
father_of(F,C):-parent(F,C), male(F).
mother_of(M,C):-parent(F,C), female(M).
grandfather_of(G,C):-father_of(G,P), parent(P,C).
grandmother_of(G,C):-mother_of(G,P), parent(P,C).
sister_of(S,P):-parent(X,S), parent(X,P), female(S), S\=P.
brother_of(B,P):-parent(X,B), parent(X,P), male(B), B\=P.
aunt_of(A,C):-sister_of(A,P), parent(P,C).
uncle_of(U,C):-brother_of(U,P), parent(P,C).