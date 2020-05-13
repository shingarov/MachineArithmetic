Extension { #name : #Integer }

{ #category : #'*MachineArithmetic' }
Integer >> asBitVector: length [
	^BitVector value: self length: length
]

{ #category : #'*MachineArithmetic' }
Integer >> ones [
	^-1 asBitVector: self
]

{ #category : #'*MachineArithmetic' }
Integer >> toInt [
	^Z3Context current mkInt: self
]

{ #category : #'*MachineArithmetic' }
Integer >> zeros [
	^0 asBitVector: self
]
