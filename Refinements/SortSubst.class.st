"
type SortSubst = M.HashMap Symbol Sort
Cf. Types/Sorts.hs
"
Class {
	#name : #SortSubst,
	#superclass : #Dictionary,
	#category : #Refinements
}

{ #category : #'instance creation' }
SortSubst class >> mkSortSubst: assocs [
"
mkSortSubst :: [(Symbol, Sort)] -> SortSubst
mkSortSubst = M.fromList
"
	^self newFromAssociations: assocs
]
