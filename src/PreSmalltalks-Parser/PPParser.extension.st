Extension { #name : #PPParser }

{ #category : #'*PreSmalltalks-Parser' }
PPParser class >> boolean [
	^ ('true'  asParser ==> [ true ])
	/ ('false' asParser ==> [ false ])
]

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
	^( $- asParser optional
	 , #digit asParser plus
	 ) flatten
	==> #asInteger
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
PPParser >> pair: rhsP separatedBy: sepP [
"
pairP :: Parser a -> Parser z -> Parser b -> Parser (a, b)

E.g.
(PPParser decimalNat pair: PPParser boolean separatedBy: $; asParser) parse: '100;true'
parses to 100->true
"
.

	^self, sepP, rhsP
	==> [ :x | x first -> x last ]
]

{ #category : #'*PreSmalltalks-Parser' }
PPParser >> pairs: rhsP [
"
pairsP :: Parser a -> Parser b -> Parser [(a, b)]

E.g.
(PPParser decimalNat pairs: PPParser boolean) parse: '[1 : true]'
parses to {1->true};
(PPParser decimalNat pairs: PPParser boolean) parse: '[1 : true; 2 : false]'
parses to {1->true. 2->false}.
"
	^((self pair: rhsP separatedBy: $: asParser trim) separatedBy: $; asParser trim) brackets
	==> [ :resultingPairs | resultingPairs reject: [ :p | p == $; ] ]
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
