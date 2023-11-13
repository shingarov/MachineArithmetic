Extension { #name : #Collection }

{ #category : #'*MathNotation' }
Collection >> ⊗ [ anotherCollection
	| answer |
	answer := OrderedCollection new.
	self do: [ :x |
		anotherCollection do: [ :y |
			answer add: {x . y} ] ].
	^answer
]
