Class {
	#name : #FixpointParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'matchedParen'
	],
	#category : #'Refinements-Parsing'
}

{ #category : #grammar }
FixpointParser class >> lowerId [
	^(#lowercase asParser, (#word asParser / $_ asParser) star) flatten
]

{ #category : #grammar }
FixpointParser class >> upperId [
	^(#uppercase asParser, (#word asParser / $_ asParser) star) flatten
]

{ #category : #grammar }
FixpointParser >> fixpoint [
	^'fixpoint' asParser trim,
	'"--' asParser,
	('eliminate' asParser / 'rewrite' asParser / 'save' asParser / 'fuel' asParser),
	($= asParser, #word asParser plus flatten) optional,
	$" asParser
	==> [ :x |
		| selector |
		selector := x third asSymbol.
		x fourth isNil
			ifTrue: [ HOpt perform: selector ]
			ifFalse: [ HOpt perform: selector, ':' with: x fourth second ]
	]
	
]

{ #category : #'grammar - util' }
FixpointParser >> matchedParen [
	^(PPParser nonParen / matchedParen parens) plus flatten
]

{ #category : #grammar }
FixpointParser >> tok [
	^(PPPredicateObjectParser
		on: (PPCharSetPredicate on: [ :ch |
					(ch isSeparator or: [ ch == $( or: [ ch == $) ]]) not ])
		message: 'Token expected') plus flatten
		
]
