Extension { #name : #EIf }

{ #category : #'*SpriteLang-DUI' }
EIf >> unparseSprite [
	^'if (', cond unparseSprite, ') {',
	trueE unparseSprite,
	'} else {',
	falseE unparseSprite,
	'}'
]
