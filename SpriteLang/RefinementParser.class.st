Class {
	#name : #RefinementParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'matchedParen',
		'funArg',
		'reftB',
		'tbase',
		'refTop',
		'rtype0',
		'rbase',
		'rtype',
		'rfun'
	],
	#category : #SpriteLang
}

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
RefinementParser >> funArg [
	^ (self lowerId, $: asParser, rtype0
	==> [ :x | x first -> x third ])
	/ (rtype0
	==> [ :x | String junkSymbol -> x ])
]

{ #category : #grammar }
RefinementParser >> identifier [
	^ (#letter asParser , #word asParser star) flatten trim
]

{ #category : #grammar }
RefinementParser >> matchedParen [
	^(self nonParen / matchedParen parens) plus flatten
]

{ #category : #grammar }
RefinementParser >> question [
	^ '?' asParser
	==> [ :_x | UnknownReft new ]
]

{ #category : #grammar }
RefinementParser >> rbase [
	^ tbase trim, refTop
	==> [ :b_r | TBase b: b_r first r: b_r second ]
	/ (self identifier, rtype commaList optional, refTop
	==> [ :c_ts_r | TCon 
				c: c_ts_r first
				ts: (c_ts_r second ifNil: [#()])
				r: c_ts_r third ]
	)
]

{ #category : #grammar }
RefinementParser >> refTop [
	^ reftB brackets optional
	==> [ :r | r ifNil: [ Reft alwaysTrue known ] ifNotNil: [ r ] ]
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
	^ rfun
	/ rtype0
]

{ #category : #grammar }
RefinementParser >> rtype0 [
	^ rtype parens
	/ rbase
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

{ #category : #'*SpriteLang' }
RefinementParser >> tvar [
	^ $' asParser, self lowerId
	==> [ :x | TVar symbol: x second ]
]

{ #category : #grammar }
RefinementParser >> tyBindP: keyword [
	"tyBindP :: String -> FP.Parser (F.Symbol, RType)"
	^keyword asParser, #space asParser plus,
	self lowerId trim,
	$: asParser trim,
	rtype trim
	==> [ :x | SpriteAnn symbol: x third rtype: x fifth ]
	
]
