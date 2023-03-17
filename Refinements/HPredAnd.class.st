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
HPredAnd class >> new [
	"The unit of the monoid"
	^self of: #()
]

{ #category : #'instance creation' }
HPredAnd class >> of: conjuncts [
	^self basicNew
		conjuncts: conjuncts;
		yourself
]

{ #category : #comparing }
HPredAnd >> = another [
	self class = another class ifFalse: [ ^false ].
	^conjuncts = another conjuncts
]

{ #category : #visiting }
HPredAnd >> accept: aVisitor [
	^self class of: (conjuncts collect: [ :each | each accept: aVisitor ])
]

{ #category : #GT }
HPredAnd >> children [
	^conjuncts
]

{ #category : #'term rewriting' }
HPredAnd >> evaluateIn: aBindEnv [
	| conjunctValues |
	conjunctValues := conjuncts collect: [ :each | each evaluateIn: aBindEnv ].
	^self isConc ifTrue: [ Bool and: conjunctValues ] ifFalse: [ HPredAnd of: conjunctValues ]

]

{ #category : #logic }
HPredAnd >> findKVarInGuard: k [
	| findResults l_r lefts rights |
	findResults := conjuncts collect: [ :p | p findKVarInGuard: k ].
	l_r := findResults partitionEithers.
	lefts := l_r key.  rights := l_r value.
	lefts isEmpty ifTrue: [ 
		"kvar not found"
		^Either right: (HPredAnd of: conjuncts) ].
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
	^conjuncts size hash
]

{ #category : #'term rewriting' }
HPredAnd >> kvarsExpr [
	^((conjuncts collect: #kvarsExpr) collectAndCat: #asArray) asSet asArray
]

{ #category : #logic }
HPredAnd >> pKVars [ 
	| answer |
	answer := Set new.
	(self conjuncts collect: [ :child | child pKVars ]) do: [ :aSet | answer addAll: aSet ].
	^answer
]

{ #category : #logic }
HPredAnd >> predExpr: kvEnv [
	^HPredAnd of: (self conjuncts collect: [ :c | c predExpr: kvEnv ])
]

{ #category : #printing }
HPredAnd >> printOn: aStream [
	aStream nextPut: $&.
	self conjuncts printElementsOn: aStream 
]

{ #category : #transformations }
HPredAnd >> pruneTautsGoP [
	self shouldBeImplemented.
]

{ #category : #'term rewriting' }
HPredAnd >> rename: a to: b [
	^self class of: (conjuncts collect: [ :each | each rename: a to: b ])
]

{ #category : #'F.Subable' }
HPredAnd >> subst1: ass [
	^HPredAnd of: (conjuncts collect: [ :each | each subst1: ass ])
]

{ #category : #'F.Subable' }
HPredAnd >> subst: su [
	^self class of: (conjuncts collect: [ :each | each subst: su ])
]

{ #category : #'F.Subable' }
HPredAnd >> substPred: oldToNewVarNameAssocs [
	^HPredAnd of: (conjuncts collect: [ :each | each substPred: oldToNewVarNameAssocs ])
]

{ #category : #'F.Subable' }
HPredAnd >> substf: f [ 
	^self class of: (conjuncts collect: [ :each | each substf: f ])
]

{ #category : #'well-formedness' }
HPredAnd >> wfIn: gamma [ 
	^self conjuncts allSatisfy: [ :c | c wfIn: gamma ]
]
