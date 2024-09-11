"
These tests correspond to L8uniqueVoid.smt2 on our experiment-z3datatypes
branch of liquid-fixpoint, see dbd390e:
https://github.com/shingarov/liquid-fixpoint/commit/dbd390e323a96f5c973c5bd6285a10b066340b0b
at the lowest (SMT) level of the test-ladder, cf:
https://github.com/shingarov/sprite-lang/commit/248f59b7758befa7a812b1981b43999a8c45adb6

"
Class {
	#name : #Z3DatatypeTest,
	#superclass : #TestCase,
	#category : #'Z3-Tests-ADT'
}

{ #category : #running }
Z3DatatypeTest >> testUniqueIntegerNeg [
	| V x y |
	V := Int sort.
	x := V mkConst: 'x'.
	y := V mkConst: 'y'.
	self deny: (x===y) isValid
]

{ #category : #running }
Z3DatatypeTest >> testUniqueVoid [
	| V x y |
	V := Z3Datatype named: 'V'.
	V declare: 'Nil'.
	V := V create.
	x := V mkConst: 'x'.
	y := V mkConst: 'y'.
	self assert: (x===y) isValid
]

{ #category : #running }
Z3DatatypeTest >> testUniqueVoidNeg [
	| V x y solver model xConsName yConsName |
	V := Z3Datatype named: 'V'.
	V declare: 'One'.
	V declare: 'Two'.
	V := V create.
	x := V mkConst: 'x'.
	y := V mkConst: 'y'.
	"exactly two counterexamples"
	solver := Z3Solver new.
	model := (solver findCounterexample: x===y) constants.
	xConsName := (model at: 'x') functorName.
	yConsName := (model at: 'y') functorName.
	self assert: (xConsName='One' and: yConsName='Two')
	           | (yConsName='One' and: xConsName='Two').
	solver release
]
