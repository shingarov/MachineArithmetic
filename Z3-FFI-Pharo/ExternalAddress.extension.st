Extension { #name : #ExternalAddress }

{ #category : #'*Z3-FFI-Pharo' }
ExternalAddress class >> newPoison [
	"Return an ExternalAddress representing a 'poison address', i.e.,
	 address that is invalid. Used to debug use-after-free errors."
	
	"Keep the poison value sync with Z3Object >> #isPoisoned!"
	^self fromAddress: 16rBAD00BAD
	
]
