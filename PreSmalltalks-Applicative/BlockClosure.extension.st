Extension { #name : #BlockClosure }

{ #category : #'*PreSmalltalks-Applicative' }
BlockClosure >> liftA2 [
	"Lift a two-argument block to actions."
	^[ :x :y | (x collect: self) <*> y ].
]
