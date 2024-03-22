"
I am the superclass of all brain-damaged Sorts which are not Z3Sorts.
"
Class {
	#name : #PreSort,
	#superclass : #Object,
	#category : #Refinements
}

{ #category : #hotel }
PreSort class >> guestInRoom: j [
	"If room j in the Sort Hotel is occupied, answer the guest.
	 If there is no room j (aka it's empty), answer nil."
	^self hotel at: j ifAbsent: [ nil ]
]

{ #category : #hotel }
PreSort class >> hotel [
	^Context readState: #hotel
]

{ #category : #comparing }
PreSort >> = rhs [
	self subclassResponsibility 
]

{ #category : #'sort algebra' }
PreSort >> @ j [ 
	^FAbs int: j sort: self
]

{ #category : #visiting }
PreSort >> accept: aVisitor [ 
	^self
]

{ #category : #yondea }
PreSort >> apply: θ [ 
	^self
]

{ #category : #'sort algebra' }
PreSort >> checkFunSort [
	"cf. SortCheck.hs"
	self error: 'NonFunction'
]

{ #category : #'sort algebra' }
PreSort >> containsFVar [
	^self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PreSort >> fApp: argSorts [
	"Same as in Z3Sort."
	^argSorts inject: self into: [ :x :y | FApp s: x t: y ]
]

{ #category : #'as yet unclassified' }
PreSort >> functionSort [
"
functionSort :: Sort -> Maybe ([Int], [Sort], Sort)
"
	| is_ss_r |
	is_ss_r := self goFunctionSort: #() _: #().
	(is_ss_r first isEmpty and: [ is_ss_r second isEmpty ]) ifTrue: [ ^nil ].
	^is_ss_r
]

{ #category : #'as yet unclassified' }
PreSort >> goFunctionSort: vs _: ss [
"
go vs ss t             = (reverse vs, reverse ss, t)
"
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PreSort >> goMapSort: stepBlock [
	^self
]

{ #category : #hotel }
PreSort >> guest [
	^self
]

{ #category : #comparing }
PreSort >> hash [
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PreSort >> instantiate [
"
instantiate :: Sort -> CheckM Sort
Cf. SortCheck.hs
"
	^self
]

{ #category : #'sort algebra' }
PreSort >> isMono [
"
In LH this goes through the much-more-general foldSort.
"
	^self containsFVar not
]

{ #category : #'as yet unclassified' }
PreSort >> mapSort: f [
"
mapSort :: (Sort -> Sort) -> Sort -> Sort
cf. Visitor.hs
"
	^self stepMapSort: f
]

{ #category : #'sort algebra' }
PreSort >> mkConst: name [
	"This is needed because the receiver may have already
	 distilled down to a Z3 sort; then we need a Z3 const,
	 not an EVar."
	^EVar of: name
]

{ #category : #'as yet unclassified' }
PreSort >> mkZ3const: sym [ 
	^self z3sort mkConst: sym
]

{ #category : #substitution }
PreSort >> sortSubst: θ [
"
------------------------------------------------------------------------
sortSubst                 :: SortSubst -> Sort -> Sort
------------------------------------------------------------------------
sortSubst θ t@(FObj x)    = fromMaybe t (M.lookup x θ)
sortSubst θ (FFunc t1 t2) = FFunc (sortSubst θ t1) (sortSubst θ t2)
sortSubst θ (FApp t1 t2)  = FApp  (sortSubst θ t1) (sortSubst θ t2)
sortSubst θ (FAbs i t)    = FAbs i (sortSubst θ t)
sortSubst _  t            = t
"
	self subclassResponsibility 
]

{ #category : #'as yet unclassified' }
PreSort >> stepMapSort: f [
"cf. Visitor.hs"
	^(f value: self) goMapSort: [ :x | x stepMapSort: f ]
]

{ #category : #substitution }
PreSort >> subst: j _: tj [
"
subst :: Int -> Sort -> Sort -> Sort
"
	self subclassResponsibility
]

{ #category : #'sort algebra' }
PreSort >> trueSortedReft [
	"Same as Z3Sort."
	^SortedReft 
		sort: self
		reft: (Reft expr: (DecidableRefinement always))
]

{ #category : #'as yet unclassified' }
PreSort >> uncurriedZ3sig [
	^#() -> self z3sort
]

{ #category : #'sort algebra' }
PreSort >> unify: t2 env: f fast: isFast [
"
Fast Unification; `unifyFast True` is just equality.
FIXME: code duplication with Z3Sort.
"
	isFast ifFalse: [ ^Z3Sort unify: f maybeExpr: nil sort: self sort: t2 ].
	^self = t2 guest
		ifTrue: [TVSubst new]
		ifFalse: [nil]
]

{ #category : #'sort algebra' }
PreSort >> unifyVar: f maybeExpr: e tvSubst: θ int: i [
	"TODO: duplication with Z3Sort"
	(θ lookupVar: i)
		ifNil: [ ^θ updateVar: i _: self ]
		ifNotNil: [ :t_ | ^self shouldBeImplemented  ]
]

{ #category : #accessing }
PreSort >> value: arg [
	self subclassResponsibility
]

{ #category : #hotel }
PreSort >> z3sort [
	self subclassResponsibility
]
