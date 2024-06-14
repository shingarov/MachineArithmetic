Extension { #name : #PPParser }

{ #category : #'*SpriteLang' }
PPParser >> annotationBrackets [
	^ ('/*@' asParser trim, self, '*/' asParser trim) ==> [ :x | x second ]
]
