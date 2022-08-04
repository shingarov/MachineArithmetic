Extension { #name : #Character }

{ #category : #'*MachineArithmetic-MathNotation-Pharo' }
Character class >> nonAsciiSpecialCharacters [
	^'·÷±×∀∃⋆'
]

{ #category : #'*MachineArithmetic-MathNotation-Pharo' }
Character class >> specialCharacters [
	^ '+-/\*~<>=@,%|&?!' , self nonAsciiSpecialCharacters
]
