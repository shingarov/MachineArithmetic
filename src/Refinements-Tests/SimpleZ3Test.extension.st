Extension { #name : #SimpleZ3Test }

{ #category : #'*Refinements-Tests' }
SimpleZ3Test >> testFuncSort [
	self
		assert: (Int sort ⇴ Int sort) printString
		equals: 'ℤ⇴ℤ'
]
