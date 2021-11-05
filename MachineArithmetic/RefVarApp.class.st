Class {
	#name : #RefVarApp,
	#superclass : #HPred,
	#instVars : [
		'var',
		'args'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
RefVarApp class >> var: varName args: argArray [
	^self basicNew 
		var: varName;
		args: argArray;
		yourself 
	
]

{ #category : #accessing }
RefVarApp >> args [
	^ args
]

{ #category : #accessing }
RefVarApp >> args: anObject [
	args := anObject
]

{ #category : #accessing }
RefVarApp >> arity [
	^ self args size
]

{ #category : #'as yet unclassified' }
RefVarApp >> findKVarInGuard: k [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
RefVarApp >> kvApp: ys in: kvEnv [
	Subst .
	self shouldBeImplemented.
]

{ #category : #logic }
RefVarApp >> pKVars [ 
	^ Set with: self var
]

{ #category : #'as yet unclassified' }
RefVarApp >> predExpr: kvEnv [
"WE ARE NOT HERE YET! It should not be needed now!"
self shouldBeImplemented. "the most interesting case really, cf. Info.hs:104, predExpr go (H.Var k ys)"
	self kvApp: self args in: kvEnv.

]

{ #category : #printing }
RefVarApp >> printOn: aStream [
	aStream nextPut: $(.
	aStream nextPutAll: self var.
	self args do: [ :anArg |
		aStream nextPut: $ .
		aStream nextPutAll: anArg ].
	aStream nextPut: $).

]

{ #category : #'as yet unclassified' }
RefVarApp >> subst1: new for: old [
	self shouldBeImplemented 
]

{ #category : #accessing }
RefVarApp >> var [
	^ var
]

{ #category : #accessing }
RefVarApp >> var: anObject [
	var := anObject
]

{ #category : #'well-formedness' }
RefVarApp >> wfIn: gamma [
	^false
]
