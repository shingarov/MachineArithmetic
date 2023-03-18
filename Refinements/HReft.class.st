"
Caveat programmator: this is the Reft in Horn.Types
(one of the terms of the HPred coproduct),
NOT the Reft in Types.Refinements.
"
Class {
	#name : #HReft,
	#superclass : #HPred,
	#instVars : [
		'expr'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
HReft class >> expr: e [
	^self basicNew
		expr: e;
		yourself
]

{ #category : #comparing }
HReft >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^expr = rhs expr
]

{ #category : #'well-formedness' }
HReft >> ensureFreeVarsIn: kvEnv areKnownIn: be [
	"NOP"
]

{ #category : #compilation }
HReft >> evaluateIn: anEvalEnv [
	^HReft expr: (expr evaluateIn: anEvalEnv)
]

{ #category : #accessing }
HReft >> expr [
	^ expr
]

{ #category : #accessing }
HReft >> expr: anObject [
	expr := anObject
]

{ #category : #comparing }
HReft >> hash [
	^expr hash
]

{ #category : #info }
HReft >> predExpr: kvEnv [
	^expr
]

{ #category : #printing }
HReft >> printOn: aStream [
	aStream nextPut: 16r22C8 asCharacter.
	expr printOn: aStream
]

{ #category : #transformations }
HReft >> pruneTautsGoP [
"
goP (Reft e) = if F.isTautoPred e then Nothing else Just $ Reft e
"
	expr isTautoPred ifTrue: [ ^nil ].
	^self
]

{ #category : #'F.Subable' }
HReft >> subst1: su [
	^HReft expr: (expr subst1: su)
]

{ #category : #'F.Subable' }
HReft >> subst: θ [
	^HReft expr: (expr subst: θ)
]

{ #category : #transformations }
HReft >> substPred: su [
"
substPred su (Reft e) = Reft $ F.subst (F.Su $ F.EVar <$> su) e
This is the interesting leaf case.
"
	^HReft expr: (expr subst: (su collect: #toEVar))
]

{ #category : #'F.Subable' }
HReft >> substa: f [
	^HReft expr: (expr substa: f)
]

{ #category : #'F.Subable' }
HReft >> substf: f [
	^HReft expr: (expr substf: f)
]

{ #category : #'F.Subable' }
HReft >> syms [
	^expr syms
]
