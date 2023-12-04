Extension { #name : #Character }

{ #category : #'*MathNotation-Pharo' }
Character class >> nonAsciiSpecialCharacters [
	^'·÷±×∀∃⋆'
]

{ #category : #'*MathNotation-Pharo' }
Character class >> specialCharacters [
	^ '+-/\*~<>=@,%|&?!' , self nonAsciiSpecialCharacters
]
