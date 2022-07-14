Extension { #name : #RefinementParser }

{ #category : #'*SpriteLang' }
RefinementParser >> tvar [
	^ $' asParser, self lowerId
	==> [ :x | TVar symbol: x second ]
]
