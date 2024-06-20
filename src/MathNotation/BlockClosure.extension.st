Extension { #name : #BlockClosure }

{ #category : #'*MathNotation' }
BlockClosure >> ⋅ [ thenBlock
	"Answer the block that is the composition of self, then thenBlock.
	 I.e. f⋅g means f, then g.
	 In other words: 'thenBlock after self'. "
	^[ :x | thenBlock value: (self value: x) ]
]
