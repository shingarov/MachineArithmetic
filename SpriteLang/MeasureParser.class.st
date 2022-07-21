Class {
	#name : #MeasureParser,
	#superclass : #RefinementParser,
	#category : #SpriteLang
}

{ #category : #grammar }
MeasureParser >> measure [
	^(self tyBindP: 'measure')
	==> [ :x | x symbol -> x rtype generalize sort ]
]

{ #category : #grammar }
MeasureParser >> start [
"measureP :: FP.Parser (F.Symbol, F.Sort)"
	^self measure
]
