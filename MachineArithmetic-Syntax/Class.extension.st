Extension { #name : #Class }

{ #category : #'*MachineArithmetic-Syntax' }
Class >> parse: source [
	^self parser parse: source
]

{ #category : #'*MachineArithmetic-Syntax' }
Class >> parser [
	^PPChoiceParser withAll: (self subclasses collect: #parser)
]
