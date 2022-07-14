Class {
	#name : #RTypeParser,
	#superclass : #RefinementParser,
	#instVars : [
		'rtype',
		'rfun',
		'rtype0',
		'rbase',
		'funArg',
		'tbase',
		'refTop',
		'reftB',
		'annot'
	],
	#category : #SpriteLang
}

{ #category : #grammar }
RTypeParser >> annot [
	^'val' asParser, #space asParser plus,
	self lowerId trim,
	$: asParser trim,
	rtype trim
	==> [ :x | SpriteAnn symbol: x third rtype: x fifth ]
	
]

{ #category : #grammar }
RTypeParser >> funArg [
	^ (self lowerId, $: asParser, rtype0
	==> [ :x | x first -> x third ])
	/ (rtype0
	==> [ :x | String junkSymbol -> x ])
]

{ #category : #grammar }
RTypeParser >> question [
	^ '?' asParser
	==> [ :_x | UnknownReft new ]
]

{ #category : #grammar }
RTypeParser >> rbase [
	^tbase trim, refTop
	==> [ :b_r | TBase b: b_r first r: b_r second ]
]

{ #category : #grammar }
RTypeParser >> refTop [
	^ reftB brackets optional
	==> [ :r | r ifNil: [ Reft alwaysTrue known ] ifNotNil: [ r ] ]
]

{ #category : #grammar }
RTypeParser >> reftB [
	^ self question
	/ self concReftB
]

{ #category : #grammar }
RTypeParser >> rfun [
	^funArg trim, '=>' asParser trim, rtype
	==> [ :a_t | TFun
		x: a_t first key
		s: a_t first value
		t: a_t third ]
]

{ #category : #grammar }
RTypeParser >> rtype [
	^ rfun
	/ rtype0
]

{ #category : #grammar }
RTypeParser >> rtype0 [
	^ rtype parens
	/ rbase
]

{ #category : #grammar }
RTypeParser >> start [
	^annot annotationBrackets trim
]

{ #category : #grammar }
RTypeParser >> tbase [
	^ ('int'  asParser ==> [ :x | TInt  instance ])
	/ ('bool' asParser ==> [ :x | TBool instance ])
	/ self tvar
]
