Extension { #name : #String }

{ #category : #'*MachineArithmetic' }
String >> asBitVector: width [
	^IntSymbol sym: self length: width
]
