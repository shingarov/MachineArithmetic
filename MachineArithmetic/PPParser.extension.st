Extension { #name : #PPParser }

{ #category : #'*MachineArithmetic' }
PPParser >> parens [
	^$( asParser, self, $) asParser
	==> [ :x | x second ]
]
