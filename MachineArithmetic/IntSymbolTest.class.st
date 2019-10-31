Class {
	#name : #IntSymbolTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests-Algebra'
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
IntSymbolTest >> testLeafSubstitution [
	| x env result |
	env := Dictionary new
		at: 'x' put: 1;
		at: 'y' put: 2;
		yourself.
	x := IntSymbol sym: 'x' length: 32.
	result := x inEnvironment: env.
	self assert: result isLeaf.
	self deny: result isSymbolic.
	self assert: result value equals: 1.
	
	env := Dictionary new
		at: 'x' put: (IntSymbol sym: 'z' length: 32);
		at: 'y' put: 2;
		yourself.
	result := x inEnvironment: env.
	self assert: result isLeaf.
	self assert: result isSymbolic.
	self assert: result sym equals: 'z'.
	
	env := Dictionary new.
	result := x inEnvironment: env.
	self assert: result equals: x
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
IntSymbolTest >> testPyAttributeAccess [
	| o |
	o := 'x' asBitVector: 32. "should be something simple and not depend on claripy"
	self assert: (o isKindOf: External).
	o at: 'length' put: 64.
	self assert: (o at: 'length') equals: 64.
]

{ #category : #tests }
IntSymbolTest >> testSendList [
	| x y list answer |
	x := IntValue value: 1234 length: 32.
	y := IntValue value: 5678 length: 32.
	list := Array with: x with: y.
	answer := P sendAndAssignList: list.
	self assert: (P compute: answer ref, '[0]') equals: x.
	self assert: (P compute: answer ref, '[1]') equals: y.
]

{ #category : #tests }
IntSymbolTest >> testSlicing [
	| x a b a1 b1 |
	a := 16r1234 asBitVector: 16.
	b := IntSymbol sym: 'b' length: 16.
	x := a, b.
	
	a1 := x copyFrom: 31 to: 16.
	self assert: a1 length equals: 16.
	self assert: a equals: 16r1234.
	
	b1 := x copyFrom: 15 to: 0.
	self assert: b1 length equals: 16.
	self assert: b sym equals: 'b'.
	
	"magic"
	self assert: a1,b1 equals: x
]

{ #category : #tests }
IntSymbolTest >> testSlicingInterval [
	| x a b a1 b1 |
	a := 16r1234 asBitVector: 16.
	b := IntSymbol sym: 'b' length: 16.
	x := a, b.

	a1 := x subrange: (31 to: 16 by: -1).
	self assert: a1 length equals: 16.
	self assert: a equals: 16r1234.
	
	b1 := x subrange: (15 to: 0 by: -1).
	self assert: b1 length equals: 16.
	self assert: b sym equals: 'b'.
	
	"magic"
	self assert: a1,b1 equals: x
]

{ #category : #tests }
IntSymbolTest >> testSubstitution [
	| x ast env result |
	env := Dictionary new
		at: 'x' put: 3;
		at: 'y' put: 42;
		yourself.
	x := IntSymbol sym: 'x' length: 32.
	ast := x + 4.
	self assert: ast isSymbolic.
	result := ast inEnvironment: env.
	self assert: result isLeaf.
	self deny: result isSymbolic.
	self assert: result value equals: 3+4
]

{ #category : #tests }
IntSymbolTest >> testSubtractSelf [
	| x1 x2 diff |
	x1 := IntSymbol sym: 'x' length: 32.
	x2 := IntSymbol sym: 'x' length: 32.
	diff := x1 - x2.
	self assert: diff asInteger equals: 0
]
