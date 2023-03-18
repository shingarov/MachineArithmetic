"
Caveat programmator: there are two PAnds:
the Horn PAnd (this one) and the subclass of Expr.
"
Class {
	#name : #HPredAnd,
	#superclass : #HPred,
	#instVars : [
		'ps'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
HPredAnd class >> of: ps [
	^self basicNew
		ps: ps;
		yourself
]

{ #category : #comparing }
HPredAnd >> = rhs [
	"Can't do much."
	self class = rhs class ifFalse: [ ^false ].
	^ps = rhs ps
]

{ #category : #transformations }
HPredAnd >> cHead [
	| nonTrivialConjuncts |
	nonTrivialConjuncts := ps reject: #pTrivial.
	nonTrivialConjuncts isEmpty ifTrue: [ ^HCstr cTrue ].
	nonTrivialConjuncts size = 1 ifTrue: [ ^CstrHead pred: nonTrivialConjuncts anyOne ].
	^HCstr mkHead: (HPredAnd of: nonTrivialConjuncts)  "qs  -> mkHead l (H.PAnd qs)"
]

{ #category : #'well-formedness' }
HPredAnd >> ensureFreeVarsIn: kvEnv areKnownIn: be [
	ps do: [ :p | p ensureFreeVarsIn: kvEnv areKnownIn: be ]
]

{ #category : #transformations }
HPredAnd >> findKVarInGuard: k [
	| findResults l_r lefts rights |
	findResults := ps collect: [ :p | p findKVarInGuard: k ].
	l_r := findResults partitionEithers.
	lefts := l_r key.  rights := l_r value.
	lefts isEmpty ifTrue: [ 
		"kvar not found"
		^Either right: self ].
	self shouldBeImplemented.
]

{ #category : #transformations }
HPredAnd >> flatten [
"
instance Flatten Pred where
  flatten (PAnd ps) = case flatten ps of
                        [p] -> p
                        ps  -> PAnd ps
"
	| fl |
	fl := ps flatten.
	fl size = 1 ifTrue: [ ^fl anyOne ].
	^HPredAnd of: fl
]

{ #category : #comparing }
HPredAnd >> hash [
	"Can't do much."
	^ps hash
]

{ #category : #transformations }
HPredAnd >> pKVars [ 
	| answer |
	answer := Set new.
	(ps collect: [ :p | p pKVars ]) do: [ :aSet | answer addAll: aSet ].
	^answer
]

{ #category : #info }
HPredAnd >> predExpr: kvEnv [
	^PAnd of: (ps collect: [ :p | p predExpr: kvEnv])
]

{ #category : #printing }
HPredAnd >> printOn: aStream [
	aStream nextPut: 16r22C0 asCharacter;
	        nextPut: $(.
	ps printOn: aStream delimiter: ' '.
	aStream nextPut: $).
]

{ #category : #transformations }
HPredAnd >> pruneTautsGoP [
	self shouldBeImplemented.
]

{ #category : #accessing }
HPredAnd >> ps [
	^ ps
]

{ #category : #accessing }
HPredAnd >> ps: anObject [
(anObject allSatisfy: [ :p | p isKindOf: HPred ]) ifFalse: [ self error ].
	ps := anObject
]

{ #category : #'F.Subable' }
HPredAnd >> subst1: su [
	^HPredAnd of: (ps collect: [ :p | p subst1: su ])
]

{ #category : #'F.Subable' }
HPredAnd >> subst: θ [
	^HPredAnd of: [ :p | p subst: θ ] ⊛ ps
]

{ #category : #transformations }
HPredAnd >> substPred: su [
"
substPred su (PAnd ps) = PAnd $ substPred su <$> ps
"
	^HPredAnd of: (ps collect: [ :p | p substPred: su ])
]

{ #category : #'F.Subable' }
HPredAnd >> substa: f [
	^HPredAnd of: [ :p | p substa: f ] ⊛ ps
]

{ #category : #'F.Subable' }
HPredAnd >> substf: f [
	^HPredAnd of: [ :p | p substf: f ] ⊛ ps
]

{ #category : #'F.Subable' }
HPredAnd >> syms [
	^ps collectAndCat: #syms
]
