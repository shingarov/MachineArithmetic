Extension { #name : #Integer }

{ #category : #'*SpriteLang' }
Integer >> kVar [
	"1 kVar >>> 'k_ºº1'
	"
	^'k_' suffixSymbol: self printString 
]
