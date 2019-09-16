Extension { #name : #ByteArray }

{ #category : #'*MachineArithmetic' }
ByteArray >> representSmalltalkInPython [
	| var |
	var := ExternalVar new.
	P sendObject: self andAssignTo: var name.
	^ 'bytes(bytearray(', var ref, '))'
]
