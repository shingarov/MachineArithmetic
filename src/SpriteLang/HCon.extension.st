Extension { #name : #HCon }

{ #category : #'*SpriteLang' }
HCon class >> papp: n [
	| pred fAbs |
	pred := FFunc predicateTaking: n.
	fAbs := (n-1 to: 0 by: -1)
		inject: pred
		into: [ :soFar :j | soFar@j ].
	^HCon
		symbol: 'papp', n printString
		sort: fAbs
]
