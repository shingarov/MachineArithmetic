Extension { #name : #Integer }

{ #category : #'*Refinements' }
Integer >> bindSymbol [
	"Extremely ugly transliteration from LiquidFixpoint."
	"Note that it is possible to use these symbols because this will be a variable name in Z3, but never Smalltalk-compiled."
	^'b$##', self asString
]
