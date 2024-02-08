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
	"Compose 'self after f' in dextrosinistral order,
	 following the notation in most modern category-theory books."
	^f ⋅ self
]

{ #category : #'*MathNotation' }
Object >> ∷ [ type
	^TypingJudgement term: self hasType: type

	"
	| a |

	a := 1.
	a ∷ Int
	"

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
Object >> ⋅ [ f
	"Compose 'self before f' in sinistrodextral order
	 (like in P.M.Cohn's 'Universal Algebra')."
	^f value: self
]

{ #category : #'*MathNotation' }
Object >> ⨰ [ rhs
	^(Product with: self) ⨰ rhs
]
