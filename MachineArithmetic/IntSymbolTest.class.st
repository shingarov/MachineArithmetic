Class {
	#name : #IntSymbolTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests'
}

{ #category : #tests }
IntSymbolTest >> testAdd0 [
	| x zero |
	x := IntSymbol sym: 'x' length: 32.
	zero := 0 asBitVector: 32.
	self assert: (x + zero isKindOf: IntSymbol)
]

{ #category : #tests }
IntSymbolTest >> testAdd1 [
	| x one sum |
	x := IntSymbol sym: 'x' length: 32.
	one := 1 asBitVector: 32.
	sum := x + one.
	self assert: sum op equals: '__add__'
]

{ #category : #tests }
IntSymbolTest >> testBasicCreation [
	| x |
	x := IntSymbol sym: 'x' length: 32.
	self assert: x sym    equals: 'x'.
	self assert: x length equals: 32.
]

{ #category : #tests }
IntSymbolTest >> testSubtractSelf [
	| x1 x2 diff |
	x1 := IntSymbol sym: 'x' length: 32.
	x2 := IntSymbol sym: 'x' length: 32.
	diff := x1 - x2.
	self assert: diff asInteger equals: 0
]
