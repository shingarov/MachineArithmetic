Extension { #name : #Integer }

{ #category : #'*SpriteLang' }
Integer >> kVar [
	"1 kVar >>> 'k_ºº1'
	"
	^'k_' suffixSymbol: self printString 
]

{ #category : #'*SpriteLang' }
Integer >> nonRigidTV [
	^'fv' intSymbol: self
]

{ #category : #'*SpriteLang' }
Integer >> pappSym [
"
pappSym :: Int -> F.Symbol
"
	^'papp', self printString
]
