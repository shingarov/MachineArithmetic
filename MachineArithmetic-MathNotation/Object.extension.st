Extension { #name : #Object }

{ #category : #'*MachineArithmetic-MathNotation' }
Object >> ∈ [ aCollection
	^aCollection includes: self
]

{ #category : #'*MachineArithmetic-MathNotation' }
Object >> ∘ [ f
	"Compose 'self before f', in the left-to-right order
	 like in P.M.Cohn's 'Universal Algebra' and opposite 
	 to the 'self after f' right-to-left order in most
	 modern category-theory books."
	^f value: self
]

{ #category : #'*MachineArithmetic-MathNotation' }
Object >> ≅ [ anObject
	^self = anObject
]

{ #category : #'*MachineArithmetic-MathNotation' }
Object >> ⊛ [ Fa
	^Fa collect: self
]
