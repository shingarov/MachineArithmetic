Class {
	#name : #NNFParser,
	#superclass : #FixpointParser,
	#instVars : [
		'constraint',
		'forall',
		'exists',
		'hCstr',
		'var',
		'sort',
		'qualif',
		'constant',
		'hBind',
		'symSort',
		'pred',
		'kappaApp',
		'kappa',
		'predAnd',
		'decidablePred',
		'cstrPred',
		'funcSort',
		'sortArg',
		'define'
	],
	#category : #'Refinements-Parsing'
}

{ #category : #grammar }
NNFParser >> constant [
	^'constant' asParser trim,
	self tok trim, "name"
	sort
	==> [ :x | HCon symbol: x second sort: x third ]
	
]

{ #category : #grammar }
NNFParser >> constraint [
	^'constraint' asParser trim,
	hCstr
	==> [ :x | x second ]
	
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
	self tok trim, "name"
	(self tok trim, $: asParser trim, sort ==> [ :eachArg | eachArg first -> eachArg last ]) commaList trim,
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
	hBind parens trim,
	hCstr trim
	==> [ :x | CstrAny bind: x second p: x third ]
]

{ #category : #grammar }
NNFParser >> fTyCon [
	^ ('Int' asParser ==> [ :x | Int tyCon ])
	/ ('int' asParser ==> [ :x | Int tyCon ])
	/ ('Bool' asParser ==> [ :x | Bool tyCon ])
	/ ('bool' asParser ==> [ :x | Bool tyCon ])
	/ (NNFParser upperId ==> [ :x | x symbolFTycon ])
]

{ #category : #grammar }
NNFParser >> forall [
	^'forall' asParser trim,
	hBind parens trim,
	hCstr
	==> [ :x | CstrAll bind: x second p: x third ]
]

{ #category : #grammar }
NNFParser >> funcSort [
	"Parser for function sorts without the 'func' keyword"
	^(
	PPParser decimalNat,
	$, asParser trim,
	sort semicolonSeparated brackets
	) parens
	==> [ :x | Z3Sort mkFFunc: x first sorts: x third ]
]

{ #category : #grammar }
NNFParser >> hBind [
	^symSort trim, pred parens
	==> [ :x | HBind x: x first first τ: x first second p: x second ]
]

{ #category : #grammar }
NNFParser >> hCstr [
	^(
		  ('and' asParser trim, hCstr trim star ==> [ :x | CstrAnd of: x second ])
		/ forall
		/ exists
		/ cstrPred
	) parens
]

{ #category : #grammar }
NNFParser >> hThing [
	^(constraint / var / qualif / constant / self fixpoint / define "match data") parens
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
	((#blank asParser plus), self tok ==> [:x| x second]) plus) trim
	==> [ :x | RefVarApp var: x first args: x second ]
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
	symSort trim plus parens trim, "params"
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
	^self hThing trim star end ==> [ :x | HornQuery fromThings: x ]
]

{ #category : #'grammar - util' }
NNFParser >> symSort [
	^(self tok trim, sort) parens
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
