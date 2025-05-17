Extension { #name : #ELet }

{ #category : #'*Metalanguage' }
ELet >> toANF [
	"
	let x = (let y=a in b)
	in c
	
	is normalized to:
	
	let y=a
	in let x=b
	in c
	"
	| innerLet |
	innerLet := decl expr.
	(innerLet isKindOf: ELet) ifTrue: [
		^(ELet
			decl: innerLet decl toANF
			expr: (ELet
		         decl: (SpriteDecl bind: decl bind expr: innerLet expr)
		         expr: expr) toANF) toANF
	].
	(innerLet isKindOf: EIf) ifTrue: [
		^EIf
			cond: innerLet cond
			trueE:  (ELet decl: (SpriteDecl bind: decl bind expr: innerLet trueE)  expr: expr)
			falseE: (ELet decl: (SpriteDecl bind: decl bind expr: innerLet falseE) expr: expr)
	].
	^ELet
		decl: decl toANF
		expr: expr toANF
]

{ #category : #'*Metalanguage' }
ELet >> toMIF [
	^ELet
		decl: decl toMIF
		expr: expr toMIF
]
