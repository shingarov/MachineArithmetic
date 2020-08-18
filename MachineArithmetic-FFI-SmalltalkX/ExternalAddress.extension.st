Extension { #name : #ExternalAddress }

{ #category : #'*MachineArithmetic-FFI-SmalltalkX' }
ExternalAddress class >> newPoison [
	"Return an ExternalAddress representing a 'poison address', i.e.,
	 address that is invalid. Used to debug use-after-free errors."
	
	^self fromAddress: 16rBAD00BAD
	
]
