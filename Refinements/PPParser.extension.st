Extension { #name : #PPParser }

{ #category : #'*Refinements' }
PPParser >> braces [
	^${ asParser trim, self, $} asParser trim
	==> [ :x | x second ]
]

{ #category : #'*Refinements' }
PPParser >> brackets [
	^$[ asParser, self, $] asParser
	==> [ :x | x second ]
]

{ #category : #'*Refinements' }
PPParser >> charSeparated: char [
	| delimiter |
	delimiter := Object new.
	^(self separatedBy: char asParser trim ==>[:_x|delimiter])
	==> [ :x | x reject: [ :tok | tok == delimiter ] ]
]

{ #category : #'*Refinements' }
PPParser >> commaList [
	^self commaSeparated parens
]

{ #category : #'*Refinements' }
PPParser >> commaSeparated [
	^self charSeparated: $,
]

{ #category : #'*Refinements' }
PPParser >> lowerId [
	^(#lowercase asParser, #word asParser star) flatten
]

{ #category : #'*Refinements' }
PPParser >> nonBracket [
	^(PPPredicateObjectParser
		on: (PPCharSetPredicate on: [ :ch | ch ~~ $[ and: ch ~~ $] ])
		message: 'Nonparenthesis expected')
		
]

{ #category : #'*Refinements' }
PPParser >> nonParen [
	^(PPPredicateObjectParser
		on: (PPCharSetPredicate on: [ :ch | ch ~~ $( and: ch ~~ $) ])
		message: 'Nonparenthesis expected')
		
]

{ #category : #'*Refinements' }
PPParser >> parens [
	^$( asParser, self, $) asParser
	==> [ :x | x second ]
]

{ #category : #'*Refinements' }
PPParser >> semicolonSeparated [
	^self charSeparated: $;
]

{ #category : #'*Refinements' }
PPParser >> upperId [
	^(#uppercase asParser, #word asParser star) flatten
]
