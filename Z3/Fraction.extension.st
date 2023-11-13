Extension { #name : #Fraction }

{ #category : #'*Z3' }
Fraction >> toInt [
	^ numerator toInt / denominator toInt
]

{ #category : #'*Z3' }
Fraction >> toReal [
	^ numerator toReal / denominator toReal
]
