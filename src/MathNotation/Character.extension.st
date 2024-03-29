Extension { #name : #Character }

{ #category : #'*MathNotation' }
Character class >> Alpha [
	^self codePoint: 16r0391
]

{ #category : #'*MathNotation' }
Character class >> Beta [
	^self codePoint: 16r0392
]

{ #category : #'*MathNotation' }
Character class >> Chi [
	^self codePoint: 16r03A7
]

{ #category : #'*MathNotation' }
Character class >> Delta [
	^self codePoint: 16r0394
]

{ #category : #'*MathNotation' }
Character class >> Epsilon [
	^self codePoint: 16r0395
]

{ #category : #'*MathNotation' }
Character class >> Eta [
	^self codePoint: 16r0397
]

{ #category : #'*MathNotation' }
Character class >> Gamma [
	^self codePoint: 16r0393
]

{ #category : #'*MathNotation' }
Character class >> Iota [
	^self codePoint: 16r0399
]

{ #category : #'*MathNotation' }
Character class >> Kappa [
	^self codePoint: 16r039A
]

{ #category : #'*MathNotation' }
Character class >> Lambda [
	^self codePoint: 16r039B
]

{ #category : #'*MathNotation' }
Character class >> Mu [
	^self codePoint: 16r039C
]

{ #category : #'*MathNotation' }
Character class >> Nu [
	^self codePoint: 16r039D
]

{ #category : #'*MathNotation' }
Character class >> Omega [
	^self codePoint: 16r03A9
]

{ #category : #'*MathNotation' }
Character class >> Omicron [
	^self codePoint: 16r039F
]

{ #category : #'*MathNotation' }
Character class >> Phi [
	^self codePoint: 16r03A6
]

{ #category : #'*MathNotation' }
Character class >> Pi [
	^self codePoint: 16r03A0
]

{ #category : #'*MathNotation' }
Character class >> Psi [
	^self codePoint: 16r03A8
]

{ #category : #'*MathNotation' }
Character class >> Rho [
	^self codePoint: 16r03A1
]

{ #category : #'*MathNotation' }
Character class >> Sigma [
	^self codePoint: 16r03A3
]

{ #category : #'*MathNotation' }
Character class >> Tau [
	^self codePoint: 16r03A4
]

{ #category : #'*MathNotation' }
Character class >> Theta [
	^self codePoint: 16r0398
]

{ #category : #'*MathNotation' }
Character class >> Upsilon [
	^self codePoint: 16r03A5
]

{ #category : #'*MathNotation' }
Character class >> Xi [
	^self codePoint: 16r039E
]

{ #category : #'*MathNotation' }
Character class >> Zeta [
	^self codePoint: 16r0396
]

{ #category : #'*MathNotation' }
Character class >> alpha [
	^self codePoint: 16r03B1
]

{ #category : #'*MathNotation' }
Character class >> ballotBox [
	^self codePoint: 16r2610
]

{ #category : #'*MathNotation' }
Character class >> beta [
	^self codePoint: 16r03B2
]

{ #category : #'*MathNotation' }
Character class >> brokenBar [
	^self codePoint: 16rA6
]

{ #category : #'*MathNotation' }
Character class >> centSign [
	^self codePoint: 16rA2
]

{ #category : #'*MathNotation' }
Character class >> containsAsNormalSubgroup [
	^self codePoint: 16r22B3
]

{ #category : #'*MathNotation' }
Character class >> copyrightSign [
	^self codePoint: 16rA9
]

{ #category : #'*MathNotation' }
Character class >> currencySign [
	^self codePoint: 16rA4
]

{ #category : #'*MathNotation' }
Character class >> degreeSign [
	^self codePoint: 16rB0
]

{ #category : #'*MathNotation' }
Character class >> delta [
	^self codePoint: 16r03B4
]

{ #category : #'*MathNotation' }
Character class >> diaeresis [
	^self codePoint: 16rA8
]

{ #category : #'*MathNotation' }
Character class >> directSum [
	^self codePoint: 16r2295
]

{ #category : #'*MathNotation' }
Character class >> divisionSign [
	^self codePoint: 16rF7
]

{ #category : #'*MathNotation' }
Character class >> emptySet [
	^self codePoint: 16r2205
]

{ #category : #'*MathNotation' }
Character class >> epsilon [
	^self codePoint: 16r03B5
]

{ #category : #'*MathNotation' }
Character class >> eta [
	^self codePoint: 16r03B7
]

{ #category : #'*MathNotation' }
Character class >> exists [
	^self codePoint: 16r2203
]

{ #category : #'*MathNotation' }
Character class >> feminineOrdinalIndicator [
	^self codePoint: 16rAA
]

{ #category : #'*MathNotation' }
Character class >> forall [
	^self codePoint: 16r2200
]

{ #category : #'*MathNotation' }
Character class >> gamma [
	^self codePoint: 16r03B3
]

{ #category : #'*MathNotation' }
Character class >> invertedExclamationMark [
	^self codePoint: 16rA1
]

{ #category : #'*MathNotation' }
Character class >> invertedQuestionMark [
	^self codePoint: 16rBF
]

{ #category : #'*MathNotation' }
Character class >> iota [
	^self codePoint: 16r03B9
]

{ #category : #'*MathNotation' }
Character >> isLetter [
	"Return whether the receiver is a letter."
	"$a isLetter >>> true"
	"$é isLetter >>> true"
	"$A isLetter >>> true"

	^self isWeirdLetter or: [ self characterSet isLetter: self ]

]

{ #category : #'*MathNotation' }
Character >> isWeirdLetter [
	^self class weirdLetterCodepoints includes: self charCode
]

{ #category : #'*MathNotation' }
Character class >> isomorphicTo [
	^self codePoint: 16r2245
]

{ #category : #'*MathNotation' }
Character class >> kappa [
	^self codePoint: 16r03BA
]

{ #category : #'*MathNotation' }
Character class >> lambda [
	^self codePoint: 16r03BB
]

{ #category : #'*MathNotation' }
Character class >> leftDoubleBracket [
	^self codePoint: 16r27E6
]

{ #category : #'*MathNotation' }
Character class >> leftPointingDoubleAngleQuotationMark [
	^self codePoint: 16rAB
]

{ #category : #'*MathNotation' }
Character class >> macron [
	^self codePoint: 16rAF
]

{ #category : #'*MathNotation' }
Character class >> masculineOrdinalIndicator [
	^self codePoint: 16rBA
]

{ #category : #'*MathNotation' }
Character class >> microSign [
	^self codePoint: 16rB5
]

{ #category : #'*MathNotation' }
Character class >> mu [
	^self codePoint: 16r03BC
]

{ #category : #'*MathNotation' }
Character class >> multiplicationSign [
	^self codePoint: 16rD7
]

{ #category : #'*MathNotation' }
Character class >> normalSubgroupOf [
	^self codePoint: 16r22B2
]

{ #category : #'*MathNotation' }
Character class >> notSign [
	^self codePoint: 16rAC
]

{ #category : #'*MathNotation' }
Character class >> nu [
	^self codePoint: 16r03BD
]

{ #category : #'*MathNotation' }
Character class >> omega [
	^self codePoint: 16r03B9
]

{ #category : #'*MathNotation' }
Character class >> omicron [
	^self codePoint: 16r03BF
]

{ #category : #'*MathNotation' }
Character class >> oneHalf [
	^self codePoint: 16rBD
]

{ #category : #'*MathNotation' }
Character class >> oneQuarter [
	^self codePoint: 16rBC
]

{ #category : #'*MathNotation' }
Character class >> phi [
	^self codePoint: 16r03C6
]

{ #category : #'*MathNotation' }
Character class >> pi [
	^self codePoint: 16r03C0
]

{ #category : #'*MathNotation' }
Character class >> pilcrowSign [
	^self codePoint: 16rB6
]

{ #category : #'*MathNotation' }
Character class >> plusMinusSign [
	^self codePoint: 16rB1
]

{ #category : #'*MathNotation' }
Character class >> poundSign [
	^self codePoint: 16rA3
]

{ #category : #'*MathNotation' }
Character class >> psi [
	^self codePoint: 16r03C8
]

{ #category : #'*MathNotation' }
Character class >> reals [
	^self codePoint: 16r211D
]

{ #category : #'*MathNotation' }
Character class >> registeredSign [
	^self codePoint: 16rAE
]

{ #category : #'*MathNotation' }
Character class >> replacementCharacter [
	"Used to represent unknown/unrecognized/unrepresentable data in Unicode 3.0.
	 Often displayed as a black rhombus with a white question mark."
	^self codePoint: 16rFFFD
]

{ #category : #'*MathNotation' }
Character class >> rho [
	^self codePoint: 16r03C1
]

{ #category : #'*MathNotation' }
Character class >> rightDoubleBracket [
	^self codePoint: 16r27E7
]

{ #category : #'*MathNotation' }
Character class >> rightPointingDoubleAngleQuotationMark [
	^self codePoint: 16rBB
]

{ #category : #'*MathNotation' }
Character class >> ringOperator [
	^self codePoint: 16r2218
]

{ #category : #'*MathNotation' }
Character class >> sectionSign [
	^self codePoint: 16rA7
]

{ #category : #'*MathNotation' }
Character class >> sigma [
	^self codePoint: 16r03C3
]

{ #category : #'*MathNotation' }
Character class >> softHyphen [
	^self codePoint: 16rAD
]

{ #category : #'*MathNotation' }
Character class >> starOperator [
	^self codePoint: 16r22C6
]

{ #category : #'*MathNotation' }
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

{ #category : #'*MathNotation' }
Character class >> tau [
	^self codePoint: 16r03C4
]

{ #category : #'*MathNotation' }
Character class >> theta [
	^self codePoint: 16r03B8
]

{ #category : #'*MathNotation' }
Character class >> threeQuarters [
	^self codePoint: 16rBE
]

{ #category : #'*MathNotation' }
Character class >> upsilon [
	^self codePoint: 16r03C5
]

{ #category : #'*MathNotation' }
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

{ #category : #'*MathNotation' }
Character class >> xi [
	^self codePoint: 16r03BE
]

{ #category : #'*MathNotation' }
Character class >> yenSign [
	^self codePoint: 16rA5
]

{ #category : #'*MathNotation' }
Character class >> zahlen [
	^self codePoint: 16r2124
]

{ #category : #'*MathNotation' }
Character class >> zeta [
	^self codePoint: 16r03B6
]
