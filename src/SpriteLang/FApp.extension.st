Extension { #name : #FApp }

{ #category : #'*SpriteLang' }
FApp >> constTyApp: value [
	| v |
	v := 'theoryFunctionV'.
	^self refinedBy: (Reft
			symbol: v
			expr: (PAtom brel: #=== x: (EVar of: v) y: value)) known
]

{ #category : #'*SpriteLang' }
FApp >> refinedBy: r [
	^TCon
		c: s typeConstructor symbol
		ts: {t sort2bTrue}
		ars: #()
		r: r
]

{ #category : #'*SpriteLang' }
FApp >> sort2bTrue [
	^self refinedBy: Reft trueReft known
]
