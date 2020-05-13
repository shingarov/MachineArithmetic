Extension { #name : #Collection }

{ #category : #'*MachineArithmetic' }
Collection >> withoutNils [
	^self reject: [ :x | x isNil ]
]
