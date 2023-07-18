Extension { #name : #Integer }

{ #category : #'*PreSmalltalks' }
Integer >> asExternalAddress [
	^ExternalAddress fromAddress: self

]

{ #category : #'*PreSmalltalks' }
Integer class >> fresh [
	| cell n |
	cell := Context readState: #incrementer.
	n := cell first.
	cell at: 1 put: n+1.
	^n
]

{ #category : #'*PreSmalltalks' }
Integer >> printSubscipt [
	^self printString collect: [ :c | Character codePoint: c codePoint + 16r2050 ]
]
