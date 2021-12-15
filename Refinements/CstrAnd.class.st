Class {
	#name : #CstrAnd,
	#superclass : #HCstr,
	#instVars : [
		'conjuncts'
	],
	#category : #Refinements
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

{ #category : #GT }
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

{ #category : #logic }
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

{ #category : #logic }
CstrAnd >> goS1: kve _: env _: aSortedReft _: be [
	| cs be1_subcss |
	cs := self conjuncts.
	be1_subcss := cs colject: be into: [ :beSoFar :conjunct | conjunct goS1: kve _: env _: aSortedReft _: beSoFar ].
	^be1_subcss key -> be1_subcss value flattened
]

{ #category : #logic }
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
	aStream nextPutAll: '&('.
	self conjuncts
		do: [ :conj | aStream nextPut: Character centeredDot ]
		separatedBy: [ aStream nextPut: Character space ].
		aStream nextPutAll: ')'
]

{ #category : #logic }
CstrAnd >> pruneTauts [
	| simplifiedConjuncts |
	simplifiedConjuncts := conjuncts
		collect:    [ :c | c simplify ]
		thenReject: [ :c | c isTauto  ].
	simplifiedConjuncts size = 1 ifTrue: [ ^simplifiedConjuncts anyOne ].
	^CstrAnd of: simplifiedConjuncts
]

{ #category : #'term rewriting' }
CstrAnd >> rename: x to: y renamer: α [ 
	^CstrAnd of: (conjuncts collect: [ :c | c rename: x to: y renamer: α ])
]

{ #category : #logic }
CstrAnd >> sol1: k [
	^self conjuncts collectAndCat: [ :c | c sol1: k ]
]

{ #category : #logic }
CstrAnd >> uniq1: α [
	^CstrAnd of: (conjuncts collect: [ :c | c uniq1: α ])
]
