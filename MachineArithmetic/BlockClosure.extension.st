Extension { #name : #BlockClosure }

{ #category : #'*MachineArithmetic' }
BlockClosure >> S [
	^[ :y :z | (self value: z) value: (y value: z) ]
]
