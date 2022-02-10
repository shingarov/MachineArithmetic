Extension { #name : #HThing }

{ #category : #'*Refinements-Parsing' }
HThing class >> kappaParser [
	^('$' asParser,
	($# asParser ==> [:x|$º] / #word asParser / $_ asParser) plus)
	==> [ :x | String withAll: x second ]
]

{ #category : #'*Refinements-Parsing' }
HThing class >> matchedParen [
	| mp |
	mp := PPDelegateParser new.
	mp setParser: (self nonParen / mp parens) plus flatten.
	^mp
]

{ #category : #'*Refinements-Parsing' }
HThing class >> nonParen [
	^PPPredicateObjectParser
		on: (PPCharSetPredicate on: [ :ch | ch ~~ $( and: ch ~~ $) ])
		message: 'Nonparenthesis expected'
]

{ #category : #'*Refinements-Parsing' }
HThing class >> sortParser [
	^'Int' asParser ==> [ :x | Int sort ]
]

{ #category : #'*Refinements-Parsing' }
HThing class >> tok [
	^(PPPredicateObjectParser
		on: (PPCharSetPredicate on: [ :ch |
					(ch isSeparator or: [ ch == $( or: [ ch == $) ]]) not ])
		message: 'Token expected') plus flatten
]
