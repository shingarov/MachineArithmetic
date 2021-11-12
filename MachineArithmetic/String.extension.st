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
	^self, 'ºº', i printString
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
	^'kkarg', self, 'ß', i printString
]
