"
data Pred
  ...
  | Var  !F.Symbol ![F.Symbol]  -- ^ $k(y1..yn)
  ...

Cf. Horn/Types.hs
"
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
	aStream nextPutAll: '($'.
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

{ #category : #'F.Subable' }
RefVarApp >> subst1: su [
	^RefVarApp
		var: var
		args: (args collect: [ :arg | arg subst1: su ])
]

{ #category : #'F.Subable' }
RefVarApp >> subst: θ [
	^RefVarApp
		var: var
		args: [ :arg | arg subst: θ ] ⊛ args
]

{ #category : #transformations }
RefVarApp >> substPred: su [
"
substPred su (Var k xs) = Var k $ upd <$> xs
  where upd x = M.lookupDefault x x su
"
	^RefVarApp
		var: var
		args: (args collect: [ :arg | su at: arg ifAbsent: [arg] ])
]

{ #category : #'F.Subable' }
RefVarApp >> substa: f [
	^RefVarApp
		var: var
		args: [ :arg | arg substa: f ] ⊛ args
]

{ #category : #'F.Subable' }
RefVarApp >> substf: f [
	^RefVarApp
		var: var
		args: [ :arg | arg substf: f ] ⊛ args
]

{ #category : #'F.Subable' }
RefVarApp >> substs: xys [
	| θ |
	θ := Dictionary newFromAssociations: xys.
	^RefVarApp
		var: var
		args: (args collect: [ :eachArg | θ at: eachArg ifAbsent: [eachArg] ])
]

{ #category : #'F.Subable' }
RefVarApp >> syms [
	^args
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
