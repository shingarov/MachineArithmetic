Class {
	#name : #RTypeParser,
	#superclass : #RefinementParser,
	#instVars : [
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
RTypeParser >> start [
	^annot annotationBrackets trim
]
