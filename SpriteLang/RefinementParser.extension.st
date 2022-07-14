Extension { #name : #RefinementParser }

{ #category : #'*SpriteLang' }
RefinementParser >> annotationBrackets [
	^Character leftDoubleBracket asParser, self, Character rightDoubleBracket asParser
	==> [ :x | x second ]
]

{ #category : #'*SpriteLang' }
RefinementParser >> tvar [
	^ $' asParser, self lowerId
	==> [ :x | TVar symbol: x second ]
]
