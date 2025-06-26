Extension { #name : #Int }

{ #category : #'*Z3-Tests' }
Int >> equals: rhs modulo: m [
	^self - rhs \\ m === 0 toInt
]

{ #category : #'*Z3-Tests' }
Int >> factorial [
	^Z3FactorialTest factorial value: self
]
