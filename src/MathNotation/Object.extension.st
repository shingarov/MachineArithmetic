Extension { #name : #Object }

{ #category : #'*MathNotation' }
Object >> ∈ [ aCollection
	^aCollection includes: self
]

{ #category : #'*MathNotation' }
Object >> ∉ [ aCollection
	^(self ∈ aCollection) not
]

{ #category : #'*MathNotation' }
Object >> ∘ [ f
	"Compose 'self before f', in the left-to-right order
	 like in P.M.Cohn's 'Universal Algebra' and opposite 
	 to the 'self after f' right-to-left order in most
	 modern category-theory books."
	^f value: self
]

{ #category : #'*MathNotation' }
Object >> ≅ [ anObject
	^self = anObject
]

{ #category : #'*MathNotation' }
Object >> ⊛ [ Fa
	^Fa collect: self
]

{ #category : #'*MathNotation' }
Object >> ⨰ [ rhs
	^(Product with: self) ⨰ rhs
]
