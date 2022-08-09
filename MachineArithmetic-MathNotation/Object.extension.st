Extension { #name : #Object }

{ #category : #'*MachineArithmetic-MathNotation' }
Object >> ∈ [ aCollection
	^aCollection includes: self
]

{ #category : #'*MachineArithmetic-MathNotation' }
Object >> ≅ [ anObject
	^self = anObject
]
