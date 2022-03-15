Class {
	#name : #RTypeParser,
	#superclass : #PPCompositeParser,
	#instVars : [
		'rtype',
		'rfun',
		'rtype0',
		'rbase',
		'funArg',
		'tbase',
		'refTop',
		'reftB',
		'annot',
		'question',
		'qual'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
RTypeParser >> annot [
	^'val' asParser, #space asParser plus,
	self lowerId trim,
	$: asParser trim,
	rtype trim
	==> [ :x | SpriteAnn symbol: x third rtype: x fifth ]
	
]

{ #category : #accessing }
RTypeParser >> funArg [
	^ (self lowerId, $: asParser, rtype0
	==> [ :x | x first -> x third ])
	/ (rtype0
	==> [ :x | '_' -> x ])
]

{ #category : #accessing }
RTypeParser >> rbase [
	^tbase trim, refTop
	==> [ :b_r | TBase b: b_r first r: b_r second ]
]

{ #category : #accessing }
RTypeParser >> refTop [
	^ reftB brackets optional
	==> [ :r | r ifNil: [ Reft alwaysTrue ] ifNotNil: [ r ] ]
]

{ #category : #accessing }
RTypeParser >> reftB [
	^self lowerId trim, $| asParser trim, self nonBracket plus flatten
	==> [ :id_pred |
			| id pred |
			id := id_pred first.
			pred := id_pred last.
			Reft symbol: id expr: (DecidableRefinement text: pred) ]
]

{ #category : #accessing }
RTypeParser >> rfun [
	^funArg trim, '=>' asParser trim, rtype
	==> [ :a_t | TFun
		x: a_t first key
		s: a_t first value
		t: a_t third ]
]

{ #category : #accessing }
RTypeParser >> rtype [
	^ rfun
	/ rtype0
]

{ #category : #accessing }
RTypeParser >> rtype0 [
	^ rtype parens
	/ rbase
]

{ #category : #grammar }
RTypeParser >> start [
	^annot annotationBrackets 
]

{ #category : #accessing }
RTypeParser >> tbase [
	^ ('int'  asParser ==> [ :x | TInt  instance ])
	/ ('bool' asParser ==> [ :x | TBool instance ])
]
