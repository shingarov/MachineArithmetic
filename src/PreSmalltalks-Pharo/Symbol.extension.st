Extension { #name : #Symbol }

{ #category : #'*PreSmalltalks-Pharo' }
Symbol >> valueWithArguments: args [
	args isEmpty ifTrue: [
		"If there is no object to serve as the receiver,
		 then this is like Object>>value, i.e. Lawvere's
		 'generalized element' (terminal stage of definition)."
		^self
	].
	^args first perform: self withArguments: args allButFirst
]
