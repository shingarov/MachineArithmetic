Extension { #name : #ECase }

{ #category : #'*Metalanguage' }
ECase >> macroExpandEVar: f to: aΛExpr [
	^ECase
		x: (x macroExpandEVar: f to: aΛExpr)
		alts: (alts collect: [ :alt | Alt daCon: alt daCon binds: alt binds expr: (alt expr macroExpandEVar: f to: aΛExpr) ])
]

{ #category : #'*Metalanguage' }
ECase >> toANF [
	^ ECase 
		x: x
		alts: (alts collect: #toANF)
]

{ #category : #'*Metalanguage' }
ECase >> toMIF [
	"Sigh, x in Sprite is string! Not EImm, not EVar, but plain string..."

	x isString ifTrue:[
		^ ECase 
			x: x
			alts: (alts collect: #toMIF)
	].
	(x isKindOf: EVar) ifTrue:[
		^ ECase 
			x: x sym
			alts: (alts collect: #toMIF)
	].

	^ x mifCase: alts
]
