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
	^ self class lowerId trim,
	$: asParser
	==> #first
]

{ #category : #grammar }
FQParser >> constraint [
	^ 'constraint:' asParser trim
	, subC
]

{ #category : #grammar }
FQParser >> def [
	^ self fixpoint
	/ self constraint
	/ 'everything else' asParser
]

{ #category : #grammar }
FQParser >> fInfo [
	^ self def trim plus
	==> [ :x | FInfo defsFInfo: x ]
]

{ #category : #grammar }
FQParser >> ref: kind [
"
-- | (Sorted) Refinements
"
	^(self refBind: bind rp: refa kind: kind)
	==> [ :x | x halt ]
]

{ #category : #grammar }
FQParser >> refBind: bp rp: rp kind: kindP [
"
-- (Sorted) Refinements with configurable sub-parsers
"
	^${ asParser,
		bp trim,
		kindP trim,
		'|' asParser trim,
		rp,
		$} asParser
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
	^ 'env []' asParser trim
	, 'lhs' asParser trim, sortedReft trim
	, 'rhs' asParser trim, sortedReft trim
	, 'id'  asParser, Character space asParser plus, PPParser decimalNat trim
	, self tag
	==> [ :x | x halt ]
]

{ #category : #grammar }
FQParser >> tag [
	^ 'tag' asParser
	, Character space asParser
	, PPParser decimalNat semicolonSeparated brackets
	==> [ :x | x third ]
]
