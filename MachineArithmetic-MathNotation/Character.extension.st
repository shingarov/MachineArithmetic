Extension { #name : #Character }

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> brokenBar [
	^self codePoint: 16rA6
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> centSign [
	^self codePoint: 16rA2
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> copyrightSign [
	^self codePoint: 16rA9
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> currencySign [
	^self codePoint: 16rA4
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> degreeSign [
	^self codePoint: 16rB0
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> diaeresis [
	^self codePoint: 16rA8
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> divisionSign [
	^self codePoint: 16rF7
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> exists [
	^self codePoint: 16r2203
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> feminineOrdinalIndicator [
	^self codePoint: 16rAA
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> forall [
	^self codePoint: 16r2200
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> invertedExclamationMark [
	^self codePoint: 16rA1
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> invertedQuestionMark [
	^self codePoint: 16rBF
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character >> isLetter [
	"Return whether the receiver is a letter."
	"$a isLetter >>> true"
	"$é isLetter >>> true"
	"$A isLetter >>> true"

	^self isWeirdLetter or: [ self characterSet isLetter: self ]

]

{ #category : #'*MachineArithmetic-MathNotation' }
Character >> isWeirdLetter [
	^self class weirdLetterCodepoints includes: self charCode
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> leftPointingDoubleAngleQuotationMark [
	^self codePoint: 16rAB
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> macron [
	^self codePoint: 16rAF
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> masculineOrdinalIndicator [
	^self codePoint: 16rBA
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> microSign [
	^self codePoint: 16rB5
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> multiplicationSign [
	^self codePoint: 16rD7
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> notSign [
	^self codePoint: 16rAC
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> oneHalf [
	^self codePoint: 16rBD
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> oneQuarter [
	^self codePoint: 16rBC
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> pilcrowSign [
	^self codePoint: 16rB6
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> plusMinusSign [
	^self codePoint: 16rB1
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> poundSign [
	^self codePoint: 16rA3
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> registeredSign [
	^self codePoint: 16rAE
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> rightPointingDoubleAngleQuotationMark [
	^self codePoint: 16rBB
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> sectionSign [
	^self codePoint: 16rA7
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> softHyphen [
	^self codePoint: 16rAD
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> superscriptOne [
	^self codePoint: 16rB9
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> superscriptThree [
	^self codePoint: 16rB3
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> superscriptTwo [
	^self codePoint: 16rB2
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> threeQuarters [
	^self codePoint: 16rBE
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> weirdLetterCodepoints [
	"We classify them as letters for the Smalltalk scanner, so they can be receivers,
	 and not binary selectors."
	^#(
	16r2124 "zahlen"
	16r2200 "ForAll"
	16r2203 "Exists"
	)
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> yenSign [
	^self codePoint: 16rA5
]

{ #category : #'*MachineArithmetic-MathNotation' }
Character class >> zahlen [
	^self codePoint: 16r2124
]
