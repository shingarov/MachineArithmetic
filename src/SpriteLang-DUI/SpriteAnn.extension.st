Extension { #name : #SpriteAnn }

{ #category : #'*SpriteLang-DUI' }
SpriteAnn >> unparseSprite [
	^'⟦',
	 self spriteKeyword,
	 ' ',
	 symbol,
	 ' : ',
	 rtype unparseSprite,
	 '⟧'
]
