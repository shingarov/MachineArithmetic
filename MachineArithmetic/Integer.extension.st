Extension { #name : #Integer }

{ #category : #'*MachineArithmetic' }
Integer >> /// length [
	^self toBitVector: length
]

{ #category : #'*MachineArithmetic' }
Integer >> ones [
	^-1 toBitVector: self
]

{ #category : #'*MachineArithmetic' }
Integer >> toBitVector: length [
	^BitVector value: self length: length
]

{ #category : #'*MachineArithmetic' }
Integer >> toInt [
	^Z3Context current mkInt: self
]

{ #category : #'*MachineArithmetic' }
Integer >> zeros [
	^0 toBitVector: self
]
