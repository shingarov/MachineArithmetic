Class {
	#name : #CstrAnd,
	#superclass : #HCstr,
	#instVars : [
		'conjuncts'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
CstrAnd class >> of: conjuncts [
	^self basicNew
		conjuncts: conjuncts;
		yourself
]

{ #category : #logic }
CstrAnd >> boundKVars [
	| answer |
	answer := Set new.
	(self conjuncts collect: [ :child | child boundKVars ]) do: [ :aSet | answer addAll: aSet ].
	^answer
]

{ #category : #accessing }
CstrAnd >> children [ 
	^self conjuncts
]

{ #category : #accessing }
CstrAnd >> conjuncts [
	^ conjuncts
]

{ #category : #accessing }
CstrAnd >> conjuncts: anObject [
	conjuncts := anObject
]

{ #category : #'as yet unclassified' }
CstrAnd >> doElim: bss var: k [ 
	^CstrAnd of: (self conjuncts collect: [ :c | c doElim: bss var: k ])
]

{ #category : #logic }
CstrAnd >> flatConstraint [
	| flatConjuncts |
	flatConjuncts := self conjuncts flatConstraint.
	"special-case of singleton collection"
	flatConjuncts size = 1 ifTrue: [ ^flatConjuncts anyOne ].
	^CstrAnd of: flatConjuncts
]

{ #category : #'as yet unclassified' }
CstrAnd >> goS1: kve _: env _: aSortedReft _: be [
	| cs be1_subcss |
	cs := self conjuncts.
	be1_subcss := cs colject: be into: [ :beSoFar :conjunct | conjunct goS1: kve _: env _: aSortedReft _: beSoFar ].
	^be1_subcss key -> be1_subcss value flattened
]

{ #category : #'as yet unclassified' }
CstrAnd >> goScope: k [
	| scopes rights |
	scopes := self conjuncts collect: [ :c | c goScope: k ].
	rights := scopes select: #isRight.
	rights isEmpty ifTrue: [ ^Either left: #l ]. "if kvar doesn't appear, then just return the left"
	rights size = 1 ifTrue: [ ^rights first ]. "if kvar appears in one child, that is the lca"
 ^Either right: self "but if kvar appear in multiple chlidren, this is the lca"
]

{ #category : #logic }
CstrAnd >> isNNF [ 
	^ self conjuncts allSatisfy: [ :conjunct | conjunct isNNF ]
]

{ #category : #printing }
CstrAnd >> printMeatOn: aStream [
	aStream nextPutAll: '(and'.
	self conjuncts do: [ :c1 |
		aStream nextPut: $ .
		c1 printOn: aStream ].
	aStream nextPutAll: ')'
]
