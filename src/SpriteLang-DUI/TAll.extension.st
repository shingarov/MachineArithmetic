Extension { #name : #TAll }

{ #category : #'*SpriteLang-DUI' }
TAll >> unparseSprite [
	^'∀', var, '. ',
	type unparseSprite
]
