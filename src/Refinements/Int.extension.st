Extension { #name : #Int }

{ #category : #'*Refinements' }
Int >> nat [
	^self >= 0
]

{ #category : #'*Refinements' }
Int class >> tyCon [
	^FTyconInt new
]
