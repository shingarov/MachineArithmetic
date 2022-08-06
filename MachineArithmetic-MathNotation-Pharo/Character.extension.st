Extension { #name : #Character }

{ #category : #'*MachineArithmetic-MathNotation-Pharo' }
Character class >> nonAsciiSpecialCharacters [
	^String
		   with: self centeredDot
		   with: self divide
		   with: self plusOrMinus
		   with: self times
				with: self forall
				with: self exists
]

{ #category : #'*MachineArithmetic-MathNotation-Pharo' }
Character class >> specialCharacters [
	^ '+-/\*~<>=@,%|&?!' , self nonAsciiSpecialCharacters
]
