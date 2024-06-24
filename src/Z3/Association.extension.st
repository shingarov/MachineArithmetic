Extension { #name : #Association }

{ #category : #'*Z3' }
Association >> toZ3ParameterSet [
	^ Z3ParameterSet new
		at: key put: value;
		yourself
]
