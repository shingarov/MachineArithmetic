Extension { #name : #SpriteDecl }

{ #category : #'*Metalanguage' }
SpriteDecl >> toANF [
	^SpriteDecl
		bind: bind
		expr: expr toANF
]

{ #category : #'*Metalanguage' }
SpriteDecl >> toMIF [
	^self class
		bind: bind
		expr: expr toMIF
]
