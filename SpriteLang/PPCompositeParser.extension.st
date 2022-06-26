Extension { #name : #PPCompositeParser }

{ #category : #'*SpriteLang' }
PPCompositeParser >> tvar [
	^ $' asParser, self lowerId
	==> [ :x | TVar symbol: x second ]
]
