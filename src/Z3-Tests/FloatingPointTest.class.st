Class {
	#name : #FloatingPointTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Z3-Tests'
}

{ #category : #tests }
FloatingPointTest >> testArithmetic [

	| a b aVal bVal |
	aVal := 3.5.
	bVal := -7.8.
	a := aVal toFloatingPoint: 64.
	b := bVal toFloatingPoint: 64.

	self assert: a + bVal equals: aVal + bVal.
	self assert: a - bVal equals: aVal - bVal.
	self assert: a * b equals: aVal * bVal.
	self assert: a / b equals: aVal / bVal.
	self assert: (a rem: b) equals: (aVal rem: bVal).
	self assert: a sqrt equals: aVal sqrt.
	self assert: b abs equals: bVal abs.
	self assert: b neg equals: bVal negated
]

{ #category : #tests }
FloatingPointTest >> testInf [

	| ctxt solver model a b |
	
	ctxt := Z3Context current.

	solver := ctxt mkSolver.
	a := 'a' toFloatingPoint: 64.
	b := 'b' toFloatingPoint: 64.

	solver assert: a isInfinite.
	solver assert: a === b.

	self assert: solver check.
	
	model := solver getModel constants.

	self assert: (model at: 'b') isInfinite
	
]

{ #category : #tests }
FloatingPointTest >> testNan [

	| ctxt solver a b |
	
	ctxt := Z3Context current.

	solver := ctxt mkSolver.
	a := 'a' toFloatingPoint: 64.
	b := 'b' toFloatingPoint: 64.

	solver assert: a isNaN.
	solver assert: a === b.

	self deny: solver check.
	
]
