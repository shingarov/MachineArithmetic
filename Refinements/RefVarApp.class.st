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

{ #category : #'well-formedness' }
RefVarApp >> ensureFreeVarsIn: kvEnv areKnownIn: be [
	"Put the sort of every argument, x y z in κ(x,y,z),
	 into be if it's not already there,
	 taking it from the declaration of κ.
	 This is only needed in Smalltalk, so that later at compile
	 we will be able to instantiate a Z3 variable.
	"
	| domain |
	domain := (kvEnv at: var) domain.
	
	args doWithIndex: [ :eachArg :index |
		be sortOf: eachArg ifAbsent: [
				| srt |
				srt := (domain at: index) value.
				be adjustVar: eachArg toHaveSort: srt
		]
	]
]

{ #category : #transformations }
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

{ #category : #transformations }
RefVarApp >> pKVars [
	^Set with: self var
]

{ #category : #info }
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

{ #category : #transformations }
RefVarApp >> pruneTautsGoP [
	^self
]

{ #category : #'α-renaming' }
RefVarApp >> rename: a to: b [
	^RefVarApp
		var: var
		args: (args collect: [ :arg | 
			arg isString ifFalse: [ self error ].
			arg=a ifTrue: [b] ifFalse: [arg] ])
]

{ #category : #'as yet unclassified' }
RefVarApp >> subst1: x_e [
	| x e newName newArgs |
	x := x_e key.  e := x_e value.
	(e isConstantNamed: x) ifTrue: [ ^self ].
	newName := e sym.
	newArgs := args collect: [ :oldArg | oldArg = x 
		ifTrue: [ newName ] ifFalse: [ oldArg ] ].
	^RefVarApp var: var args: newArgs
]

{ #category : #'as yet unclassified' }
RefVarApp >> subst: su [
	^RefVarApp
		var: (var subst: su)
		args: (args subst: su)
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
