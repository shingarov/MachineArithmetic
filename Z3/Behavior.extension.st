Extension { #name : #Behavior }

{ #category : #'*Z3' }
Behavior >> id: anObject [
	"Answer anObject.
	
	anObject is known to be a kind of the receiver;
	signal error if this is discovered to be not so."
	
	(anObject isKindOf: self) ifFalse: [ self error ].

	^ anObject
]
