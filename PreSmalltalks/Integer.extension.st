Extension { #name : #Integer }

{ #category : #'*PreSmalltalks' }
Integer >> asExternalAddress [
	^ExternalAddress fromAddress: self

]
