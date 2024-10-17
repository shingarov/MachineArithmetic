Extension { #name : #DecidableRefinement }

{ #category : #'*Refinements-Parsing' }
DecidableRefinement class >> parser [
	^ RefinementExpressionParser new
	==> [ :x | self text: x formattedCode ]
]
