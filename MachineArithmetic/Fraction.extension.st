Extension { #name : #Fraction }

{ #category : #'*MachineArithmetic' }
Fraction >> toInt [
	^ numerator toInt / denominator toInt
]

{ #category : #'*MachineArithmetic' }
Fraction >> toReal [
	^ numerator toReal / denominator toReal
]
