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
Z3Sort >> isMono [
	self class = Z3IntSort ifFalse: [ self shouldBeImplemented ]. "in Refinements we haven't considered anything other than Z yet"
	^true
]

{ #category : #'*Refinements' }
Z3Sort >> trueRefinement [
	^self | [ :x | Bool true ]
]

{ #category : #'*Refinements' }
Z3Sort >> trueSortedReft [
	^SortedReft 
		sort: self
		reft: (Reft expr: (DecidableRefinement text: 'Bool true'))
]

{ #category : #'*Refinements' }
Z3Sort >> | aPredicate [
	^ShallowRefinement base: self predicate: aPredicate
]
