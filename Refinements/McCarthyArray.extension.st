Extension { #name : #McCarthyArray }

{ #category : #'*Refinements' }
McCarthyArray >> ∩ [ anotherSet
	^self class mkSetIntersect: { self . anotherSet }
]

{ #category : #'*Refinements' }
McCarthyArray >> ∪ [ anotherSet
	^self class mkSetUnion: { self . anotherSet }
]

{ #category : #'*Refinements' }
McCarthyArray >> ⊆ [ anotherSet
	"Check for subsetness of sets."
	self ensureSet.
	anotherSet ensureSet.
	^Z3 mk_set_subset: ctx _: self _: anotherSet
]
