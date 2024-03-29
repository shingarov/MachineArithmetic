Class {
	#name : #MeasureParser,
	#superclass : #RefinementParser,
	#category : #'SpriteLang-Parsing'
}

{ #category : #grammar }
MeasureParser >> measure [
	^(self tyBindP: 'measure')
	==> [ :x | x first -> x second generalize sort ]
]

{ #category : #grammar }
MeasureParser >> start [
"measureP :: FP.Parser (F.Symbol, F.Sort)"
	^self measure
]
