Extension { #name : #Z3Sort }

{ #category : #'*Refinements' }
Z3Sort >> asRefinement [
	^self | [ :nu | Bool true ]
]

{ #category : #'*Refinements' }
Z3Sort >> falseRefinement [
	^self | [ :x | Bool false ]
]

{ #category : #'*Refinements' }
Z3Sort >> trueRefinement [
	^self | [ :x | Bool true ]
]

{ #category : #'*Refinements' }
Z3Sort >> trueSortedReft [
	^SortedReft basicNew 
		sr_sort: self;
		sr_reft: (Reft symbol: 'VV' expr: (DecidableRefinement text: 'Bool true'));
		yourself
]

{ #category : #'*Refinements' }
Z3Sort >> | aPredicate [
	^ShallowRefinement base: self predicate: aPredicate
]
