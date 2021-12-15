Extension { #name : #PPParser }

{ #category : #'*Refinements' }
PPParser >> parens [
	^$( asParser, self, $) asParser
	==> [ :x | x second ]
]
