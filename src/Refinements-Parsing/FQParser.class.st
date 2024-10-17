Class {
	#name : #FQParser,
	#superclass : #FixpointParser,
	#instVars : [
		'subC',
		'sortedReft',
		'bind',
		'refa'
	],
	#category : #'Refinements-Parsing'
}

{ #category : #grammar }
FQParser >> bind [
	^ self class lowerId trim,
	$: asParser trim
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
	^ self def plus
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
	^(
		bp trim,
		kindP trim,
		'|' asParser trim,
		rp,
		Character space asParser star
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
	^'PRED' asParser
]

{ #category : #grammar }
FQParser >> sortedReft [
	^ self ref: (sort ==> [ :aSort | [ :r | SortedReft sort: aSort reft: r ]])
]

{ #category : #grammar }
FQParser >> start [
	^self fInfo
]

{ #category : #grammar }
FQParser >> subC [
	^ 'env []' asParser trim
	, "'lhs' asParser trim, sortedReft
	, 'rhs' asParser trim," sortedReft trim
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
