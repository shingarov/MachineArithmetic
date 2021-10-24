"
Concrete BitVector tests approximately equivalent to claripy.test_bv
"
Class {
	#name : #BVTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-Tests-SMT'
}

{ #category : #rewriting }
BVTest >> doTestThisEnvironment: x [
	| y z bv |
	y := 2r0000.
	z := 2r0000.
	bv := self vector10101010XXXXYYYY inThisEnvironment.
	self assert: bv equals: 2r1010101011110000
]

{ #category : #bv }
BVTest >> testBvAB [
	| a b |
	a := 1 toBitVector: 8.
	b := 2 toBitVector: 8.
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
	c := 128 toBitVector: 8.
	self assert: c signedValue  equals: -128
]

{ #category : #bv }
BVTest >> testBvD [
	| d |
	d := 255 toBitVector: 8.
	self assert: (d copyFrom: 1 to: 0) equals: 3. "extract"
	
	
]

{ #category : #bv }
BVTest >> testBvDiv [
	self assert: ((5 toBitVector: 8) udiv: (254 toBitVector: 8)) equals: 0.
	self assert: ((5 toBitVector: 8) / (-2 toBitVector: 8)) equals: -2

]

{ #category : #bv }
BVTest >> testBvEF [
	| e conc f |
	e := 2r1010 toBitVector: 4.
	conc := e, e, e, e.
	self assert: conc equals: 2r1010101010101010.
	self assert: conc length equals: 16.
	f := 2r11 toBitVector: 2.
	self assert: e, f, f equals: 2r10101111
	
]

{ #category : #rewriting }
BVTest >> testThisEnvironment [
	self doTestThisEnvironment: 2r1111
]

{ #category : #'zero_length' }
BVTest >> testZeroLengthConcat [
	| a b |
	a := 1 toBitVector: 8.
	b := 0 toBitVector: 0.
	self assert: a, b equals: 1.
	self assert: b, a equals: 1.
	self assert: b equals: b
]

{ #category : #rewriting }
BVTest >> vector10101010XXXXYYYY [
	^(2r10101010 toBitVector: 8), ('x' toBitVector: 4), ('y' toBitVector: 4)
]
