Extension { #name : #Z3Sort }

{ #category : #'*Refinements' }
Z3Sort >> apply: θ [ 
	"Applying a Type Substitution
	apply :: TVSubst -> Sort -> Sort"
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> asRefinement [
	^self | [ :nu | Bool true ]
]

{ #category : #'*Refinements' }
Z3Sort >> falseRefinement [
	^self | [ :x | Bool false ]
]

{ #category : #'*Refinements' }
Z3Sort >> isMono [
	self subclassResponsibility
]

{ #category : #'*Refinements' }
Z3Sort >> trueRefinement [
	^self | [ :x | Bool true ]
]

{ #category : #'*Refinements' }
Z3Sort >> trueSortedReft [
	^SortedReft 
		sort: self
		reft: (Reft expr: (DecidableRefinement always))
]

{ #category : #'*Refinements' }
Z3Sort >> | aPredicate [
	^ShallowRefinement base: self predicate: aPredicate
]
