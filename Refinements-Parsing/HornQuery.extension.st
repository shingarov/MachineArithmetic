Extension { #name : #HornQuery }

{ #category : #'*Refinements-Parsing' }
HornQuery class >> parser [
	^	HThing parser trim star end
		==> [ :x | HornQuery fromThings: x ]
]
