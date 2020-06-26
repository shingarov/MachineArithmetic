Extension { #name : #Collection }

{ #category : #'*MachineArithmetic' }
Collection >> inEnvironment: env [
	^self collect: [ :anElement | anElement inEnvironment: env ]
]

{ #category : #'*MachineArithmetic' }
Collection >> withoutNils [
	^self reject: [ :x | x isNil ]
]
