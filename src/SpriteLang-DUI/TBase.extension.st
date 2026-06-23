Extension { #name : #TBase }

{ #category : #'*SpriteLang-DUI' }
TBase >> unparseSprite [
	^b unparseSprite,
	 ' [',
	 r unparseSprite,
	 ']'
]
