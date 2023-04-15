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
	| launchContext |
	launchContext := thisContext sender findContextSuchThat: [ :ctx |
		ctx isBlockContext not and: [ ctx methodSelector = #elaborate: ] ].
	launchContext isNil ifTrue: [ ^self error: 'No elaborate: context ' ].
	^(launchContext tempNamed: #γ) hotel
]

{ #category : #comparing }
PreSort >> = rhs [
	self subclassResponsibility 
]

{ #category : #'target resize' }
PreSort >> apply: θ [ 
	^self
]

{ #category : #'as yet unclassified' }
PreSort >> checkFunSort [
	"cf. SortCheck.hs"
	self error: 'NonFunction'
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
self shouldBeImplemented 
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

{ #category : #'as yet unclassified' }
PreSort >> mapSort: f [
"
mapSort :: (Sort -> Sort) -> Sort -> Sort
cf. Visitor.hs
"
	^self stepMapSort: f
]

{ #category : #'as yet unclassified' }
PreSort >> mkConst: name [
	^PreConstant name: name sort: self
]

{ #category : #'SMT interface' }
PreSort >> smt2var: v in: γ [ 
	| z3sort |
	z3sort := self z3sort.
	γ sort note: self elaboratedTo: z3sort.
	^z3sort mkConst: v
]

{ #category : #sorting }
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

{ #category : #'sort-checking' }
PreSort >> subst: j _: tj [
"
subst :: Int -> Sort -> Sort -> Sort
"
	self subclassResponsibility
]

{ #category : #'as yet unclassified' }
PreSort >> trueSortedReft [
	"Same as Z3Sort."
	^SortedReft 
		sort: self
		reft: (Reft expr: (DecidableRefinement always))
]

{ #category : #accessing }
PreSort >> value: arg [
	self subclassResponsibility
]
