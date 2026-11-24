Extension { #name : #SpriteRDecl }

{ #category : #'*Metalanguage' }
SpriteRDecl >> inlineInto: e [
	^ELet decl: self expr: e
]
