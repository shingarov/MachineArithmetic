Extension { #name : #PPParser }

{ #category : #'*SpriteLang' }
PPParser >> annotationBrackets [
	^((Character leftDoubleBracket asParser,
		self,
			Character rightDoubleBracket asParser)
	/ ('/*@' asParser trim,
		self,
			'*/' asParser trim))
	==> [ :x | x second ]
]
