Class {
	#name : #NNFParser,
	#superclass : #FixpointParser,
	#instVars : [
		'hCstr',
		'hBind',
		'symSort',
		'hPred',
		'define'
	],
	#category : #'Refinements-Parsing'
}

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
		  ('constraint' asParser trim, hCstr ==> #second)
		/ self hVar
		/ self hQualifier
		/ ('constant' asParser trim, self tok trim, sort ==> [ :x | HCon symbol: x second sort: x third ])
		/ self fixpoint
		/ define
		" / match"
		" / data"
	) parens
]

{ #category : #grammar }
NNFParser >> hVar [
	^'var' asParser trim,
	self kvSym trim,
	sort parens trim plus parens
	==> [ :x | HVar name: x second argSorts: x third ]
	
]

{ #category : #grammar }
NNFParser >> kvSym [
	^('$' asParser,
	($# asParser ==> [:x|$º] / #word asParser / $_ asParser) plus)
	==> [ :x | String withAll: x second ]
]

{ #category : #grammar }
NNFParser >> start [
	^self hThing trim star end ==> [ :x | HornQuery fromThings: x ]
]

{ #category : #'grammar - util' }
NNFParser >> symSort [
	^(self tok trim, sort) parens
]
