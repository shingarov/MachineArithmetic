Extension { #name : #Z3Sort }

{ #category : #'*Refinements' }
Z3Sort >> addReferencedDatatypesTo: _ [
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
Z3Sort >> checkNumeric: env tvSubst: θ [
	self shouldBeImplemented.
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
Z3Sort >> fldSort: aDataDecl [ 
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> functionSort [
	^nil
]

{ #category : #'*Refinements' }
Z3Sort >> goFunctionSort: vs _: ss [ 
	^{ vs reversed . ss reversed . self }
]

{ #category : #'*Refinements' }
Z3Sort >> goMapSort: stepBlock [ 
	^self
]

{ #category : #'*Refinements' }
Z3Sort class >> goMkFFunc: x y: y [
	x isEmpty
		ifTrue: [
			| s ss |
			y isEmpty ifTrue: [ self error ].
			y size = 1 ifTrue: [ ^y first ].
			s := y first.  ss := y allButFirst.
			"too early for Z3 #functionFrom:to:, because elab"
			^FFunc from: s to: (self goMkFFunc: #() y: ss)
		] ifFalse: [
			| i is |
			i := x first.  is := x allButFirst.
			^(self goMkFFunc: is y: y) @ i
		]
]

{ #category : #'*Refinements' }
Z3Sort >> guest [
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> instantiate [
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> isMono [
	self subclassResponsibility
]

{ #category : #'*Refinements' }
Z3Sort >> isUndef [
	^false
]

{ #category : #'*Refinements' }
Z3Sort >> mapSort: f [ 
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> maybeExistingSortIn: _ [ 
	^self
]

{ #category : #'*Refinements' }
Z3Sort class >> mkFFunc: i sorts: ss [
"
mkFFunc :: Int -> [Sort] -> Sort
Cf. Types/Sorts.hs
"
	^self goMkFFunc: (0 to: i-1) y: ss

]

{ #category : #'*Refinements' }
Z3Sort >> mkZ3const: sym in: _ [
	^self mkConst: sym
]

{ #category : #'*Refinements' }
Z3Sort >> monomorphicDeclIn: _ [ 
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> monomorphicSortName [
	^self printString
]

{ #category : #'*Refinements' }
Z3Sort >> proxyForVar: varName in: env [
	^self "I am already monomorphic"
]

{ #category : #'*Refinements' }
Z3Sort >> sortAbs [
"
sortAbs _             = -1
"
	^ -1
]

{ #category : #'*Refinements' }
Z3Sort >> sortSubst: θ [
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> stepMapSort: f [ 
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> subst: j _: tj [ 
	^self
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
Z3Sort >> unAbs [
"
unAbs :: Sort -> Sort
"
	^self
]

{ #category : #'*Refinements' }
Z3Sort >> unFAppGo: acc [ 
	^{self}, acc
]

{ #category : #'*Refinements' }
Z3Sort >> uncurriedZ3sigIn: _ [
	^#()->self
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
Z3Sort >> unifyVar: f maybeExpr: e tvSubst: θ int: i [
	(θ lookupVar: i)
		ifNil: [ ^θ updateVar: i _: self ]
		ifNotNil: [ :t′ |
				(t′ isKindOf: FVar) ifTrue: [ ^self shouldBeImplemented "Just (FVar !j) -> return $ updateVar i t $ updateVar j t θ" ].
				^self = t′
						ifTrue: [ θ ]
						ifFalse: [ self shouldBeImplemented "else unify1 f e θ t t'" ]
				 ]
]

{ #category : #'*Refinements' }
Z3Sort >> z3sort: _ [
	^self
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
Z3Sort >> ⇴ [ codomainSort
	^FuncSort key: self value: codomainSort
]

{ #category : #'*Refinements' }
Z3Sort >> ≅ [ rhs 
	self = rhs ifTrue: [^true].
	^(Product with: self) = rhs
]
