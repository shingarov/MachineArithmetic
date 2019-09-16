Extension { #name : #Integer }

{ #category : #'*MachineArithmetic' }
Integer >> asBitVector: length [
	^IntValue value: self length: length


]

{ #category : #'*MachineArithmetic' }
Integer >> ones [
	^-1 asBitVector: self


]

{ #category : #'*MachineArithmetic' }
Integer >> representSmalltalkInPython [
	^self printString
]

{ #category : #'*MachineArithmetic' }
Integer >> zeros [
	^0 asBitVector: self


]
