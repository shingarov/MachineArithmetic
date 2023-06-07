Extension { #name : #Z3Set }

{ #category : #'*MachineArithmetic-MathNotation' }
Z3Set >> ∩ [ anotherSet
	^self intersection: anotherSet
]

{ #category : #'*MachineArithmetic-MathNotation' }
Z3Set >> ∪ [ anotherSet
	^self union: anotherSet
]

{ #category : #'*MachineArithmetic-MathNotation' }
Z3Set >> ⊆ [ anotherSet
	^self isSubsetOf: anotherSet
]
