Extension { #name : #Collection }

{ #category : #'*MachineArithmetic-MathNotation' }
Collection >> ⊗ [ anotherCollection
	| answer |
	answer := OrderedCollection new.
	self do: [ :x |
		anotherCollection do: [ :y |
			answer add: {x . y} ] ].
	^answer
]
