"
NB: This is NOT the EvalEnv in Solver/PLE.hs, NOR the EvalEnv in Solver/Instantiate.hs!
"
Class {
	#name : #EvalEnv,
	#superclass : #Object,
	#instVars : [
		'constants'
	],
	#category : #'Refinements-Core'
}

{ #category : #'instance creation' }
EvalEnv class >> constants: constants [ 
	^self basicNew constants: constants; yourself 
]

{ #category : #'instance creation' }
EvalEnv class >> ofSorts: sortDict [
	| constants |
	constants := sortDict keysAndValuesCollect: [ :varName :sort | varName -> (sort mkConst: varName) ].
	^self constants: constants
]

{ #category : #'instance creation' }
EvalEnv class >> ofZ3Sorts: sortDict [
	"Try as best as we can to go all the way to Z3 sorts
	 and create Z3 constants, not just EVars; but if all
	 fails, punt and answer the EVar like #ofSorts: does."
	| constants |
	constants := sortDict keysAndValuesCollect: [ :varName :sort | varName -> (([sort z3sort: nil] on: Error do: [sort]) mkConst: varName) ].
	^self constants: constants
]

{ #category : #semigroup }
EvalEnv >> , rhs [
	^self class constants: constants, rhs constants
]

{ #category : #compilation }
EvalEnv >> amendedBy: aSubst [ 
	| newConstants |
	newConstants := constants copy.
	aSubst associations do: [ :name_val |
		newConstants at: name_val key put: name_val value ].
	^EvalEnv constants: newConstants 
]

{ #category : #accessing }
EvalEnv >> at: v [
	^self at: v ifAbsent: [ UnknownEVar new: v ]
]

{ #category : #accessing }
EvalEnv >> at: v ifAbsent: vndBlock [
	^constants at: v ifAbsent: vndBlock
]

{ #category : #accessing }
EvalEnv >> constants [
	^ constants
]

{ #category : #accessing }
EvalEnv >> constants: anObject [
	constants := anObject
]

{ #category : #compilation }
EvalEnv >> ctContext [
	^CardanoTartagliaContext ofVariables: self constants
]

{ #category : #compilation }
EvalEnv >> evaluate: smalltalkSource [
	^self ctContext evaluate: smalltalkSource
]

{ #category : #GT }
EvalEnv >> gtInspectorConstantsIn: composite [
	<gtInspectorPresentationOrder: 20>
	^ composite fastTable
		title: 'Constants';
		display: [ self constants associations ];
		sortBlock: [ :a :b | a key <= b key ];
		column: 'Var' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Value' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ]
]
