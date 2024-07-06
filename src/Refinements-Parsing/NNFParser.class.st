Class {
	#name : #NNFParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'fixpoint',
		'constraint',
		'tok',
		'thing',
		'cstrAnd',
		'forall',
		'exists',
		'cstr',
		'var',
		'sort',
		'qualif',
		'constant',
		'bind',
		'symSort',
		'pred',
		'kappaApp',
		'kappa',
		'predAnd',
		'decidablePred',
		'matchedParen',
		'cstrPred',
		'funcSort',
		'sortArg',
		'define'
	],
	#category : #'Refinements-Parsing'
}

{ #category : #grammar }
NNFParser class >> lowerId [
	^(#lowercase asParser, (#word asParser / $_ asParser) star) flatten
]

{ #category : #grammar }
NNFParser class >> upperId [
	^(#uppercase asParser, (#word asParser / $_ asParser) star) flatten
]

{ #category : #grammar }
NNFParser >> bind [
	^symSort parens trim, pred parens
	==> [ :x | HBind x: x first first τ: x first second p: x second ]
]

{ #category : #grammar }
NNFParser >> constant [
	^'constant' asParser trim,
	tok trim, "name"
	sort
	==> [ :x | HCon symbol: x second sort: x third ]
	
]

{ #category : #grammar }
NNFParser >> constraint [
	^'constraint' asParser trim,
	cstr parens
	==> [ :x | x second ]
	
]

{ #category : #grammar }
NNFParser >> cstr [
	^cstrAnd / forall / exists / cstrPred
]

{ #category : #grammar }
NNFParser >> cstrAnd [
	^'and' asParser trim,
	cstr parens trim star ==> [ :x | CstrAnd of: x second ]
]

{ #category : #grammar }
NNFParser >> cstrPred [
	^pred parens ==> [ :x | CstrHead pred: x ]
]

{ #category : #grammar }
NNFParser >> decidablePred [
	^matchedParen
	==> [ :x | HReft expr: (DecidableRefinement text: x) ]
]

{ #category : #grammar }
NNFParser >> define [
	"Function definition equations (PLE).
	 Cf. top-level Parse.hs"
	^'define' asParser trim,
	tok trim, "name"
	(tok trim, $: asParser trim, sort ==> [ :eachArg | eachArg first -> eachArg last ]) commaList trim,
	$: asParser trim,
	sort,
	'=' asParser trim,
	(RefinementExpressionParser new braces ==> [ :seq | seq formattedCode ])
	==> [ :x | Equation
					mkEquation: x second
					args: x third
					expr: (DecidableRefinement text: x seventh)
					sort: x fifth ]
]

{ #category : #grammar }
NNFParser >> exists [
	^'exists' asParser trim,
	bind parens trim,
	cstr parens trim
	"'(and)' asParser"
	==> [ :x | CstrAny bind: x second p: x third ]
]

{ #category : #grammar }
NNFParser >> fTyCon [
	^ ('Int' asParser ==> [ :x | Int tyCon ])
	/ ('int' asParser ==> [ :x | Int tyCon ])
	/ ('bool' asParser ==> [ :x | Bool tyCon ])
	/ (NNFParser upperId ==> [ :x | x symbolFTycon ])
]

{ #category : #grammar }
NNFParser >> fixpoint [
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
NNFParser >> forall [
	^'forall' asParser trim,
	bind parens trim,
	cstr parens
	==> [ :x | CstrAll bind: x second p: x third ]
]

{ #category : #grammar }
NNFParser >> funcSort [
	"Parser for function sorts without the 'func' keyword"
	^(
	(#digit asParser plus flatten ==> #asInteger),
	$, asParser trim,
	sort semicolonSeparated brackets
	) parens
	==> [ :x | Z3Sort mkFFunc: x first sorts: x third ]
]

{ #category : #grammar }
NNFParser >> kappa [
	^('$' asParser,
	($# asParser ==> [:x|$º] / #word asParser / $_ asParser) plus)
	==> [ :x | String withAll: x second ]
]

{ #category : #grammar }
NNFParser >> kappaApp [
	^(kappa,
	((#blank asParser plus), tok ==> [:x| x second]) star) trim
	==> [ :x | RefVarApp var: x first args: x second ]
]

{ #category : #'grammar - util' }
NNFParser >> matchedParen [
	^(PPParser nonParen / matchedParen parens) plus flatten
]

{ #category : #grammar }
NNFParser >> pred [
	^predAnd / kappaApp / decidablePred
]

{ #category : #grammar }
NNFParser >> predAnd [
	^'and' asParser,
	(#blank asParser plus, pred parens ==> [:x| x second]) star 
	==> [ :x | HPredAnd of: x second ]
]

{ #category : #grammar }
NNFParser >> qualif [
	^'qualif' asParser trim,
	NNFParser upperId trim, "name"
	symSort parens trim plus parens trim, "params"
	pred parens "body"
	==> [ :x | Qualifier
		name: x second
		params: (x third collect: [ :p | QualParam symbol: p first sort: p second ])
		body: x fourth expr ]
	
]

{ #category : #grammar }
NNFParser >> sort [
	^ self sort′: sortArg trim star
]

{ #category : #grammar }
NNFParser >> sortArg [
	^ self sort′: nil asParser
]

{ #category : #grammar }
NNFParser >> sort′: aSortArgParser [
	| sap |
	sap := aSortArgParser ==> [ :args | args ifNil: [ #() ] ]. "aSortArgParser can be EpsilonParser"
	^ sort parens
	/ ('func' asParser, funcSort ==> [ :x | x second ])
	/ (sort brackets ==> [ :x | x shouldBeImplemented listFTyCon  ])
	/ (self fTyCon trim, sap ==> [ :x | x first fAppTC: x second ])
	/ (self tvar trim, sap ==> [ :x | x first fApp: x second ])
]

{ #category : #grammar }
NNFParser >> start [
	^thing trim star end ==> [ :x | HornQuery fromThings: x ]
]

{ #category : #'grammar - util' }
NNFParser >> symSort [
	^tok trim, sort
]

{ #category : #grammar }
NNFParser >> thing [
	^(constraint / var / qualif / constant / fixpoint / define "match data") parens
]

{ #category : #'grammar - util' }
NNFParser >> tok [
	^(PPPredicateObjectParser
		on: (PPCharSetPredicate on: [ :ch |
					(ch isSeparator or: [ ch == $( or: [ ch == $) ]]) not ])
		message: 'Token expected') plus flatten
		
]

{ #category : #grammar }
NNFParser >> tvar [
	^ self varSort
	/ ($` asParser, #lowercase asParser ==> [ :x | Z3Sort uninterpretedSortNamed: (String with: x second) ])
]

{ #category : #grammar }
NNFParser >> var [
	^'var' asParser trim,
	kappa trim,
	sort parens trim plus parens
	==> [ :x | HVar name: x second argSorts: x third ]
	
]

{ #category : #grammar }
NNFParser >> varSort [
	^'@(' asParser, PPParser decimalInteger, ')' asParser
	==> [ :x | FVar new: x second ]
]
