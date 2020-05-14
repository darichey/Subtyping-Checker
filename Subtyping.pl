% extends(C, P) is true if C is a direct subtype of P.
% That is, it would be declared as "C extends P"

extends(b, a).
extends(c, a).
extends(d, c).

% All types are subtypes of "any".
subtype(_, any).

% "nothing" is a subtype of every type.
subtype(nothing, _).

% A is trivially a subtype of B if A directly extends B.
subtype(A, B) :- extends(A, B).

% Subtyping is reflexive. Every type is a subtype of itself.
subtype(A, A).

% Subtyping is transitive. If A <: B and B <: C, then A <: C
subtype(A, C) :-
    extends(A, B),
    subtype(B, C).

% A is a subtype of a union of types if A is a subtype of any of the types in the union.
subtype(A, union(B, C)) :-
    subtype(A, B) ;
    subtype(A, C).

% A union of types is a subtype of a single type A if every member of the union is a subtype of A.
subtype(union(B, C), A) :-
    subtype(B, A),
    subtype(C, A).

% An intersection of types is a subtype of a single type A if any member of the intersection is a subtype of A.
subtype(intersection(B, C), A) :-
    subtype(B, A) ;
    subtype(C, A).

% A is a subtype of an intersection of types if A is a subtype of every member of the intersection.
subtype(A, intersection(B, C)) :-
    subtype(A, B),
    subtype(A, C).
