Extension { #name : #BlockClosure }

{ #category : #'*PreSmalltalks' }
BlockClosure >> * thenBlock [
	"Answer the block that is the composition of self, then thenBlock.
	 I.e. f*g means f, then g."
	^[ :x | thenBlock value: (self value: x) ]
]

{ #category : #'*PreSmalltalks' }
BlockClosure >> S [
	^[ :y :z | (self value: z) value: (y value: z) ]
]

{ #category : #'*PreSmalltalks' }
BlockClosure >> argumentName [
	self argumentCount = 1 ifFalse: [ self error ].
	^self argumentNames first
]

{ #category : #'*PreSmalltalks' }
BlockClosure class >> id [
	"The I combinator."
	^[ :x | x ]
]
