Extension { #name : #Association }

{ #category : #'*Z3' }
Association >> toZ3ParameterSet [
	| params |
	params := Z3ParameterSet new.
	self value isString ifTrue: [ ^params at: self key putString: self value ].
	self value isInteger ifTrue: [ ^params at: self key putUint: self value ].
	(self value isKindOf: Boolean) ifTrue: [ ^params at: self key putBoolean: self value ].
	self shouldBeImplemented 
]
