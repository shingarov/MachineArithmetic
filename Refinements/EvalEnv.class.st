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
	^constants at: v
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
