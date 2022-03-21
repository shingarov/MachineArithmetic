Extension { #name : #PPParser }

{ #category : #'*SpriteLang' }
PPParser >> annotationBrackets [
	^('/*@' asParser, #space asParser plus, self, #space asParser plus, '*/' asParser) 
	==> [ :x | x third ]
]
