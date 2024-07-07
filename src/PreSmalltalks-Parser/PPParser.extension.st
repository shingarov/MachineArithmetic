Extension { #name : #PPParser }

{ #category : #'*PreSmalltalks-Parser' }
PPParser >> braces [
	^${ asParser trim, self, $} asParser trim
	==> #second
]

{ #category : #'*PreSmalltalks-Parser' }
PPParser >> brackets [
	^$[ asParser, self, $] asParser
	==> #second
]

{ #category : #'*PreSmalltalks-Parser' }
PPParser class >> cHexNumber [
	^ '0x' asParser
	, (#hex asParser plus flatten ==> [ :x | Integer readFrom: x base: 16 ])
	==> #second
]

{ #category : #'*PreSmalltalks-Parser' }
PPParser >> charSeparated: char [
	| delimiter |
	delimiter := Object new.
	^(self separatedBy: char asParser trim ==>[:_x|delimiter])
	==> [ :x | x reject: [ :tok | tok == delimiter ] ]
]

{ #category : #'*PreSmalltalks-Parser' }
PPParser >> commaList [
	^self commaSeparated parens
]

{ #category : #'*PreSmalltalks-Parser' }
PPParser >> commaSeparated [
	^self charSeparated: $,
]

{ #category : #'*PreSmalltalks-Parser' }
PPParser class >> decimalInteger [
	^#digit asParser plus flatten ==> #asInteger "BOGUS, need sign"
]

{ #category : #'*PreSmalltalks-Parser' }
PPParser class >> decimalNat [
	^#digit asParser plus flatten ==> #asInteger
]

{ #category : #'*PreSmalltalks-Parser' }
PPParser class >> nonBracket [
	^(PPPredicateObjectParser
		on: (PPCharSetPredicate on: [ :ch | ch ~~ $[ and: ch ~~ $] ])
		message: 'Nonparenthesis expected')
		
]

{ #category : #'*PreSmalltalks-Parser' }
PPParser class >> nonParen [
	^(PPPredicateObjectParser
		on: (PPCharSetPredicate on: [ :ch | ch ~~ $( and: ch ~~ $) ])
		message: 'Nonparenthesis expected')
		
]

{ #category : #'*PreSmalltalks-Parser' }
PPParser >> parens [
	"NB: () will parse to nil."
	^$( asParser, self optional, $) asParser
	==> #second
]

{ #category : #'*PreSmalltalks-Parser' }
PPParser >> semicolonSeparated [
	^self charSeparated: $;
]
