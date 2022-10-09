Extension { #name : #Z3Sort }

{ #category : #'*Refinements' }
Z3Sort class >> _go: x y: y [
	x isEmpty
		ifTrue: [
			| s ss |
			y size = 1 ifTrue: [ ^y first ].
			s := y first.  ss := y allButFirst.
			"too early for Z3 #functionFrom:to:, because elab"
			^FFunc from: s to: (self _go: #() y: ss)
		] ifFalse: [
			| i is |
			i := x first.  is := x allButFirst.
			^FAbs int: i sort: (self _go: is y: y)
		]
]

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
Z3Sort >> fApp: argSorts [
"
fApp :: Sort -> [Sort] -> Sort
fApp = foldl' FApp,  so in coordinates,
fApp s ss = foldl' FApp s ss
"
	^argSorts inject: self into: [ :x :y | FApp s: x t: y ]
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
Z3Sort class >> mkFFunc: i sorts: ss [
"mkFFunc :: Int -> [Sort] -> Sort"
	^self _go: (0 to: i-1) y: ss

]

{ #category : #'*Refinements' }
Z3Sort >> toProduct [
	^Product with: self
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
Z3Sort >> unify: t2 env: f fast: isFast [
"
Fast Unification; `unifyFast True` is just equality
"
	isFast ifFalse: [ self shouldBeImplemented ].
	^self=t2
		ifTrue: [TVSubst new]
		ifFalse: [nil]
]

{ #category : #'*Refinements' }
Z3Sort >> | aPredicate [
	^ShallowRefinement base: self predicate: aPredicate
]

{ #category : #'*Refinements' }
Z3Sort >> × [ rhs
	^self toProduct × rhs
]

{ #category : #'*Refinements' }
Z3Sort >> ≅ [ rhs 
	self = rhs ifTrue: [^true].
	^(Product with: self) = rhs
]
