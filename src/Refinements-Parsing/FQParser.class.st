Class {
	#name : #FQParser,
	#superclass : #FixpointParser,
	#instVars : [
		'subC',
		'bind',
		'refa',
		'sortedReft'
	],
	#category : #'Refinements-Parsing'
}

{ #category : #grammar }
FQParser >> bind [
	^ self class symbol trim,
	$: asParser
	==> #first
]

{ #category : #grammar }
FQParser >> constant [
	^ 'constant' asParser
	, #space asParser plus
	, self class symbol trim
	, $: asParser trim
	, sort
	==> [ :x | FqCon symbol: x third sort: x fifth ]
]

{ #category : #grammar }
FQParser >> constraint [
	^ 'constraint:' asParser trim
	, subC
	==> #second
]

{ #category : #grammar }
FQParser >> def [
	^ self fixpoint
	/ self constraint
	/ self wf
	/ self constant
	/ self qualif
	/ self iBind
	/ self define
	"match"
	/ self expand
	/ data
	/ 'everything else' asParser
]

{ #category : #grammar }
FQParser >> env [
"
envP  :: Parser IBindEnv
"
	^ PPParser decimalInteger semicolonSeparated brackets
 ==> [ :x | x inject: IBindEnv empty into: [ :soFar :thisTime | soFar insert: thisTime ] ]
	/ ('[]' asParser ==> [ :_ | IBindEnv empty ]) "semicolonSeparated matches only nonempty"
]

{ #category : #grammar }
FQParser >> fInfo [
	^ self def trim plus
	==> [ :x | FInfo defsFInfo: x ]
]

{ #category : #grammar }
FQParser >> iBind [
	^ 'bind' asParser trim
	, PPParser decimalNat trim
	, FixpointParser lowerId trim
	, $: asParser trim
	, sortedReft trim
	==> [ :x | FqIBind
				int: x second
				symbol: x third
				sortedReft: x fifth
		]
]

{ #category : #grammar }
FQParser >> qualParam: tP [
"
qualParamP :: Parser Sort -> Parser QualParam
qualParamP tP = do
  x     <- symbolP
  pat   <- qualPatP
  _     <- colon 
  t     <- tP
  return $ QP x pat t
"
	^ self class symbol
	, self qualPat
	, $: asParser
	, tP
	==> [ :x | QualParam
			symbol: x first
			sort: x fourth
			pattern: x second
	]
]

{ #category : #grammar }
FQParser >> qualPat [
"
qualPatP :: Parser QualPattern
qualPatP
   =  (reserved 'as' >> qualStrPatP)
  <|> return PatNone
"
	^ 'asXXXXXXX' asParser optional "TODO"
]

{ #category : #grammar }
FQParser >> qualif [
	^ 'qualif' asParser trim
	, (self qualifier: sort)
	==> #second
]

{ #category : #grammar }
FQParser >> qualifier: tP [
"
--------------------------------------------------------------------------------
-- | Parsing Qualifiers --------------------------------------------------------
--------------------------------------------------------------------------------

-- | Qualifiers 
qualifierP :: Parser Sort -> Parser Qualifier
qualifierP tP = do
  pos    <- getSourcePos
  n      <- upperIdP
  params <- parens $ sepBy1 (qualParamP tP) comma
  _      <- colon
  body   <- predP
  return  $ mkQual n params body pos
"
	^ self class upperId trim
	, ((self qualParam: tP) separatedBy: $, asParser trim) parens trim
	, $: asParser trim,
	pred parens "CAVEAT PROGRAMMATOR: parens is added in Smalltalk to avoid eating too much to the right"
	==> [ :x | Qualifier
			name: x first
			params: x second
			body: x last 
	]
]

{ #category : #grammar }
FQParser >> ref: kind [
"
-- | (Sorted) Refinements
"
	^self refBind: bind rp: refa kind: kind
]

{ #category : #grammar }
FQParser >> refBind: bp rp: rp kind: kindP [
"
-- (Sorted) Refinements with configurable sub-parsers
"
	^(
		bp trim,
		kindP trim,
		'|' asParser trim,
		rp
	) braces
	==> [ :x | x second value: (Reft symbol: x first expr: x fourth) ]
]

{ #category : #grammar }
FQParser >> refa [
"
-- | Refa
refaP :: Parser Expr
refaP =  try (pAnd <$> brackets (sepBy predP semi))
     <|> predP
Cf. top-level Parse.hs
"
	^".... and .... | "
	pred
]

{ #category : #grammar }
FQParser >> sortedReft [
	^ self ref: (sort ==> [ :aSort | [ :r | SortedReft sort: aSort reft: r ]])
]

{ #category : #grammar }
FQParser >> start [
	^self fInfo trim end
]

{ #category : #grammar }
FQParser >> subC [
"
subCP :: Parser (SubC ())
subCP = do pos <- getSourcePos
           reserved 'env'
           env <- envP
           reserved 'lhs'
           lhs <- sortedReftP
           reserved 'rhs'
           rhs <- sortedReftP
           reserved 'id'
           i   <- natural <* spaces
           tag <- tagP
           pos' <- getSourcePos
           return $ subC' env lhs rhs i tag pos pos'
"
	^ ('env' asParser trim, self env ==> #second)
	, 'lhs' asParser trim, sortedReft trim
	, 'rhs' asParser trim, sortedReft trim
	, 'id'  asParser, Character space asParser plus, PPParser decimalNat trim
	, self tag
	==> [ :x | SubC
			subC′: x first
			lhs: x third
			rhs: x fifth
			i: x eighth
			tag: x ninth
	]
]

{ #category : #grammar }
FQParser >> tag [
	^ 'tag' asParser
	, Character space asParser
	, ('[' asParser trim, ']' asParser ==> [ :_ | nil ] / PPParser decimalNat semicolonSeparated brackets)
	==> [ :x | x third ]
]

{ #category : #grammar }
FQParser >> wf [
	^ 'wf:' asParser trim
	, self wfC
	==> #second
]

{ #category : #grammar }
FQParser >> wfC [
"
wfCP :: Parser (WfC ())
wfCP = do reserved 'env'
          env <- envP
          reserved 'reft'
          r   <- sortedReftP
          let [w] = wfC env r () 
          return w
"
	^ ('env' asParser trim, self env ==> #second)
	, ('reft' asParser trim, sortedReft trim ==> #second)
	==> [ :x |
			| wfcs |
			wfcs := WfC wfC: x first sr: x second meta: #bogus.
			wfcs size = 1 ifFalse: [ self error ].
			wfcs anyOne ]
]
