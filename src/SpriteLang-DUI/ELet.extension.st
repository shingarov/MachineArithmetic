Extension { #name : #ELet }

{ #category : #'*SpriteLang-DUI' }
ELet >> unparseSprite [
	^(decl expr isKindOf: EAnn)
		ifTrue: [ self unparseSpriteAnnotated ]
		ifFalse: [ self unparseSpriteUnannotated ]
]

{ #category : #'*SpriteLang-DUI' }
ELet >> unparseSpriteAnnotated [
	"
	⟦val x : t⟧  ← ann
	let x = a;
	b
	"
	| ann x a b |
	ann := decl expr ann.
	x := ann symbol. self assert: x = decl bind id.
	a := decl expr expr.
	b := expr.
	^ann unparseSprite, String crlf,
	 'let ',
	 decl unparseSprite,
	 ';', String crlf,
	 expr unparseSprite
]

{ #category : #'*SpriteLang-DUI' }
ELet >> unparseSpriteUnannotated [
	"
	let x = a;
	b
	"
	| x a b |
	x := decl bind id.
	a := decl expr.
	b := expr.
	^'let ',
	 x,
	 ' = ',
	 a unparseSprite,
	 ';', String crlf,
	 b unparseSprite
]
