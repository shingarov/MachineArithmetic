Extension { #name : #Class }

{ #category : #'*MachineArithmetic-Syntax' }
Class >> parser [
	^PPChoiceParser withAll: (self subclasses collect: #parser)
]
