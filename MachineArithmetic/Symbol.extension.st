Extension { #name : #Symbol }

{ #category : #'*MachineArithmetic' }
Symbol >> z3likeSelector [
	self isBinary ifTrue: [ ^self shouldBeImplemented ].
	self isUnary ifTrue: [ ^self ].
	^(self separateKeywords findTokens: $ ) first allButLast
]
