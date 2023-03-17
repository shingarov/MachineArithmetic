Class {
	#name : #HornQuery,
	#superclass : #Object,
	#instVars : [
		'qualifiers',
		'vars',
		'qCstr',
		'qCon',
		'qDis',
		'qEqns',
		'qMats',
		'qData',
		'optionEliminate',
		'options'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
HornQuery class >> addIds: cs [
	"Adding shiftId to have distinct VV for SMT conversion.
	addIds :: [SubC] -> [(Integer, SubC)]"
	^cs collectWithIndex: [ :c :i | i -> (c shiftId: i) ]
]

{ #category : #'as yet unclassified' }
HornQuery class >> bindSortedReft_kve: kve bind: aBind [
"
bindSortedReft :: KVEnv a -> H.Bind -> F.SortedReft
Cf. Info.hs
"
	^SortedReft 
		sort: aBind τ
		reft: (Reft symbol: aBind x expr: (aBind p predExpr: kve))
]

{ #category : #'instance creation' }
HornQuery class >> fromThings: things [ 
	| q |
	q := self new.
	things do: [ :x | x addToQuery: q ].
	^q
]

{ #category : #'as yet unclassified' }
HornQuery class >> goS: kvEnv _: iBindEnv _: lhs _: aBindEnv _: aCstr [
	"Recursively traverse the NNF constraint to build up
	 and answer an OrderedCollection of the vanilla SubC constraints.

goS :: KVEnv a -> F.IBindEnv -> F.SortedReft -> F.BindEnv -> H.Cstr a
    -> (F.BindEnv, [F.BindId], [F.SubC a])
"
	| be1_ecs mEbs_subcs |
	be1_ecs := aCstr goS1: kvEnv _: iBindEnv _: lhs _: aBindEnv.
	mEbs_subcs := be1_ecs value partitionEithers.
	^{ be1_ecs key. mEbs_subcs key. mEbs_subcs value. }
]

{ #category : #'as yet unclassified' }
HornQuery class >> hornSubCs_be: be kve: kve c: c [
"
hornSubCs :: F.BindEnv -> KVEnv a -> H.Cstr a
          -> (F.BindEnv, [F.BindId], M.HashMap F.SubcId (F.SubC a))
cf. Horn/Info.hs

At the entry into to this method, be does not contain the real information,
but only the sorts (encoded in trivial SortedRefts) of all kvar arguments, i.e.
0 → nnf_argººk5ºº1 → ℤ
1 → nnf_argººk5ºº2 → ℝ
etc.
"
	| lhs0 be1_ebs_cs |
	lhs0 := self bindSortedReft_kve: kve bind: HBind dummy. "a SortedReft"
	be1_ebs_cs := self goS: kve _: IBindEnv empty _: lhs0 _: be _: c.
	be1_ebs_cs at: 3 put: (Dictionary newFromAssociations: (self addIds: be1_ebs_cs third)).
	^be1_ebs_cs 

]

{ #category : #'instance creation' }
HornQuery class >> hornVariables: ks smalltalkBlock: aBlockClosure [
	| cstr |
	cstr := aBlockClosure valueWithArguments: ks.
	^self fromThings: {cstr}, ks
]

{ #category : #accessing }
HornQuery >> addVar: aHVar [ 
	self vars add: aHVar
]

{ #category : #logic }
HornQuery >> elimKVars [
	"Destructively eliminate all KVars"
	qCstr := qCstr collect: [ :c | c elim ].
	^self
]

{ #category : #logic }
HornQuery >> eliminate [
"
eliminate :: (F.PPrint a) => F.Config -> H.Query a -> IO (H.Query a)
"
	^self options eliminate eliminate: self
]

{ #category : #logic }
HornQuery >> hornFInfo [
"
hornFInfo :: F.Config -> H.Query a -> F.FInfo a
cf. Horn/Info.hs
"
	^FInfo fromQuery: self
]

{ #category : #logic }
HornQuery >> hornWfs [
	"Answer the initial BindEnv and KVEnv from the receiver's vars.
	 This is the only place vars is used.
	 (This method has simplified signature compared to LF,
	 because passing the initial be is unnecessary.)"
	| be1_is be1 is |
	be1_is := self vars
		colject: BindEnv empty
		into: [ :thisBE :k | k kvInfo: thisBE ].
	be1 := be1_is key.
	is := be1_is value.
	^be1 -> (KVEnv newFromAssociations: (is collect: [ :i | i kvVar -> i ]))
]

{ #category : #accessing }
HornQuery >> options [
	options isNil ifTrue: [ options := QueryOptions new ].
	^ options
]

{ #category : #accessing }
HornQuery >> qCon [
	"Dictionary of constants (uninterpreted functions)"
	qCon isNil ifTrue: [ qCon := Dictionary new ].
	^ qCon
]

{ #category : #accessing }
HornQuery >> qCon: anObject [
	qCon := anObject
]

{ #category : #accessing }
HornQuery >> qCstr [
	"list of constraints"
	qCstr isNil ifTrue: [ qCstr := OrderedCollection new ].
	^ qCstr
]

{ #category : #accessing }
HornQuery >> qData [
	"list of data-declarations"
	^ qData
]

{ #category : #accessing }
HornQuery >> qData: anObject [
	qData := anObject
]

{ #category : #accessing }
HornQuery >> qDis [
	"list of constants (uninterpreted functions)"
	^ qDis
]

{ #category : #accessing }
HornQuery >> qDis: anObject [
	qDis := anObject
]

{ #category : #accessing }
HornQuery >> qEqns [
	"list of equations"
	^ qEqns
]

{ #category : #accessing }
HornQuery >> qEqns: anObject [
	qEqns := anObject
]

{ #category : #accessing }
HornQuery >> qMats [
	"list of matches (rewrites)"
	^ qMats
]

{ #category : #accessing }
HornQuery >> qMats: anObject [
	qMats := anObject
]

{ #category : #accessing }
HornQuery >> qualifiers [
	"qualifiers over which to solve cstrs"
	qualifiers isNil ifTrue: [ qualifiers := OrderedCollection new ].
	^ qualifiers
]

{ #category : #logic }
HornQuery >> solve [
	qCstr := qCstr collect: [ :c | c flatten uniq ].
	^self
		eliminate  "→HornQuery"
			hornFInfo  "→FInfo"
				solve
]

{ #category : #private }
HornQuery >> vars [
	"κ-vars, with parameter-sorts"
	vars isNil ifTrue: [ vars := OrderedCollection new ].
	^ vars
]
