Extension { #name : #False }

{ #category : #'*PreSmalltalks' }
False >> compareTo: rhs [
	^rhs ifTrue: [ -1 ] ifFalse: [ 0 ]
]
