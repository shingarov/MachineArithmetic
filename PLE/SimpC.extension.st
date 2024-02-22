Extension { #name : #SimpC }

{ #category : #'*PLE' }
SimpC >> cBinds [
	"Inner function in mkCTrie."
	^self senv elemsIBindEnv sorted
]
