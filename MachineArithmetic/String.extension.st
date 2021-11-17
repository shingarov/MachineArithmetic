Extension { #name : #String }

{ #category : #'*MachineArithmetic' }
String >> /// length [
	^self toBitVector: length

]

{ #category : #'*MachineArithmetic' }
String >> functionFrom: domainSorts to: rangeSort [
	^self asZ3Symbol mkFuncFrom: domainSorts to: rangeSort
]

{ #category : #'*MachineArithmetic' }
String >> intSymbol: i [
	"Ugly transliteration from LiquidFixpoint.
	Please someone get rid of this."
	^self suffixSymbol: i printString
]

{ #category : #'*MachineArithmetic' }
String >> kArgSymbol: k [
	"Ugly transliteration from LiquidFixpoint.
	Please someone get rid of this."
	^'lq_kargß', self  suffixSymbol: k
]

{ #category : #'*MachineArithmetic' }
String >> kArgs: aCollection [ 
	^aCollection collectWithIndex: [ :_v :j | self κ: j ]
]

{ #category : #'*MachineArithmetic' }
String >> oneSuka: xs [
	| eVars |
	eVars := xs collect: #toEVar.
	^(self kArgs: eVars) zip: eVars
]

{ #category : #'*MachineArithmetic' }
String >> subst: θ [
	θ list do: [ :from_to | from_to key = self ifTrue: [ ^from_to value ] ].
	^self
]

{ #category : #'*MachineArithmetic' }
String >> suffixSymbol: s [
	"Ugly transliteration from LiquidFixpoint.
	Please someone get rid of this."
	^self, 'ºº', s
]

{ #category : #'*MachineArithmetic' }
String >> toBitVector: xlen [
	^BitVector sym: self length: xlen
]

{ #category : #'*MachineArithmetic' }
String >> toBool [
	^Bool var: self
]

{ #category : #'*MachineArithmetic' }
String >> toEVar [
	^EVar of: self
]

{ #category : #'*MachineArithmetic' }
String >> toInt [
	^Int const: self
]

{ #category : #'*MachineArithmetic' }
String >> toZ3Symbol [
	^Z3Symbol from: self
]

{ #category : #'*MachineArithmetic' }
String >> varSubscript: i [
	"Ugly transliteration from LiquidFixpoint.
	Please someone get rid of this."
	^self, 'º', i printString
]

{ #category : #'*MachineArithmetic' }
String >> κ: i [
	"Ugly transliteration from LiquidFixpoint.
	Please someone get rid of this."
	^'kkargß', self, 'º', i printString
]
