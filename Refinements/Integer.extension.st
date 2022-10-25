Extension { #name : #Integer }

{ #category : #'*Refinements' }
Integer >> toFVar [
	^FVar new: self
]

{ #category : #'*Refinements' }
Integer >> vv [ 
"Cf. Types/Names.hs
42 vv >>> 'VVºº42'
"
	^String vvName intSymbol: self
]
