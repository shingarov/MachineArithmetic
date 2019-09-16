Extension { #name : #Dictionary }

{ #category : #'*MachineArithmetic' }
Dictionary >> representSmalltalkInPython [
	| r var |
	r := 'dict ( ', (GenericPyObject representNamedArgs: self), ' )'.
	var := P evalAndAssign: r.
	^var ref
]
