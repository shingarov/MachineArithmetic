"
Concrete BitVector tests approximately equivalent to claripy.test_bv
"
Class {
	#name : #BVTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests-Algebra'
}

{ #category : #bv }
BVTest >> testBvAB [
	| a b |
	a := 1 asBitVector: 8.
	b := 2 asBitVector: 8.
	self assert: a | b equals: 3.
	self assert: a & b equals: 0.
	self assert: a / b equals: 0.
	self assert: b * b equals: 4.
	self assert: a signedValue  equals: a value.
	self assert: a + 8 equals: 9
	
]

{ #category : #bv }
BVTest >> testBvC [
	| c |
	c := 128 asBitVector: 8.
	self assert: c signedValue  equals: -128
]

{ #category : #bv }
BVTest >> testBvD [
	| d |
	d := 255 asBitVector: 8.
	self assert: (d copyFrom: 1 to: 0) equals: 3. "extract"
	
	
]

{ #category : #bv }
BVTest >> testBvDiv [
	self assert: (5 asBitVector: 8) / (254 asBitVector: 8) equals: 0.
	self assert: (5 asBitVector: 8) /- (-2 asBitVector: 8) equals: -2
]

{ #category : #bv }
BVTest >> testBvEF [
	| e conc f |
	e := 2r1010 asBitVector: 4.
	conc := e, e, e, e.
	self assert: conc equals: 2r1010101010101010.
	self assert: conc length equals: 16.
	f := 2r11 asBitVector: 2.
	self assert: e, f, f equals: 2r10101111
	
]

{ #category : #'zero_length' }
BVTest >> testZeroLengthConcat [
	| a b |
	a := 1 asBitVector: 8.
	b := 0 asBitVector: 0.
	self assert: a, b equals: 1.
	self assert: b equals: b
]
