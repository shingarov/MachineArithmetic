Extension { #name : #Character }

{ #category : #'*MathNotation-Pharo' }
Character >> isLetter [
	"Return whether the receiver is a letter."
	"$a isLetter >>> true"
	"$é isLetter >>> true"
	"$A isLetter >>> true"

	^self isWeirdLetter or: [ self characterSet isLetter: self ]

]

{ #category : #'*MathNotation-Pharo' }
Character >> isWeirdLetter [
	^self class weirdLetterCodepoints includes: self charCode
]

{ #category : #'*MathNotation-Pharo' }
Character class >> nonAsciiSpecialCharacters [
	^'·÷±×∀∃⋆'
]

{ #category : #'*MathNotation-Pharo' }
Character class >> specialCharacters [
	^ '+-/\*~<>=@,%|&?!' , self nonAsciiSpecialCharacters
]

{ #category : #'*MathNotation-Pharo' }
Character class >> subscriptCodepoints [
	^#(
	16r2080 "SUBSCRIPT ZERO"
	16r2081 "SUBSCRIPT ONE"
	16r2082 "SUBSCRIPT TWO"
	16r2083 "SUBSCRIPT THREE"
	16r2084 "SUBSCRIPT FOUR"
	16r2085 "SUBSCRIPT FIVE"
	16r2086 "SUBSCRIPT SIX"
	16r2087 "SUBSCRIPT SEVEN"
	16r2088 "SUBSCRIPT EIGHT"
	16r2089 "SUBSCRIPT NINE"
	16r208A "SUBSCRIPT PLUS SIGN"
	16r208B "SUBSCRIPT MINUS"
	16r208C "SUBSCRIPT EQUALS SIGN"
	16r208D "SUBSCRIPT LEFT PARENTHESIS"
	16r208E "SUBSCRIPT RIGHT PARENTHESIS"
	16r2090 "LATIN SUBSCRIPT SMALL LETTER A"
	16r2091 "LATIN SUBSCRIPT SMALL LETTER E"
	16r2092 "LATIN SUBSCRIPT SMALL LETTER O"
	16r2093 "LATIN SUBSCRIPT SMALL LETTER X"
	16r2094 "LATIN SUBSCRIPT SMALL LETTER SCHWA"
	16r2095 "LATIN SUBSCRIPT SMALL LETTER H"
	16r2096 "LATIN SUBSCRIPT SMALL LETTER K"
	16r2097 "LATIN SUBSCRIPT SMALL LETTER L"
	16r2098 "LATIN SUBSCRIPT SMALL LETTER M"
	16r2099 "LATIN SUBSCRIPT SMALL LETTER N"
	16r209A "LATIN SUBSCRIPT SMALL LETTER P"
	16r209B "LATIN SUBSCRIPT SMALL LETTER S"
	16r209C "LATIN SUBSCRIPT SMALL LETTER T"
	)
	"The names on the right are what GNU Unistring thinks they are.
	 Fun exercise: manually clone
	    git@github.com:shingarov/pharo-gnu-unistring.git
	 and inspect
	    Character subscriptCodepoints collect: #asCharacter. 	"
]

{ #category : #'*MathNotation-Pharo' }
Character class >> weirdLetterCodepoints [
	"We classify them as letters for the Smalltalk scanner, so they can be receivers,
	 and not binary selectors."
	^#(
	16r2124 "Zahlen"
	16r211D "Real"
	16r2115 "Nat"
	16r2610 "Ballot box"
	16r2119 "Pred"
	16r2102 "Complex"
	16r211A "Rational"
	16r2107 "Euler constant"
	16r210F "Planck"
	
	16r2032 "Prime"
	), self subscriptCodepoints
]
