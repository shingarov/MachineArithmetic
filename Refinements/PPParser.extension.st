Extension { #name : #PPParser }

{ #category : #'*Refinements' }
PPParser >> braces [
	^${ asParser, self, $} asParser
	==> [ :x | x second ]
]

{ #category : #'*Refinements' }
PPParser >> brackets [
	^$[ asParser, self, $] asParser
	==> [ :x | x second ]
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
PPParser >> upperId [
	^(#uppercase asParser, #word asParser star) flatten
]
