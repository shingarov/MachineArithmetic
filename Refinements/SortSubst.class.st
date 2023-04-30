Class {
	#name : #SortSubst,
	#superclass : #Dictionary,
	#category : #Refinements
}

{ #category : #private }
SortSubst >> scanFor: anObject [
	"Dangerous.
	 Copied from Dictionary, but compare by #≃ and ignore hash
	 because PreSorts and Z3 sorts will never have the same hash.
	
	 This is needed because otherwise #sortSubst: could miss to
	 subst S with A if θ is {k!1->A}."
	| element |
	1 to: array size do:
		[:index | ((element := array at: index) == nil or: [element key ≃ anObject])
			ifTrue: [^ index ]].

	^ 0  "No match AND no empty slot"
]
