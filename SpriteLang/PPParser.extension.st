Extension { #name : #PPParser }

{ #category : #'*SpriteLang' }
PPParser >> annotationBrackets [
	^('/*@' asParser, #space asParser, self, '*/' asParser trim) 
	==> [ :x | x third ]
]
