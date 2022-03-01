Extension { #name : #Integer }

{ #category : #'*Refinements' }
Integer >> bindSymbol [
	"Extremely ugly transliteration from LiquidFixpoint."
	^'bßºº', self asString
]
