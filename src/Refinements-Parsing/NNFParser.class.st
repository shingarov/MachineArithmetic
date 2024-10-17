Class {
	#name : #NNFParser,
	#superclass : #FixpointParser,
	#instVars : [
		'constraint',
		'hCstr',
		'var',
		'sort',
		'hBind',
		'symSort',
		'hPred',
		'funcSort',
		'sortArg',
		'define',
		'pred'
	],
	#category : #'Refinements-Parsing'
}

{ #category : #grammar }
NNFParser >> constraint [
	^'constraint' asParser trim,
	hCstr
	==> [ :x | x second ]
	
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
NNFParser >> fTyCon [
	^ ('Int' asParser ==> [ :x | Int tyCon ])
	/ ('int' asParser ==> [ :x | Int tyCon ])
	/ ('Bool' asParser ==> [ :x | Bool tyCon ])
	/ ('bool' asParser ==> [ :x | Bool tyCon ])
	/ (NNFParser upperId ==> [ :x | x symbolFTycon ])
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
	^(symSort trim, hPred) parens
	==> [ :x | HBind x: x first first τ: x first second p: x second ]
]

{ #category : #grammar }
NNFParser >> hCstr [
	^(
		  ('and' asParser trim, hCstr trim star ==> [ :x | CstrAnd of: x second ])
		/ ('forall' asParser trim, hBind trim, hCstr trim ==> [ :x | CstrAll bind: x second p: x third ])
		/ ('exists' asParser trim, hBind trim, hCstr trim ==> [ :x | CstrAny bind: x second p: x third ])
		"TODO: / tag"
		/ (hPred ==> [ :x | CstrHead pred: x ])
	) parens
]

{ #category : #grammar }
NNFParser >> hPred [
	^(
		  ('and' asParser, 	(#blank asParser plus, hPred ==> #second) star ==> [ :x | HPredAnd of: x second ])
		/ (self kvSym, ((#blank asParser plus), self tok ==> [:x| x second]) plus ==> [ :x | RefVarApp var: x first args: x second ])
		/ (pred ==> [ :x | HReft expr: x ])
	) parens
]

{ #category : #grammar }
NNFParser >> hQualifier [
	^'qualif' asParser trim,
	NNFParser upperId trim, "name"
	symSort trim plus parens trim, "params"
	hPred "body"
	==> [ :x | Qualifier
		name: x second
		params: (x third collect: [ :p | QualParam symbol: p first sort: p second ])
		body: x fourth expr ]
	
]

{ #category : #grammar }
NNFParser >> hThing [
	^(
		  constraint
		/ var
		/ self hQualifier
		/ ('constant' asParser trim, self tok trim, sort ==> [ :x | HCon symbol: x second sort: x third ])
		/ self fixpoint
		/ define
		" / match"
		" / data"
	) parens
]

{ #category : #grammar }
NNFParser >> kvSym [
	^('$' asParser,
	($# asParser ==> [:x|$º] / #word asParser / $_ asParser) plus)
	==> [ :x | String withAll: x second ]
]

{ #category : #grammar }
NNFParser >> pred [
	^ matchedParen
	==> [ :x | DecidableRefinement text: x ]
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
	self kvSym trim,
	sort parens trim plus parens
	==> [ :x | HVar name: x second argSorts: x third ]
	
]

{ #category : #grammar }
NNFParser >> varSort [
	^'@(' asParser, PPParser decimalInteger, ')' asParser
	==> [ :x | FVar new: x second ]
]
