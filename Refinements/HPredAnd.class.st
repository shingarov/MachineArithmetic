Class {
	#name : #HPredAnd,
	#superclass : #HPred,
	#instVars : [
		'conjuncts'
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

{ #category : #GT }
HPredAnd >> children [
	^conjuncts
]

{ #category : #accessing }
HPredAnd >> conjuncts [
	^ conjuncts
]

{ #category : #accessing }
HPredAnd >> conjuncts: aCollection [ 
	conjuncts := aCollection
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

{ #category : #logic }
HPredAnd >> flatConstraint [
	| flatConjuncts |
	flatConjuncts := self conjuncts flatConstraint.
	"special-case of singleton collection"
	flatConjuncts size = 1 ifTrue: [ ^flatConjuncts anyOne ].
	^HPredAnd of: flatConjuncts
]

{ #category : #comparing }
HPredAnd >> hash [
	^conjuncts size hash
]

{ #category : #'as yet unclassified' }
HPredAnd >> isTauto [
	conjuncts do: [ :c | c isTauto ifFalse: [ ^false ]].
	^true
]

{ #category : #'term rewriting' }
HPredAnd >> kvarsExpr [
	^((conjuncts collect: #kvarsExpr) collectAndCat: #asArray) asSet asArray
]

{ #category : #'term rewriting' }
HPredAnd >> mapKVarSubsts: twoArgumentBlock [ 
	^self class of: (conjuncts collect: [ :each | each mapKVarSubsts: twoArgumentBlock ])
]

{ #category : #logic }
HPredAnd >> pKVars [ 
	| answer |
	answer := Set new.
	(self conjuncts collect: [ :child | child pKVars ]) do: [ :aSet | answer addAll: aSet ].
	^answer
]

{ #category : #'as yet unclassified' }
HPredAnd >> predExpr: kvEnv [
	^HPredAnd of: (self conjuncts collect: [ :c | c predExpr: kvEnv ])
]

{ #category : #printing }
HPredAnd >> printOn: aStream [
	aStream nextPut: $&.
	self conjuncts printElementsOn: aStream 
]

{ #category : #'as yet unclassified' }
HPredAnd >> refaConjuncts [
	^conjuncts
]

{ #category : #'as yet unclassified' }
HPredAnd >> rename: a to: b [
	^self class of: (conjuncts collect: [ :each | each rename: a to: b ])
]

{ #category : #'as yet unclassified' }
HPredAnd >> subst1: new for: old [
	^HPredAnd of: (conjuncts collect: [ :each | each subst1: new for: old ])
]

{ #category : #'as yet unclassified' }
HPredAnd >> uniq1: α [
	^HPredAnd of: (conjuncts collect: [ :each | each uniq1: α])
]

{ #category : #'well-formedness' }
HPredAnd >> wfIn: gamma [ 
	^self conjuncts allSatisfy: [ :c | c wfIn: gamma ]
]
