%%% HECHOS
padre(teraj,abraham).
padre(teraj,najor).
padre(teraj,haran).
padre(teraj,sara).
padre(abraham,isaac).
padre(abraham,ismael).
padre(haran,lot).
padre(haran,melca).
padre(haran,jesca).
padre(najor,batuel).
padre(batuel,rebeca).
padre(batuel,laban).
padre(isaac,esau).
padre(isaac,jacob).

madre(sara,isaac).
madre(agar,ismael).
madre(melca,batuel).
madre(rebeca,esau).
madre(rebeca,jacob).

hombre(teraj).
hombre(abraham).
hombre(najor).
hombre(haran).
hombre(isaac).
hombre(lot).
hombre(ismael).
hombre(batuel).          
hombre(laban).           
hombre(esau).            
hombre(jacob).

mujer(sara).
mujer(agar).
mujer(melca).
mujer(jesca).
mujer(rebeca).

casados(abraham,sara).
casados(sara,abraham).
casados(isaac,rebeca).
casados(rebeca,isaac).

%%% REGLAS
ascendiente_directo(X, Y) :- (padre(X, Y); madre(X, Y)).
ascendiente(X, Z) :- ascendiente_directo(X, Z).
ascendiente(X, Z) :- ascendiente_directo(X, Y), ascendiente(Y, Z).

descendiente_directo(X,Y) :- (padre(Y,X); madre(Y,X)).
descendiente(X,Y) :- descendiente_directo(X,Y).
descendiente(X,Y) :- descendiente_directo(X,Z), descendiente(Z,Y).

hijo(X,Y) :- hombre(X), ascendiente_directo(Y,X).
hija(X,Y) :- mujer(X), ascendiente_directo(Y,X).

abuelo(X,Y) :- padre(X,Z), ascendiente_directo(Z,Y).
abuela(X,Y) :- madre(X,Z), ascendiente_directo(Z,Y).

hermano(X,Y) :- hombre(X), ascendiente_directo(Z,X), ascendiente_directo(Z,Y), X \= Y.
hermana(X,Y) :- mujer(X), ascendiente_directo(Z,X), ascendiente_directo(Z,Y), X \= Y.

tio(X,Y) :- hombre(X), hermano(X,Z), ascendiente_directo(Z,Y).
tia(X,Y) :- mujer(X), hermana(X,Z), ascendiente_directo(Z,Y).

sobrino(X,Y) :- hombre(X), (tio(Y,X); tia(Y,X)).
sobrina(X,Y) :- mujer(X), (tio(Y,X); tia(Y,X)).

primo(X,Y) :- hombre(X), (tio(Z,X); tia(Z,X)), ascendiente_directo(Z,Y).
prima(X,Y) :- mujer(X), (tio(Z,X); tia(Z,X)), ascendiente_directo(Z,Y).

familia(X,Y) :- descendiente(X,Y); ascendiente(X,Y); prima(X,Y); primo(X,Y); tia(X,Y); tio(X,Y); sobrina(X,Y); sobrino(X,Y); hermana(X,Y); hermano(X,Y).

incesto(X,Y) :- familia(X,Y), ((ascendiente_directo(X,Z), ascendiente_directo(Y,Z)); (casados(X,Y))), X\=Y.