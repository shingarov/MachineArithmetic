Class {
	#name : #FixpointParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'sort',
		'sortArg',
		'funcSort',
		'pred',
		'data'
	],
	#category : #'Refinements-Parsing'
}

{ #category : #grammar }
FixpointParser class >> isNotReserved: aString [
	^aString ∉ self reservedNames
]

{ #category : #grammar }
FixpointParser class >> lowerId [
	^(#lowercase asParser, (#word asParser / $_ asParser) star) flatten
]

{ #category : #grammar }
FixpointParser class >> reservedNames [
	^{
		"-- reserved words used in fixpoint"
		'SAT'.
		'UNSAT'.
		'true'.
		'false'.
		'mod'.
		'data'.
		'Bexp'.
		"-- True"
		"-- Int"
		'import'.
		'if'. 'then'. 'else'.
		'func'.
		'autorewrite'.
		'rewrite'.
		
		"-- reserved words used in liquid haskell"
		'forall'.
		'coerce'.
		'exists'.
		'module'.
		'spec'.
		'where'.
		'decrease'.
		'lazyvar'.
		'LIQUID'.
		'lazy'.
		'local'.
		'assert'.
		'assume'.
		'automatic-instances'.
		'autosize'.
		'axiomatize'.
		'bound'.
		'class'.
		'data'.
		'define'.
		'defined'.
		'embed'.
		'expression'.
		'import'.
		'include'.
		'infix'.
		'infixl'.
		'infixr'.
		'inline'.
		'instance'.
		'invariant'.
		'measure'.
		'newtype'.
		'predicate'.
		'qualif'.
		'reflect'.
		'type'.
		'using'.
		'with'.
		'in'.
	} asSet
]

{ #category : #grammar }
FixpointParser class >> safeChars [
	^( ($a to: $z), ($A to: $Z), ($0 to: $9), {$_ . $.} ) asSet
]

{ #category : #grammar }
FixpointParser class >> symChars [
	^self safeChars ∪ #($% $# $$ $' $ß $º) asSet
]

{ #category : #grammar }
FixpointParser class >> symbol [
	"Cf symbolP in non-Horn Parse.hs.
	
	| Unconstrained identifier, lower- or uppercase.
	Must not be a reserved word.
	We don't have lexemes yet, so we don't distinguish this from symbolR.
	"
	| firstCharP subsequentCharP anyId |
	firstCharP := #letter asParser / $_ asParser.
	subsequentCharP := PPChoiceParser withAll: (self symChars collect: #asParser).
	anyId := (firstCharP, subsequentCharP star) flatten.
	^PPPostconditionalParser
		on: anyId
		block: (self isNotReserved: □)

]

{ #category : #grammar }
FixpointParser class >> upperId [
	^(#uppercase asParser, (#word asParser / $_ asParser) star) flatten
]

{ #category : #grammar }
FixpointParser >> data [
	^'data' asParser trim,
	self fTyCon trim,
	PPParser decimalNat trim,
	$= asParser trim,
	($| asParser trim, self dataCtor trim ==> #second) star brackets
		==> [ :x | DataDecl
			ddTyCon: x second
			ddVars: x third
			ddCtors: x fifth ]
]

{ #category : #grammar }
FixpointParser >> dataCtor [
	^FixpointParser symbol trim,
	(self dataField commaSeparated optional ==> [ :x | x ifNil: [#()] ifNotNil: [x] ]) braces
	==> [ :x | DataCtor dcName: x first dcFields: x second ]
]

{ #category : #grammar }
FixpointParser >> dataField [
	^ FixpointParser symbol trim,
	$: asParser trim,
	sort
	==> [ :x | DataField dfName: x first dfSort: x last ]
]

{ #category : #grammar }
FixpointParser >> define [
	"Function definition equations (PLE)."
	^'define' asParser trim,
	self tok trim, "name"
	(self tok trim, $: asParser trim, sort ==> [ :eachArg | eachArg first -> eachArg last ]) commaList trim,
	$: asParser trim,
	sort,
	'=' asParser trim,
	(DecidableRefinement parser braces)
	==> [ :x | Equation
					mkEquation: x second
					args: x third
					expr: x seventh
					sort: x fifth ]
]

{ #category : #grammar }
FixpointParser >> expand [
	^'expand' asParser trim,
	(PPParser decimalInteger pairs: PPParser boolean)
	==> [ :x | FqExpand associations: x second ]
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

{ #category : #grammar }
FixpointParser >> pred [
	^DecidableRefinement parser
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
	/ ($` asParser, #lowercase asParser ==> [ :x | FObj symbol: (String with: x second) ])
]

{ #category : #grammar }
FixpointParser >> varSort [
	^'@(' asParser, PPParser decimalInteger, ')' asParser
	==> [ :x | FVar new: x second ]
]
