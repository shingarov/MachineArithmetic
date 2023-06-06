Extension { #name : #McCarthyArray }

{ #category : #'*MachineArithmetic-MathNotation' }
McCarthyArray >> ∩ [ anotherSet
	^self intersection: anotherSet
]

{ #category : #'*MachineArithmetic-MathNotation' }
McCarthyArray >> ∪ [ anotherSet
	^self union: anotherSet
]

{ #category : #'*MachineArithmetic-MathNotation' }
McCarthyArray >> ⊆ [ anotherSet
	^self isSubsetOf: anotherSet
]
