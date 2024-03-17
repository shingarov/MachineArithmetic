Extension { #name : #True }

{ #category : #'*PreSmalltalks' }
True >> compareTo: rhs [
	^rhs ifTrue: [ 0 ] ifFalse: [ 1 ]
]
