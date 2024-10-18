Class {
	#name : #FixpointParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'matchedParen',
		'sort',
		'sortArg',
		'funcSort',
		'pred'
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
FixpointParser >> fTyCon [
	^ ('Int' asParser ==> [ :x | Int tyCon ])
	/ ('int' asParser ==> [ :x | Int tyCon ])
	/ ('Bool' asParser ==> [ :x | Bool tyCon ])
	/ ('bool' asParser ==> [ :x | Bool tyCon ])
	/ (NNFParser upperId ==> #symbolFTycon)
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

{ #category : #grammar }
FixpointParser >> funcSort [
	"Parser for function sorts without the 'func' keyword"
	^(
	PPParser decimalNat,
	$, asParser trim,
	sort semicolonSeparated brackets
	) parens
	==> [ :x | Z3Sort mkFFunc: x first sorts: x third ]
]

{ #category : #'grammar - util' }
FixpointParser >> matchedParen [
	^(PPParser nonParen / matchedParen parens) plus flatten
]

{ #category : #grammar }
FixpointParser >> pred [
	^ matchedParen
	==> [ :x | DecidableRefinement text: x ]
]

{ #category : #grammar }
FixpointParser >> sort [
	^ self sort′: sortArg trim star
]

{ #category : #grammar }
FixpointParser >> sortArg [
	^ self sort′: nil asParser
]

{ #category : #grammar }
FixpointParser >> sort′: aSortArgParser [
	| sap |
	sap := aSortArgParser ==> [ :args | args ifNil: [ #() ] ]. "aSortArgParser can be EpsilonParser"
	^ sort parens
	/ ('func' asParser, funcSort ==> [ :x | x second ])
	/ (sort brackets ==> [ :x | x shouldBeImplemented listFTyCon  ])
	/ (self fTyCon trim, sap ==> [ :x | x first fAppTC: x second ])
	/ (self tvar trim, sap ==> [ :x | x first fApp: x second ])
]

{ #category : #grammar }
FixpointParser >> tok [
	^(PPPredicateObjectParser
		on: (PPCharSetPredicate on: [ :ch |
					(ch isSeparator or: [ ch == $( or: [ ch == $) ]]) not ])
		message: 'Token expected') plus flatten
		
]

{ #category : #grammar }
FixpointParser >> tvar [
	^ self varSort
	/ ($` asParser, #lowercase asParser ==> [ :x | Z3Sort uninterpretedSortNamed: (String with: x second) ])
]

{ #category : #grammar }
FixpointParser >> varSort [
	^'@(' asParser, PPParser decimalInteger, ')' asParser
	==> [ :x | FVar new: x second ]
]
