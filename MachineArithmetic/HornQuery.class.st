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
		'optionEliminate'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'as yet unclassified' }
HornQuery class >> addIds: cs [
	^cs collectWithIndex: [ :c :i | i -> (c shiftId: i) ]
]

{ #category : #'as yet unclassified' }
HornQuery class >> bindSortedReft_kve: kve bind: aBind [ 
	^SortedReft basicNew 
		sr_sort: aBind τ;
		sr_reft: (Reft symbol: aBind x expr: (aBind p predExpr: kve));
		yourself
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
	 and answer an OrderedCollection of the vanilla SubC constraints."
	| be1_ecs mEbs_subcs |
	be1_ecs := aCstr goS1: kvEnv _: iBindEnv _: lhs _: aBindEnv.
	mEbs_subcs := self partitionEithers: be1_ecs value.
	^{ be1_ecs key. mEbs_subcs key. mEbs_subcs value. }
]

{ #category : #'as yet unclassified' }
HornQuery class >> hornSubCs_be: be kve: kve c: c [
	| lhs0 be1_ebs_cs |
	lhs0 := self bindSortedReft_kve: kve bind: HBind dummy.
	be1_ebs_cs := self goS: kve _: IBindEnv empty _: lhs0 _: be _: c.
	be1_ebs_cs at: 3 put: (Dictionary newFromAssociations: (self addIds: be1_ebs_cs third)).
	^be1_ebs_cs 

]

{ #category : #'as yet unclassified' }
HornQuery class >> hornWfs: be _: vars [
	| be1_is be1 is |
	be1_is := vars colject: be into: [ :thisBE :k | KVInfo be: thisBE k: k ].
	be1 := be1_is key.
	is := be1_is value.
	^be1 -> (Dictionary newFromAssociations: (is collect: [ :i | i kvVar -> i ]))
]

{ #category : #'as yet unclassified' }
HornQuery class >> partitionEithers: aCollection [
	"Ooooh this is really ugly."
	| lefts rights |
	lefts := OrderedCollection new.
	rights := OrderedCollection new.
	aCollection do: [ :either |
			"either the left or the right side of the arrow is nil,
			 and the other is not nil."
			either key isNil 
				ifTrue: [ rights add: either value ]
				ifFalse: [ lefts add: either key ]
		 ].
	^lefts -> rights
]

{ #category : #'as yet unclassified' }
HornQuery >> elimKVars [
	"Destructively eliminate all KVars"
	qCstr := qCstr collect: [ :c | c elim ]
]

{ #category : #'as yet unclassified' }
HornQuery >> eliminate [
	^self optionEliminate eliminate: self
]

{ #category : #logic }
HornQuery >> hornFInfo [
	^FInfo fromQuery: self
]

{ #category : #'as yet unclassified' }
HornQuery >> optionEliminate [
	optionEliminate isNil ifTrue: [ optionEliminate := HOptEliminate new ].
	^ optionEliminate
]

{ #category : #options }
HornQuery >> optionEliminate: aHOptEliminate [
	optionEliminate isNil ifFalse: [ self error: 'Duplicate eliminate=' ].
	optionEliminate := aHOptEliminate
]

{ #category : #accessing }
HornQuery >> qCon [
	"list of constants (uninterpreted functions)"
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
	qCstr := qCstr collect: [ :c | c flatConstraint uniq ].
	^self eliminate hornFInfo solve
]

{ #category : #accessing }
HornQuery >> vars [
	"κ-vars, with parameter-sorts"
	vars isNil ifTrue: [ vars := OrderedCollection new ].
	^ vars
]
