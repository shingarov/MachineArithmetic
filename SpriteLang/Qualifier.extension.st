Extension { #name : #Qualifier }

{ #category : #'*SpriteLang' }
Qualifier class >> pappQual: n [
	| xs  params xValues body |
	xs := (0 to: n-2) collect: [ :k | QualParam
			symbol: 'x', k printString
			sort: k toFVar ].
	params := { QualParam symbol: 'VV' sort: (FVar new: n-1) },
	          xs,
	          { QualParam symbol: 'p' sort: (FApp predDomainTaking: n) }.
	xValues := (1 to: n-1) collect: [ :i | ' value: x', (i-1) printString ].
	xValues := String withAll: xValues concat.
	body := DecidableRefinement text: 'papp', n printString, ' value: p', xValues, ' value: VV' .
	^self
		name: 'PApp', n printString
		params: params
		body: body
]
