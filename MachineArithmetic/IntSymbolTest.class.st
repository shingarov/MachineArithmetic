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
IntSymbolTest >> testIsSymbolic [
	| x |
	x := 'x' asBitVector: 32.
	self assert: (x+1) isSymbolic
]

{ #category : #tests }
IntSymbolTest >> testLeafVariables [
	| x y z |
	x := IntSymbol sym: 'x' length: 32.
	y := IntSymbol sym: 'y' length: 32.
	self assert: ((x + 1) variables includes: 'x').
	self deny:   ((x + 1) variables includes: 'y').
	z := x + y.
	self assert: (z variables includes: 'x').
	self assert: (z variables includes: 'y').
	self deny:   (z variables includes: 'z').
	
]

{ #category : #tests }
IntSymbolTest >> testSubtractSelf [
	| x1 x2 diff |
	x1 := IntSymbol sym: 'x' length: 32.
	x2 := IntSymbol sym: 'x' length: 32.
	diff := x1 - x2.
	self assert: diff asInteger equals: 0
]
