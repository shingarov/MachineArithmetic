Class {
	#name : #RefinementParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'matchedParen',
		'funArg',
		'reftB',
		'tbase',
		'refTop',
		'refVar',
		'rtype0',
		'rbase',
		'rtype',
		'rfun',
		'rall'
	],
	#category : #'SpriteLang-Parsing'
}

{ #category : #grammar }
RefinementParser >> aRef [
	^ self aRefArg commaList trim,
	  '=>' asParser trim,
	  self aRefBody
	==> [ :x | ARef
				arArgs: x first
				arPred: x last ΛpredReft ]
]

{ #category : #grammar }
RefinementParser >> aRefArg [
	^ self lowerId,
	  ':' asParser,
	  (rtype0 ==> #rTypeToRSort) 
	==> [ :x | x first -> x last ]
]

{ #category : #grammar }
RefinementParser >> aRefBody [
	^ self nonBracket plus flatten brackets
	==> [ :x | DecidableRefinement text: x ]
]

{ #category : #grammar }
RefinementParser >> concReftB [
	^ self lowerId trim, $| asParser trim, self nonBracket plus flatten
	==> [ :id_pred |
			| id pred |
			id := id_pred first.
			pred := id_pred last.
			(Reft symbol: id expr: (DecidableRefinement text: pred)) known ]
]

{ #category : #grammar }
RefinementParser >> forall [
	^ '∀' asParser trim, rall ==> #last
]

{ #category : #grammar }
RefinementParser >> funArg [
	^ (self lowerId, $: asParser, rtype0
	==> [ :x | x first -> x third ])
	/ (rtype0
	==> [ :x | String junkSymbol -> x ])
]

{ #category : #grammar }
RefinementParser >> identifier [
	^ (#letter asParser , (#word asParser / $_ asParser)star) flatten trim
]

{ #category : #grammar }
RefinementParser >> matchedParen [
	^(self nonParen / matchedParen parens) plus flatten
]

{ #category : #grammar }
RefinementParser >> metricP [
	^ '/' asParser trim,
	  (self myExprP separatedBy: (',' asParser trim ==> nil K))
	==> [ :x | x second withoutNils as: TerminationMetric ]
]

{ #category : #grammar }
RefinementParser >> myExprP [
	"This is ONLY used for termination metric expressions.
	 In upstream Sprite, this delegates to FP.Parser F.Expr and complaints about
	 a 'pesky hack to work around FP.exprP misparsing foo(x, y, z) blah blah'.
	 Actually it's even worse, trying to pull-in generic 'expr' results in major
	 mess.
"
	^ self nonBracket plus flatten brackets
	==> [ :x | MetricExpression source: x ]
]

{ #category : #grammar }
RefinementParser >> question [
	^ '?' asParser
	==> [ :_x | UnknownReft new ]
]

{ #category : #grammar }
RefinementParser >> rall [
	^( refVar parens,
	   $. asParser trim,
	   rtype
	) ==> [ :x | TRAll r: x first t: x last ]
]

{ #category : #grammar }
RefinementParser >> rbase [
	^ tbase trim, refTop
	==> [ :b_r | TBase b: b_r first r: b_r second ]
	/ (self identifier, rtype commaList optional, self aRef commaList optional, refTop
	==> [ :c_ts_ars_r | TCon
				c: c_ts_ars_r first
				ts: (c_ts_ars_r second ifNil: [#()])
				ars: (c_ts_ars_r third ifNil: [#()])
				r: c_ts_ars_r last ]
	)
]

{ #category : #grammar }
RefinementParser >> refTop [
	^ reftB brackets optional
	==> [ :r | r ifNil: [ ΛReft new ] ifNotNil: [ r ] ]
]

{ #category : #grammar }
RefinementParser >> refVar [
"
refVar :: FP.Parser RVar
refVar = mkRVar <$> FP.lowerIdP <*> (FP.colon *> rtype)
"
	^self lowerId,
	' : ' asParser,
	rtype
	==> [ :x | x third mkRVar: x first ]
]

{ #category : #grammar }
RefinementParser >> reftB [
	^ self question
	/ self concReftB
]

{ #category : #grammar }
RefinementParser >> rfun [
	^funArg trim, '=>' asParser trim, rtype
	==> [ :a_t | TFun
		x: a_t first key
		s: a_t first value
		t: a_t third ]
]

{ #category : #grammar }
RefinementParser >> rtype [
"
-- | Top level Rtype parser
"
	^ self forall
	/ rfun
	/ rtype0
]

{ #category : #grammar }
RefinementParser >> rtype0 [
	^ rtype parens
	/ rbase
]

{ #category : #grammar }
RefinementParser >> sigP: keyword [
"
sigP :: String -> FP.Parser Sig
here Sig is just type-alias for (F.Symbol, RType, Maybe Metric)
"
	^keyword asParser, #space asParser plus,
	self lowerId trim,
	$: asParser trim,
	rtype trim,
	self metricP optional
	==> [ :x | {x third . x fifth . x sixth} ]
	
]

{ #category : #grammar }
RefinementParser >> start [
	self subclassResponsibility
]

{ #category : #grammar }
RefinementParser >> tbase [
	^ ('int'  asParser ==> [ :x | TInt  instance ])
	/ ('bool' asParser ==> [ :x | TBool instance ])
	/ self tvar
]

{ #category : #grammar }
RefinementParser >> tvar [
	^ $' asParser, self lowerId
	==> [ :x | TVar symbol: x second ]
]

{ #category : #grammar }
RefinementParser >> tyBindP: keyword [
"
tyBindP :: String -> FP.Parser (F.Symbol, RType)
Unlike L₆, in L₈ this is only used for measures.
"
	^(self sigP: keyword)
	==> #allButLast "metric is always nil"
]
