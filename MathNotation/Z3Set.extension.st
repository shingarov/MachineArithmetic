Extension { #name : #Z3Set }

{ #category : #'*MathNotation' }
Z3Set >> ∩ [ anotherSet
	^self intersection: anotherSet
]

{ #category : #'*MathNotation' }
Z3Set >> ∪ [ anotherSet
	^self union: anotherSet
]

{ #category : #'*MathNotation' }
Z3Set >> ⊆ [ anotherSet
	^self isSubsetOf: anotherSet
]

{ #category : #'*MathNotation' }
Z3Set >> ⊖ [ anotherSet
	"Symmetric difference, acting as the additive operation of the Boolean ring
	 (#∩ being its multiplicative operation.)"
	^(self\anotherSet) ∪ (anotherSet\self)
]
