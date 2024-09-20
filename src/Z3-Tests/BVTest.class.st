"
Concrete BitVector tests approximately equivalent to claripy.test_bv
"
Class {
	#name : #BVTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Z3-Tests'
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
	self assert: a + 8 equals: 9.
	self assert: a >> 1 equals: 0.
	self assert: b >> 1 equals: 1.
]

{ #category : #bv }
BVTest >> testBvC [
	| c |
	c := 128 toBitVector: 8.
	self assert: c signedValue  equals: -128.
	self assert: c >> 1  equals: 64.      
	self assert: c >> 7  equals: 1.

	self assert: (c bitShiftRightArithmetic: 1)  equals: -64.      
	self assert: (c bitShiftRightArithmetic: 7)  equals: -1.
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

{ #category : #bv }
BVTest >> testCoerceBitAnd [
	| x |
	x := 2r10101010 toBitVector: 8.
	self assert: x & 16rF0 equals: 2r10100000
]

{ #category : #bv }
BVTest >> testCoerceSignedModulo [
	"9 \\ -4 >>> -3"
	| nine |
	nine := 9 toBitVector: 32.
	self
		assert: (nine \\ -4) signedValue
		equals: -3
]

{ #category : #bv }
BVTest >> testCoerceSignedRemainder [
	"9 \\ -4 >>> -3"
	| nine |
	nine := 9 toBitVector: 32.
	self
		assert: (nine srem: -4) signedValue
		equals: 1
]

{ #category : #limits }
BVTest >> testLimits32 [
	| sort |

	sort := Z3Sort bv: 32.

	self assert: sort uminVal equals: 0.
	self assert: sort umaxVal equals: 16rFFFFFFFF.

	self assert: sort sminVal equals:-16r80000000.
	self assert: sort smaxVal equals: 16r7FFFFFFF.
]

{ #category : #limits }
BVTest >> testLimits5 [
	| sort |

	sort := Z3Sort bv: 5.

	self assert: sort uminVal equals: 0.
	self assert: sort umaxVal equals: 31.

	self assert: sort sminVal equals:-16.
	self assert: sort smaxVal equals: 15
]

{ #category : #limits }
BVTest >> testLimits8 [
	| sort |

	sort := Z3Sort bv: 8.

	self assert: sort uminVal equals: 0.
	self assert: sort umaxVal equals: 255.

	self assert: sort sminVal equals: -128.
	self assert: sort smaxVal equals:  127
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
