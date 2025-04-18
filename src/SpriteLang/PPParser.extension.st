Extension { #name : #PPParser }

{ #category : #'*SpriteLang' }
PPParser >> annotationBrackets [
	^Character leftDoubleBracket asParser trim, self, Character rightDoubleBracket asParser trim
	==> [ :x | x second ]
]
