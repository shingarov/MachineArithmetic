Extension { #name : #SimpleZ3Test }

{ #category : #'*Refinements-Tests' }
SimpleZ3Test >> testCoerceEVar [
	| result |
	result := 3 toInt + (EVar of: 'four').
	self assert: result sort equals: Int sort.
	self assert: result e bop equals: #+
]

{ #category : #'*Refinements-Tests' }
SimpleZ3Test >> testFuncSort [
	self
		assert: (Int sort ⇴ Int sort) printString
		equals: 'ℤ⇴ℤ'
]
