Extension { #name : #SpriteDecl }

{ #category : #'*Metalanguage' }
SpriteDecl >> macroExpandEVar: x to: aΛExpr [
	^self class
		bind: bind
		expr: (expr macroExpandEVar: x to: aΛExpr)
]

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
