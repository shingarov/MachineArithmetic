Class {
	#name : #EvalEnv,
	#superclass : #Object,
	#instVars : [
		'constants'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EvalEnv class >> constants: constants [ 
	^self basicNew constants: constants; yourself 
]

{ #category : #'instance creation' }
EvalEnv class >> ofSorts: sortDict [
	| constants |
	constants := sortDict keysAndValuesCollect: [ :varName :sort | varName -> (sort mkConst: varName) ].
	^self constants: (Dictionary newFromAssociations: constants)
]

{ #category : #compilation }
EvalEnv >> amendedBy: aSubst [ 
	| newConstants |
	newConstants := constants copy.
	aSubst list do: [ :name_val |
		newConstants at: name_val key put: name_val value ].
	^EvalEnv constants: newConstants 
]

{ #category : #accessing }
EvalEnv >> at: v [
	^constants at: v ifAbsent: [ UnknownEVar new: v ]
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
EvalEnv >> createCompiler [
	| compiler |
	compiler := self class compiler class new.
	compiler context: self ctContext.
	^compiler
]

{ #category : #compilation }
EvalEnv >> ctContext [
	^CardanoTartagliaContext ofVariables: self constants
]

{ #category : #compilation }
EvalEnv >> evaluate: smalltalkSource [
	^self createCompiler evaluate: smalltalkSource
]
