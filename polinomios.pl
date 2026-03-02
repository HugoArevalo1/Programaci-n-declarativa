es_polinomio(P) :- es_monomio(P).
es_polinomio(M+P) :- es_monomio(M), es_polinomio(P).
es_polinomio(M-P) :- es_monomio(M), es_polinomio(P).

es_monomio(C) :- integer(C).
es_monomio(X).
es_monomio(C*X) :- integer(C).
es_monomio(X*N) :- integer(N).
es_monomio(C*X*N) :- integer(C), integer(N).

eval(M+1,V,R) :- eval(M,V,R1), eval(P,V,R2), R is R1+R2.

eval(C*X, V, R) :- integer(C), R is C*V.