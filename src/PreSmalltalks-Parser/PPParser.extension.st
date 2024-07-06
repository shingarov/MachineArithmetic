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
PPParser >> nonBracket [
	^(PPPredicateObjectParser
		on: (PPCharSetPredicate on: [ :ch | ch ~~ $[ and: ch ~~ $] ])
		message: 'Nonparenthesis expected')
		
]

{ #category : #'*PreSmalltalks-Parser' }
PPParser >> nonParen [
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
