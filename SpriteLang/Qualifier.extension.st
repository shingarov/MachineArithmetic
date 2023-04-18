Extension { #name : #Qualifier }

{ #category : #'*SpriteLang' }
Qualifier class >> pappQual: n [
n=1 ifFalse: [ self shouldBeImplemented ].
	^self
		name: 'PApp', n printString
		params: {
				QualParam symbol: 'VV' sort: (FVar new: 0).
				QualParam symbol: 'p' sort: (FApp s: (FTC new: (FTycon symbol: 'Pred') ) t: (FVar new: 0))
		 }
		body: (DecidableRefinement text: 'papp1 value: p value: VV')
]
