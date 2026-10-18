Extension { #name : #SpriteDecl }

{ #category : #'*SpriteLang-DUI' }
SpriteDecl >> unparseSprite [
	^bind id,
	 ' = ',
	 expr expr unparseSprite
]
