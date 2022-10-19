Extension { #name : #String }

{ #category : #'*Refinements' }
String >> intSymbol: i [
	"Ugly transliteration from LiquidFixpoint.
	Please someone get rid of this."
	^self suffixSymbol: i printString
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
String >> subst: θ [
	θ list do: [ :from_to | from_to key = self ifTrue: [ ^from_to value ] ].
	^self
]

{ #category : #'*Refinements' }
String >> suffixSymbol: s [
	"Ugly transliteration from LiquidFixpoint.
	Please someone get rid of this."
	^self, 'ºº', s
]

{ #category : #'*Refinements' }
String >> tempSymbol: i [ 
	^'lq_tmpß', self intSymbol: i
]

{ #category : #'*Refinements' }
String >> toEVar [
	^FxEVar of: self
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
String >> κ: i [
	"Ugly transliteration from LiquidFixpoint.
	Please someone get rid of this."
	^'kkargß', self, 'º', i printString
]
