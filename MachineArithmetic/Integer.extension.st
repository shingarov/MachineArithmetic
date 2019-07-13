Extension { #name : #Integer }

{ #category : #'*MachineArithmetic' }
Integer >> asBitVector: length [
	^IntValue value: self length: length


]
