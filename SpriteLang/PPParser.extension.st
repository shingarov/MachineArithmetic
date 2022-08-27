Extension { #name : #PPParser }

{ #category : #'*SpriteLang' }
PPParser >> annotationBrackets [
	^Character leftDoubleBracket asParser, self, Character rightDoubleBracket asParser
	==> [ :x | x second ]
]
