Extension { #name : #BlockClosure }

{ #category : #'*PreSmalltalks' }
BlockClosure >> S [
	^[ :y :z | (self value: z) value: (y value: z) ]
]
