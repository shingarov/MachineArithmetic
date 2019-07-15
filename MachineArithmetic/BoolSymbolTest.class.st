Class {
	#name : #BoolSymbolTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests'
}

{ #category : #tests }
BoolSymbolTest >> testBasicCreation [
	| x |
	x := BoolSymbol sym: 'x'.
	self assert: x sym equals: 'x'.
	self assert: x isLeaf.
	self assert: (x variables includes: 'x')
]

{ #category : #tests }
BoolSymbolTest >> testConjunct [
	| x y z |
	x := BoolSymbol sym: 'x'.
	y := BoolSymbol sym: 'y'.
	z := x & y.  "debug here"
	self assert: x isLeaf.
	self deny: z isLeaf
]

{ #category : #tests }
BoolSymbolTest >> testTautology [
	| x y |
	x := BoolSymbol sym: 'x'.
	y := x | x not.
	self assert: y
]

{ #category : #tests }
BoolSymbolTest >> testUnsat [
	| x y |
	x := BoolSymbol sym: 'x'.
	y := x & x not.
	self deny: y
]
