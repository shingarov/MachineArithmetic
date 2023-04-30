Extension { #name : #String }

{ #category : #'*Refinements' }
String class >> dummySymbol [
	^'VV'
]

{ #category : #'*Refinements' }
String >> expr [
"
instance Expression Symbol where
  expr s = eVar s
"
	^self toEVar
]

{ #category : #'*Refinements' }
String >> intSymbol: i [
	"Ugly transliteration from LiquidFixpoint.
	Please someone get rid of this."
	^self suffixSymbol: i printString
]

{ #category : #'*Refinements' }
String >> isListConName [
	^self = '[]'  "listConName in Names.hs"
	or: [ self = 'List' ]  "listLConName in Names.hs"
]

{ #category : #'*Refinements' }
String >> kArgSymbol: k [
	"Ugly transliteration from LiquidFixpoint.
	Please someone get rid of this."
	^'lq_kargß', self  suffixSymbol: k
]

{ #category : #'*Refinements' }
String >> kArgs: aCollection [ 
	^aCollection collectWithIndex: [ :_v :j | self κ: j ]
]

{ #category : #'*Refinements' }
String class >> litPrefix [
	^'litß'
]

{ #category : #'*Refinements' }
String >> numSym: i [ 
	i=0 ifTrue: [^self].
	^self varSubscript: i
]

{ #category : #'*Refinements' }
String >> oneSuka: xs [
	| eVars |
	eVars := xs collect: #toEVar.
	^(self kArgs: eVars) zip: eVars
]

{ #category : #'*Refinements' }
String >> suffixSymbol: s [
	"Ugly transliteration from LiquidFixpoint.
	Please someone get rid of this."
	^self, 'ºº', s
]

{ #category : #'*Refinements' }
String >> symbolFTycon [
"
symbolFTycon :: LocSymbol -> FTycon
symbolFTycon c = symbolNumInfoFTyCon c defNumInfo defRealInfo
"
	^FTycon symbol: self
]

{ #category : #'*Refinements' }
String >> tempSymbol: i [ 
	^'lq_tmpß', self intSymbol: i
]

{ #category : #'*Refinements' }
String >> toEVar [
	^EVar of: self
]

{ #category : #'*Refinements' }
String >> toKVarVertex [
	^KVarVertex kvar: self
]

{ #category : #'*Refinements' }
String >> varSubscript: i [
	"Ugly transliteration from LiquidFixpoint.
	Please someone get rid of this."
	^self, 'º', i printString
]

{ #category : #'*Refinements' }
String class >> vvName [
	"cf. Names.hs"
	^'VV'
]

{ #category : #'*Refinements' }
String class >> vv_ [
	"cf. Refinements.hs"
	^nil vv
]

{ #category : #'*Refinements' }
String >> κ: i [
	"Ugly transliteration from LiquidFixpoint.
	Please someone get rid of this."
	^'kkargß', self, 'º', i printString
]

{ #category : #'*Refinements' }
String >> ≃ [ rhs 
	^false "TODO: proper representation for typevar-names"
]
