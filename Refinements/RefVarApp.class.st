Class {
	#name : #RefVarApp,
	#superclass : #HPred,
	#instVars : [
		'var',
		'args'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
RefVarApp class >> var: varName args: argArray [
	^self basicNew 
		var: varName;
		args: argArray;
		yourself 
	
]

{ #category : #comparing }
RefVarApp >> = another [
	self class = another class ifFalse: [ ^false ].
	^(var = another var) and: [ args = another args ]
]

{ #category : #visiting }
RefVarApp >> accept: aVisitor [
	self shouldBeImplemented
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
	k = var
		ifTrue: [ ^Either left: { k -> args. } -> #() ]
		ifFalse: [ ^Either right: self ]
]

{ #category : #comparing }
RefVarApp >> hash [
	^var hash
]

{ #category : #'as yet unclassified' }
RefVarApp >> isTauto [
	^false
]

{ #category : #'as yet unclassified' }
RefVarApp >> kvApp: ys in: kvEnv [
	| kvInfo substs |
	kvInfo := kvEnv at: var ifAbsent: [self error: 'Unknown Horn variable: ', var].
	substs := kvInfo kvParams zip: (args collect: #toEVar).
	^PKVar var: var subst: (Subst mkSubst: substs)
]

{ #category : #'as yet unclassified' }
RefVarApp >> kvarsExpr [
	self shouldBeImplemented 
]

{ #category : #logic }
RefVarApp >> pKVars [ 
	^ Set with: self var
]

{ #category : #'as yet unclassified' }
RefVarApp >> predExpr: kvEnv [
	"the most interesting case really, cf. Info.hs:104, predExpr go (H.Var k ys)"
	^self kvApp: self args in: kvEnv

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
RefVarApp >> rename: a to: b [
	^RefVarApp
		var: var
		args: (args collect: [ :arg | 
			arg isString ifFalse: [ self error ].
			arg=a ifTrue: [b] ifFalse: [arg] ])
]

{ #category : #'as yet unclassified' }
RefVarApp >> subst1: new for: old [
	| newName newArgs |
	newName := new sym.
	newName = old ifTrue: [ ^self ].
	newArgs := args collect: [ :oldArg | oldArg = old 
		ifTrue: [ newName ] ifFalse: [ oldArg ] ].
	^RefVarApp var: var args: newArgs
]

{ #category : #'as yet unclassified' }
RefVarApp >> subst: su [
	self shouldBeImplemented 
]

{ #category : #'as yet unclassified' }
RefVarApp >> substPred: oldToNewVarNameAssocs [
	| dict newArgs |
	dict := Dictionary newFromAssociations: oldToNewVarNameAssocs.
	newArgs := args collect: [ :eachArg |
		dict at: eachArg ifAbsent: [eachArg] ].
	^self class var: var args: newArgs
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
