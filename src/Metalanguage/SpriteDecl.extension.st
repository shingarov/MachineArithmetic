Extension { #name : #SpriteDecl }

{ #category : #'*Metalanguage' }
SpriteDecl >> inlineInto: e [
	"Inline exactly the non-recursive Refls"
	((expr isKindOf: EAnn) and: [expr ann isKindOf: Refl]) ifFalse: [ ^ELet decl: (self class bind: bind expr: expr inlineNonRecursiveReflects) expr: e inlineNonRecursiveReflects ].
	^(e
		macroExpandEVar: bind id
		to: expr expr) inlineNonRecursiveReflects
]

{ #category : #'*Metalanguage' }
SpriteDecl >> macroExpandEVar: x to: aΛExpr [
	^self class
		bind: bind
		expr: (expr macroExpandEVar: x to: aΛExpr)
]

{ #category : #'*Metalanguage' }
SpriteDecl >> toANF [
	^self class
		bind: bind
		expr: expr toANF
]

{ #category : #'*Metalanguage' }
SpriteDecl >> toMIF [
	^self class
		bind: bind
		expr: expr toMIF
]
