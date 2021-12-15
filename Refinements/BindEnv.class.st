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

{ #category : #'as yet unclassified' }
BindEnv >> bindEnvToList [
	"...for now.  In Smalltalk we can write it much more elegantly.
	Represent the receiver as array of 3-tuples (BindId, Symbol, SortedReft)."
	^indexDict associations collect: [ :ass | {ass key. ass value key. ass value value.} ]
]

{ #category : #'as yet unclassified' }
BindEnv >> copyDictFrom: aBindEnv [ 
	indexDict := aBindEnv indexDict copy
]

{ #category : #'as yet unclassified' }
BindEnv >> ctContext [
	| ctx |
	ctx := CardanoTartagliaContext new.
	self indexDict do: [ :ass |
		| v sort |
		v := ass key.
		sort := ass value sr_sort.
		ctx tempNamed: v put: (sort mkConst: v) ].
	^ctx
]

{ #category : #'as yet unclassified' }
BindEnv >> domain: aWfC [ 
	"answer a collection of variable names"
	^{aWfC rft first.},
	((self envCs: aWfC env) collect: #first)
]

{ #category : #'as yet unclassified' }
BindEnv >> envCs: anIBindEnv [
	"Answer the collection of Symbol->SortedReft's for all entries in the argument."
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

{ #category : #'as yet unclassified' }
BindEnv >> evaluate: aString [ 
	| compiler |
	compiler := self class compiler class new.
	compiler context: self ctContext.
	^compiler evaluate: aString
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

{ #category : #'as yet unclassified' }
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
	^new -> j
]

{ #category : #'as yet unclassified' }
BindEnv >> mapKVarSubsts: aBlock [
	indexDict do: [ :v | v value sr_reft mapKVarSubsts: aBlock ]
]

{ #category : #'as yet unclassified' }
BindEnv >> sortOf: varName [
	^((Dictionary newFromAssociations: self indexDict values) at: varName) sr_sort
]

{ #category : #'as yet unclassified' }
BindEnv >> subcKVars: c [
	^(self envKVars: c), c rhsKVars
]

{ #category : #'as yet unclassified' }
BindEnv >> sxEnv [ 
	^Dictionary newFromAssociations: (self bindEnvToList collect: [ :i_x_sr |
				| i x sr |
				i := i_x_sr first.
				x := i_x_sr second.
				sr := i_x_sr third.
				x->(i->sr sr_sort) ])
]

{ #category : #'as yet unclassified' }
BindEnv >> toList [
	"Answer a collection each element of which is of the form {BindId.Symbol.SortedReft.}"
	^indexDict associations collect: [ :ass | { ass key. ass value key. ass value value. } ]
]

{ #category : #'as yet unclassified' }
BindEnv >> variableNamed: v [
	^(self sortOf: v) mkConst: v
]
