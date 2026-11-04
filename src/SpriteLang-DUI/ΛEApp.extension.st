Extension { #name : #'ΛEApp' }

{ #category : #'*SpriteLang-DUI' }
ΛEApp >> unparseSprite [
	^expr unparseSprite,
	 '(',
	 imm unparseSprite,
	 ')'
]
