Extension { #name : #McCarthyArray }

{ #category : #'*Refinements' }
McCarthyArray >> ∩ [ anotherSet
	^self intersection: anotherSet
]

{ #category : #'*Refinements' }
McCarthyArray >> ∪ [ anotherSet
	^self union: anotherSet
]

{ #category : #'*Refinements' }
McCarthyArray >> ⊆ [ anotherSet
	^self isSubsetOf: anotherSet
]
