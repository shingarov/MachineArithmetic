Extension { #name : #TFun }

{ #category : #'*SpriteLang-DUI' }
TFun >> unparseSprite [
	^x,
	 ':',
	 s unparseSprite,
	 ' => ',
	 t unparseSprite
]
