Extension { #name : #Symbol }

{ #category : #'*Z3' }
Symbol >> z3likeSelector [
	self isBinary ifTrue: [ ^self shouldBeImplemented ].
	self isUnary ifTrue: [ ^self ].
	^self copyFrom: 1 to: (self indexOf: $:) - 1
]
