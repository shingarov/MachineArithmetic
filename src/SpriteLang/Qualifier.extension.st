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
	xValues := String withAll: xValues join.
	body := DecidableRefinement text: 'papp', n printString, ' value: p', xValues, ' value: VV' .
	^self
		name: 'PApp', n printString
		params: params
		body: body
]

{ #category : #'*SpriteLang' }
Qualifier >> spriteOn: aStream indent: ident [
	"
	ΛκParser >> #qualBody
	"
	aStream nextPutAll: '⟦qualif '.
	aStream nextPutAll: name.
	aStream nextPutAll: ' ('.
	params printOn: aStream delimiter: ', '.
	aStream nextPutAll: ') '.
	body printOn: aStream.
	aStream nextPutAll: '⟧'
]
