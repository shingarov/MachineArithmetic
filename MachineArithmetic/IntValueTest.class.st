Class {
	#name : #IntValueTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests'
}

{ #category : #tests }
IntValueTest >> testAdd [
	| x y |
	x := 3 asBitVector: 32.
	y := 4 asBitVector: 32.
	self assert: (x + y) asInteger equals: 7.
]

{ #category : #tests }
IntValueTest >> testAddAdaptation [
	| x |
	x := 42 asBitVector: 32.
	self assert: (x+1) asInteger equals: 43.
	self assert: (1+x) asInteger equals: 43.
]

{ #category : #tests }
IntValueTest >> testAddOverflow [
	| x |
	x := 16rFFFF asBitVector: 16.
	self assert: (x+1) asInteger equals: 0
]

{ #category : #tests }
IntValueTest >> testBasicCreation [
	| x |
	x := IntValue value: 42 length: 32.
	self assert: x length equals: 32.
	self assert: x value  equals: 42.
]

{ #category : #tests }
IntValueTest >> testConcat [
	| x y xy |
	x := 16r1111 asBitVector: 16.
	y := 16r2222 asBitVector: 16.
	xy := x, y.
	self assert: xy length equals: 32.
	self assert: xy asInteger equals: 16r11112222.
]

{ #category : #tests }
IntValueTest >> testConversion [
	| x |
	x := 42 asBitVector: 32.
	self assert: x value  equals: 42.
	self assert: x length equals: 32.
	self assert: x asInteger equals: 42.
]

{ #category : #tests }
IntValueTest >> testIsSymbolic [
	| x |
	x := 3 asBitVector: 32.
	self deny: x isSymbolic
]

{ #category : #tests }
IntValueTest >> testNegative [
	| x |
	x := IntValue value: -1 length: 32.
	self assert: x length equals: 32.
	self assert: x value equals: 16rFFFFFFFF.
	self assert: x signedValue equals: -1.
]

{ #category : #tests }
IntValueTest >> testOnes [
	| o |
	o := 16 ones.
	self assert: o asInteger equals: 16rFFFF.
	self assert: o length equals: 16.
	self assert: o value equals:16rFFFF
]

{ #category : #tests }
IntValueTest >> testRetrieve [
	| int var retrieved |
	int := 42 asBitVector: 32.
	var := int var.
	retrieved := var value.
	self assert: (retrieved isKindOf: IntValue).
	self assert: retrieved value equals: 42.
	self assert: retrieved length equals: 32.

	"magic"
	self assert: retrieved equals: int
	
]

{ #category : #tests }
IntValueTest >> testReverseEndian [
	| int |
	int := 16r11223344 asBitVector: 32.
	self assert: int reversed asInteger equals: 16r44332211
	
]

{ #category : #tests }
IntValueTest >> testShift [
	| x shamt |
	x := 1 asBitVector: 32.
	shamt := 4 asBitVector: 32.
	self assert: (x<<shamt) asInteger equals: 1<<4
]

{ #category : #tests }
IntValueTest >> testShiftAdaptation [
	"Hmmm, this one is tricky!"
]

{ #category : #tests }
IntValueTest >> testShiftConcreteShamt [
	| x |
	x := 1 asBitVector: 32.
	self assert: (x<<4) asInteger equals: 1<<4
]

{ #category : #tests }
IntValueTest >> testSlicing [
	| x a b c d all |
	x := 16r1234ABCD asBitVector: 32.
	a := x copyFrom: 15 to: 12.
	self assert: a equals: 16rA.
	b := x copyFrom: 11 to: 8.
	self assert: b equals: 16rB.
	c := x copyFrom: 7 to: 4.
	self assert: c equals: 16rC.
	d := x copyFrom: 3 to: 0.
	self assert: d equals: 16rD.
	all := x copyFrom: 31 to: 0.
	self assert: all equals: x
]

{ #category : #tests }
IntValueTest >> testZeros [
	| z |
	z := 16 zeros.
	self assert: z asInteger equals: 0.
	self assert: z length equals: 16.
	self assert: z value equals: 0
]
