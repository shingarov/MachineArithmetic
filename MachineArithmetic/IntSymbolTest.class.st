Class {
	#name : #IntSymbolTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests-Algebra'
}

{ #category : #running }
IntSymbolTest >> setUp [
	Z3Context createGlobalContext 
]

{ #category : #running }
IntSymbolTest >> tearDown [
	Z3Context current del
]

{ #category : #tests }
IntSymbolTest >> testAdd0 [
	| x zero sum |
	x := BitVector sym: 'x' length: 32.
	zero := 0 asBitVector: 32.
	sum := (x + zero) simplify.
	self assert: sum isBitVector.
	self assert: sum length equals: 32.
	self assert: sum sym equals: 'x'.
	self assert: sum equals: x
]

{ #category : #tests }
IntSymbolTest >> testAdd1 [
	| x one sum |
	x := BitVector sym: 'x' length: 32.
	one := 1 asBitVector: 32.
	sum := x + one.
	self assert: sum isBitVector.
	self assert: sum isSymbolic.
	self deny:   sum isNumeral.
	
]

{ #category : #tests }
IntSymbolTest >> testBasicCreation [
	| x |
	x := BitVector sym: 'x' length: 32.
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
IntSymbolTest >> testLeafSubstituteBVToInteger [
	| x env result |
	env := Dictionary new
		at: 'x' put: 111;
		at: 'y' put: 222;
		yourself.
	x := BitVector sym: 'x' length: 32.
	result := x inEnvironment: env.
	self assert: result isBitVector.
	self assert: result term isLeaf.
	self deny: result isSymbolic.
	self assert: result value equals: 111
]

{ #category : #tests }
IntSymbolTest >> testLeafSubstituteExplicitBVToInteger [
	| x env result |
	env := Dictionary new
		at: ('x' asBitVector: 32) put: (100 asBitVector: 32);
		at: ('y' asBitVector: 32) put: (200 asBitVector: 32);
		yourself.
	x := BitVector sym: 'x' length: 32.
	result := x inEnvironment: env.
	self assert: result isBitVector.
	self assert: result term isLeaf.
	self deny: result isSymbolic.
	self assert: result value equals: 100
]

{ #category : #tests }
IntSymbolTest >> testLeafSubstituteIntToInteger [
	| x env result |
	env := Dictionary new
		at: 'x' put: 1;
		at: 'y' put: 2;
		yourself.
	x := Int var: 'x'.
	result := x inEnvironment: env.
	self assert: result isInt.
	self assert: result term isLeaf.
	self deny: result isSymbolic.
	self assert: result value equals: 1
]

{ #category : #tests }
IntSymbolTest >> testLeafSubstituteMiss [
	| x env result |
	x := BitVector sym: 'x' length: 32.
	env := Dictionary new.
	result := x inEnvironment: env.
	self assert: result equals: x
]

{ #category : #tests }
IntSymbolTest >> testLeafSubstituteToNumeral [
	| x env result |
	env := Dictionary new
		at: 'x' put: (1 asBitVector: 32);
		at: 'y' put: (2 asBitVector: 32);
		yourself.
	x := BitVector sym: 'x' length: 32.
	result := x inEnvironment: env.
	self assert: result isBitVector.
	self assert: result term isLeaf.
	self deny: result isSymbolic.
	self assert: result value equals: 1
]

{ #category : #tests }
IntSymbolTest >> testLeafSubstituteToSymbol [
	| x env result |
	x := BitVector sym: 'x' length: 32.
	env := Dictionary new
		at: 'x' put: (BitVector sym: 'z' length: 32);
		at: 'y' put: 2;
		yourself.
	result := x inEnvironment: env.
	self assert: result term isLeaf.
	self assert: result isSymbolic.
	self assert: result sym equals: 'z'
]

{ #category : #tests }
IntSymbolTest >> testLeafVariable [
	| x y |
	x := BitVector sym: 'x' length: 32.
	y := BitVector sym: 'y' length: 32.
	self assert: (x variables includes: x).
	self deny:   (y variables includes: x).

]

{ #category : #tests }
IntSymbolTest >> testNumeralHasNoVariables [
	| one |
	one := 1 asBitVector: 32.
	self assert: one variables isEmpty
]

{ #category : #tests }
IntSymbolTest >> testSlicing [
	| x a b a1 b1 |
	a := 16r1234 asBitVector: 16.
	b := BitVector sym: 'b' length: 16.
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
IntSymbolTest >> testSubstitution [
	| x ast env result |
	env := Dictionary new
		at: 'x' put: 3;
		at: 'y' put: 42;
		yourself.
	x := BitVector sym: 'x' length: 32.
	ast := x + 4.
	self assert: ast isSymbolic.
	result := ast inEnvironment: env.
	self assert: result isSymbolic.
	self assert: result value equals: 3+4.
	result := result simplify.	
	self deny: result isSymbolic.
	self assert: result value equals: 3+4.
]

{ #category : #tests }
IntSymbolTest >> testSubtractSelf [
	| x1 x2 diff |
	x1 := BitVector sym: 'x' length: 32.
	x2 := BitVector sym: 'x' length: 32.
	diff := x1 - x2.
	self assert: diff value equals: 0
]

{ #category : #tests }
IntSymbolTest >> testVariableNames [
	| x y z |
	x := BitVector sym: 'x' length: 32.
	y := BitVector sym: 'y' length: 32.
	self assert: ((x + 1) variableNames includes: 'x').
	self deny:   ((x + 1) variableNames includes: 'y').
	z := x + y.
	self assert: (z variableNames includes: 'x').
	self assert: (z variableNames includes: 'y').
	self deny:   (z variableNames includes: 'z').
	
]

{ #category : #tests }
IntSymbolTest >> testVariables [
	| x y z |
	x := BitVector sym: 'x' length: 32.
	y := BitVector sym: 'y' length: 32.
	self assert: ((x + 1) variables includes: x).
	self deny:   ((x + 1) variables includes: y).
	z := x + y.
	self assert: (z variables includes: x).
	self assert: (z variables includes: y).
]
