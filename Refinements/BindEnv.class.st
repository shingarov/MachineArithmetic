Class {
	#name : #BindEnv,
	#superclass : #Object,
	#instVars : [
		'indexDict'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
BindEnv class >> empty [
	^self new
]

{ #category : #visiting }
BindEnv >> accept: aVisitor [
	^self copy 
		indexDict: (indexDict collectAssociations: [ :sym :sr |
			sym ->
			(sr accept: aVisitor) ]);
		yourself
]

{ #category : #'as yet unclassified' }
BindEnv >> adjustVar: varName toHaveSort: s [
		| j sr |
		j := self indexForVar: varName ifAbsent: [
			| jj newSR |
			jj := self nextAvailableNegativeIndex.
			newSR := SortedReft sort: s reft: (Reft expr: (DecidableRefinement always)). "BOGUS, and can't use #trueSortedReft because a FuncDecl is not a Z3Sort"
			indexDict at: jj put: (varName->newSR).
			^self
			].
		sr := (indexDict at: j) value.
		"destructively!"
		sr sr_sort: s
]

{ #category : #'as yet unclassified' }
BindEnv >> bindEnvToList [
	"...for now.  In Smalltalk we can write it much more elegantly.
	Represent the receiver as array of 3-tuples (BindId, Symbol, SortedReft)."
	^indexDict associations collect: [ :ass | {ass key. ass value key. ass value value.} ]
]

{ #category : #sanitizing }
BindEnv >> binders [
"
binders :: F.BindEnv -> [(F.Symbol, (F.Sort, F.BindId))]
"
	^self bindEnvToList collectTriples: [ :i :x :t | x -> (t sr_sort -> i) ]
]

{ #category : #compilation }
BindEnv >> compile [
	indexDict := indexDict collect: [ :var_sr |
		| var sr |
		var := var_sr key.
		sr := var_sr value.
		var -> (sr evaluateIn: self evalEnv) ]
]

{ #category : #'as yet unclassified' }
BindEnv >> concretePreds [
	| concreteIndexDict compiledPreds |
	concreteIndexDict := indexDict select: [ :s_r | s_r value sr_reft expr isBool ].
	compiledPreds := concreteIndexDict collect: [ :s_r |
		| r |
		r := s_r value.
		r sr_reft expr ].
	^compiledPreds reject: #isShortExpr
]

{ #category : #'instance creation' }
BindEnv >> copyDictFrom: aBindEnv [ 
	indexDict := aBindEnv indexDict copy
]

{ #category : #'as yet unclassified' }
BindEnv >> cstrDef: aSimpC [
"cstrDef :: F.BindEnv -> F.SimpC a -> Maybe F.Symbol"
	| v rhs e sym |
	v := aSimpC lookupBindIn: self.
	rhs := aSimpC crhs "stripCasts".
	e := rhs isSingletonExpr: v  in: self evalEnv.
	e isNil ifTrue: [ ^nil ].
	e isNamedConstant ifFalse: [ ^nil ].
	sym := e functorName.
	sym = 'true' ifTrue: [ ^nil ].
	sym = 'false' ifTrue: [ ^nil ].
	^sym
]

{ #category : #'as yet unclassified' }
BindEnv >> domain: aWfC [ 
	"answer a collection of variable names"
	^{aWfC rft first},
	 ((self envCs: aWfC env) collect: #key) asArray
]

{ #category : #'as yet unclassified' }
BindEnv >> elaborate: γ [
"
NB: In Smalltalk, this is destructive.
instance Elaborate BindEnv where
  elaborate z env = mapBindEnv (\i (x, sr) -> (x, elaborate (z' i x sr) env sr))
    where
      z' i  x sr  = z { val = (val z) ++ msg i x sr }
      msg i x sr  = unwords [' elabBE',  show i, show x, show sr]
"



	"We can't mapBindEnv, because self doesn't contain constants (gLits) and env does."
	γ sort associations do: [ :eachAss |
		| varName elaboratedSort |
		varName := eachAss key. elaboratedSort := eachAss value z3sort.
		self adjustVar: varName toHaveSort: elaboratedSort ]
]

{ #category : #'as yet unclassified' }
BindEnv >> envCs: anIBindEnv [
	"Answer the collection of Symbol->SortedReft's for all entries in the argument.
	cf. Types/Environments.hs:
	envCs :: BindEnv -> IBindEnv -> [(Symbol, SortedReft)]"
	^anIBindEnv indexes collect: [ :j | indexDict at: j ]
]

{ #category : #'as yet unclassified' }
BindEnv >> envKVars: c [
	"Answer a collection of kvar names."
	^(c clhs: self) collectAndCat: [ :ass |
		| sr |
		sr := ass value.
		sr sr_reft expr kvarsExpr ]
]

{ #category : #compilation }
BindEnv >> evalEnv [
"TODO: re-express in terms of symBinds/bindSorts, because of uninterpreted functions --- done?? see the commented bogusLits"
	^EvalEnv ofSorts: self sortDict
]

{ #category : #GT }
BindEnv >> gtInspectorBindsIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite fastTable
		title: 'Binds';
		display: [ self indexDict associations ];
			column: 'Index' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Bind' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ]
]

{ #category : #accessing }
BindEnv >> indexDict [
	indexDict isNil ifTrue: [indexDict := Dictionary new].
	^ indexDict
]

{ #category : #accessing }
BindEnv >> indexDict: bs [
	indexDict := bs
]

{ #category : #'as yet unclassified' }
BindEnv >> indexForVar: varName ifAbsent: absentBlock [
	indexDict keysAndValuesDo: [ :k :v | v key = varName ifTrue: [^k] ].
	^absentBlock value
]

{ #category : #updating }
BindEnv >> insertVar: name sort: s [
	"Instantiate a new BindEnv which is a copy of the receiver grown by
	the association, name->TrueRefinement, at the next index, j.
	Answer the association, j->grownBindEnv."
	| j new |
	j := self indexDict size.
	new := BindEnv new. "horrible :-("
	new copyDictFrom: self.
	new indexDict
		at: j
		put: name -> s trueSortedReft.
	^j -> new
]

{ #category : #accessing }
BindEnv >> lookup: aBindId [
"lookupBindEnv :: BindId -> BindEnv -> (Symbol, SortedReft)
cf. Environments.hs"
	^indexDict at: aBindId 
]

{ #category : #'as yet unclassified' }
BindEnv >> mapBindEnv: f [
"
mapBindEnv :: (BindId -> (Symbol, SortedReft) -> (Symbol, SortedReft)) -> BindEnv -> BindEnv
mapBindEnv f (BE n m) = BE n $ M.mapWithKey f m
Cf. Environments.hs
"
	| indexDict_ |
	indexDict_ := indexDict associations collectAssociations: [ :i :x_sr | i->(f value: i value: x_sr) ].
	indexDict_ := Dictionary newFromAssociations: indexDict_.
	^BindEnv new
		indexDict: indexDict_;
		yourself
]

{ #category : #'as yet unclassified' }
BindEnv >> nextAvailableIndex [
	indexDict isEmpty ifTrue: [ ^0 ].
	^indexDict keys max + 1
]

{ #category : #'as yet unclassified' }
BindEnv >> nextAvailableNegativeIndex [
	indexDict isEmpty ifTrue: [^-1].
	^indexDict keys min - 1
]

{ #category : #accessing }
BindEnv >> sortDict [
	^(self sortedReftsDict collect: #sr_sort) ", bogusGlits"
	
]

{ #category : #accessing }
BindEnv >> sortOf: varName [
	^self sortDict at: varName
]

{ #category : #accessing }
BindEnv >> sortedReftsDict [
	^Dictionary newFromAssociations: indexDict values 
	
]

{ #category : #'as yet unclassified' }
BindEnv >> subcKVars: c [
	^(self envKVars: c), c rhsKVars
]

{ #category : #accessing }
BindEnv >> sxEnv [ 
	^Dictionary newFromAssociations: (self bindEnvToList collect: [ :i_x_sr |
				| i x sr |
				i := i_x_sr first.
				x := i_x_sr second.
				sr := i_x_sr third.
				x->(i->sr sr_sort) ])
]

{ #category : #sanitizing }
BindEnv >> symBinds [
"
symBinds  :: F.BindEnv -> [SymBinds]
type SymBinds = (F.Symbol, [(F.Sort, [F.BindId])])
"
	^(self binders groupAssociations collect: [ :each | each groupList ]) associations
]

{ #category : #accessing }
BindEnv >> toList [
	"Answer a collection each element of which is of the form {BindId.Symbol.SortedReft.}"
	^indexDict associations collect: [ :ass | { ass key. ass value key. ass value value. } ]
]

{ #category : #'as yet unclassified' }
BindEnv >> withoutIndexes: indexesToReject [
	^self copy instVarNamed: 'indexDict' put: (indexDict withoutKeys: indexesToReject); yourself
]
