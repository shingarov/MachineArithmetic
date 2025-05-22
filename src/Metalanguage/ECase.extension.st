Extension { #name : #ECase }

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
	] ifFalse:[
		^ x mifCase: alts
	]
]
