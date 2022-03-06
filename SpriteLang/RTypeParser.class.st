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
		'ann',
		'annot'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
RTypeParser >> ann [
	^('/*@' asParser, #space asParser, annot, '*/' asParser trim) 
	==> [ :x | x third ]
]

{ #category : #accessing }
RTypeParser >> annot [
	^'val' asParser, #space asParser,
	self lowerId trim,
	$: asParser trim,
	rtype trim
	==> [ :x | SpriteAnn symbol: x third rtype: x fifth ]
	
]

{ #category : #accessing }
RTypeParser >> funArg [
	^(self lowerId, $: asParser, rtype0
	==> [ :x | x first -> x third ])
	| (rtype0
	==> [ :x | '_' -> x ])
]

{ #category : #accessing }
RTypeParser >> rbase [
	^tbase, refTop
	==> [ :b_r | SpriteTBase b: b_r first r: b_r second ]
]

{ #category : #accessing }
RTypeParser >> refTop [
	^reftB brackets optional
]

{ #category : #accessing }
RTypeParser >> reftB [
	^self lowerId trim, $| asParser trim, self nonBracket plus flatten
	==> [ :id_pred | Reft symbol: id_pred first expr: id_pred third ]
]

{ #category : #accessing }
RTypeParser >> rfun [
	^funArg trim, '=>' asParser trim, rtype
	==> [ :a_t | SpriteTFun
		x: a_t first key
		s: a_t first value
		t: a_t third ]
]

{ #category : #accessing }
RTypeParser >> rtype [
	^rfun | rtype0
]

{ #category : #accessing }
RTypeParser >> rtype0 [
	^rtype parens | rbase
]

{ #category : #accessing }
RTypeParser >> start [
	^ann
]

{ #category : #accessing }
RTypeParser >> tbase [
	^'int' asParser ==> [ :x | SpriteTInt instance ]
]
