Extension { #name : #EFun }

{ #category : #'*SpriteLang-DUI' }
EFun >> unparseSprite [
	^'(', bind id, ') => {', String crlf,
	 expr unparseSprite, String crlf,
	 '}'
]
