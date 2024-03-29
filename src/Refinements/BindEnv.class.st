"
The Global Binder Environment.

-- Invariant: All BindIds in the map are less than beSize
type BindEnv       = SizedEnv (Symbol, SortedReft)
"
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
BindEnv >> bindEnvToList [
	"...for now.  In Smalltalk we can write it much more elegantly.
	Represent the receiver as array of 3-tuples (BindId, Symbol, SortedReft).
	
	This is the innermost method in the call chain,
	simplify→symbolEnv→symbolSorts→bindSorts→symBinds→binders→bindEnvToList,
	where we transform the BindEnv initially collected ???where???... to the sEnv passed to elaborate: sEnv"
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
BindEnv >> compileIn: γ [
	indexDict := indexDict collect: [ :var_sr |
		| var sr |
		var := var_sr key.
		sr := var_sr value.
		var -> (sr evaluateIn: γ) ]
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
	rhs := aSimpC crhs "stripCasts  - BOGUS".
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

{ #category : #Elaborate }
BindEnv >> elaborate: γ [
"
NB: In Smalltalk, this is destructive.
instance Elaborate BindEnv where
  elaborate z env = mapBindEnv (\i (x, sr) -> (x, elaborate (z' i x sr) env sr))
    where
      z' i  x sr  = z { val = (val z) ++ msg i x sr }
      msg i x sr  = unwords [' elabBE',  show i, show x, show sr]
"

	self mapBindEnv: [ :i :x_sr |
		| x sr |  x := x_sr key. sr := x_sr value.
		x -> (sr elaborate: γ) ]
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
BindEnv >> insertVar: x sort: r [
	"
insertBindEnv :: Symbol -> SortedReft -> BindEnv -> (BindId, BindEnv)
insertBindEnv x r (BE n m) = (n, BE (n + 1) (M.insert n (x, r) m))
	
	Instantiate a new BindEnv which is a copy of the receiver grown by
	the association, name->r, at the next index, j.
	Answer the association, j->grownBindEnv."
	| j new |
	j := self indexDict size.
	new := BindEnv new. "horrible :-("
	new copyDictFrom: self.
	new indexDict
		at: j
		put: x -> r trueSortedReft. "FIXME: this is because sometimes r is a Z3 sort"
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
In Smalltalk we destructively replace the indexDict in-place.
"
	| associations′ |
	associations′ := indexDict associations collectAssociations: [ :i :x_sr | i->(f value: i value: x_sr) ].
	indexDict := Dictionary newFromAssociations: associations′
]

{ #category : #'SMT interface' }
BindEnv >> smt2: γ [
	self mapBindEnv: [ :i :x_sr |
		| x sr |  x := x_sr key. sr := x_sr value.
		x -> (sr smt2: γ) ]
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
BindEnv >> sortOf: varName ifAbsent: aBlock [
	^self sortDict at: varName ifAbsent: aBlock
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
