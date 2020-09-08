"
Tests for the most basic fuctionality of concrete BitVectors.
"
Class {
	#name : #IntValueTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests'
}

{ #category : #running }
IntValueTest >> setUp [
	Z3Context createGlobalContext 
]

{ #category : #running }
IntValueTest >> tearDown [
	Z3Context current del
]

{ #category : #'tests - arithmetic' }
IntValueTest >> testAdd8 [
	| a |
	a := 1 toBitVector: 8.
	self assert: (a + 8) equals: 9.
]

{ #category : #'tests - arithmetic' }
IntValueTest >> testAddAdaptation [
	| x |
	x := 42 toBitVector: 32.
	self assert: (x+1) value equals: 43.
	self assert: (1+x) value equals: 43.
]

{ #category : #'tests - arithmetic' }
IntValueTest >> testAddOverflow [
	| x |
	x := 16rFFFF toBitVector: 16.
	self assert: (x+1) value equals: 0
]

{ #category : #'tests - logical operations' }
IntValueTest >> testAnd [
	| a b |
	a := 1 toBitVector: 8.
	b := 2 toBitVector: 8.
	self assert: a & b equals: 0
]

{ #category : #'tests - shifting' }
IntValueTest >> testAsBE [
	| bv byteArray |
	bv:= 16r0A0B0C0D toBitVector: 32.
	byteArray := bv asBEByteArray.
	self assert: byteArray first equals: 16r0A.
	self assert: byteArray last  equals: 16r0D.
]

{ #category : #'tests - shifting' }
IntValueTest >> testAsLE [
	| bv byteArray |
	bv:= 16r0A0B0C0D toBitVector: 32.
	byteArray := bv asLEByteArray.
	self assert: byteArray first equals: 16r0D.
	self assert: byteArray last  equals: 16r0A.
]

{ #category : #'tests - basic' }
IntValueTest >> testBasicCreation [
	| x |
	x := BitVector value: 42 length: 32.
	self assert: x length equals: 32.
	self assert: x value  equals: 42.
]

{ #category : #'tests - logical operations' }
IntValueTest >> testBitInvertInvert [
	| x |
	x := 'x' toBitVector: 32.
	self assert: x bitInvert bitInvert equals: x
]

{ #category : #'tests - logical operations' }
IntValueTest >> testBitInvertOne [
	| a |
	a := 1 toBitVector: 8.
	self assert: a bitInvert equals: 254
]

{ #category : #'tests - logical operations' }
IntValueTest >> testBitInvertZero [
	| zero |
	zero := 0 toBitVector: 8.
	self assert: zero bitInvert equals: 255
]

{ #category : #'tests - arithmetic' }
IntValueTest >> testBitRotateRight2 [
	| x rotated |
	x := 16rFF toBitVector: 32.
	rotated := (x rotateRight: 2) simplify.
	self assert: rotated equals: 16rC000003F
]

{ #category : #'tests - arithmetic' }
IntValueTest >> testBitRotateRight28 [
	| x rotated |
	x := 16rFF toBitVector: 32.
	rotated := (x rotateRight: 28) simplify.
	self assert: rotated equals: 16rFF0
]

{ #category : #'tests - basic' }
IntValueTest >> testConcat [
	| x y xy |
	x := 16r1111 toBitVector: 16.
	y := 16r2222 toBitVector: 16.
	xy := x, y.
	self assert: xy length equals: 32.
	self assert: xy value equals: 16r11112222.
]

{ #category : #'tests - basic' }
IntValueTest >> testConversion [
	| x |
	x := 42 toBitVector: 32.
	self assert: x value  equals: 42.
	self assert: x length equals: 32.
]

{ #category : #'tests - basic' }
IntValueTest >> testIsSymbolic [
	| x |
	x := 3 toBitVector: 32.
	self deny: x isSymbolic
]

{ #category : #'tests - arithmetic' }
IntValueTest >> testNegative [
	| x |
	x := BitVector value: -1 length: 32.
	self assert: x length equals: 32.
	self assert: x value equals: 16rFFFFFFFF.
	self assert: x signedValue equals: -1.
]

{ #category : #'tests - arithmetic' }
IntValueTest >> testOnes [
	| o |
	o := 16 ones.
	self assert: o length equals: 16.
	self assert: o value equals:16rFFFF
]

{ #category : #'tests - logical operations' }
IntValueTest >> testOr [
	| a b |
	a := 1 toBitVector: 8.
	b := 2 toBitVector: 8.
	self assert: a | b equals: 3
]

{ #category : #'tests - shifting' }
IntValueTest >> testReverseEndian [
	"| int |
	int := 16r11223344 asBitVector: 32.
	self assert: int reversed asInteger equals: 16r44332211
	"
	self flag: 'very complex simplification logic in claripy'
]

{ #category : #'tests - shifting' }
IntValueTest >> testShift [
	| x shamt |
	x := 1 toBitVector: 32.
	shamt := 4 toBitVector: 32.
	self assert: (x<<shamt) value equals: 1<<4
]

{ #category : #'tests - shifting' }
IntValueTest >> testShiftAdaptation [
	"Hmmm, this one is tricky!"
]

{ #category : #'tests - shifting' }
IntValueTest >> testShiftConcreteShamt [
	| x |
	x := 1 toBitVector: 32.
	self assert: (x<<4) value equals: 1<<4
]

{ #category : #'tests - arithmetic' }
IntValueTest >> testSignedAdd [
	| x |
	x := -3 toBitVector: 16.
	self assert: (x+5) value equals: 2
]

{ #category : #'tests - logical operations' }
IntValueTest >> testSlicing [
	| x a b c d all |
	x := 16r1234ABCD toBitVector: 32.
	a := x copyFrom: 15 to: 12.
	self assert: a value equals: 16rA.
	b := x copyFrom: 11 to: 8.
	self assert: b value equals: 16rB.
	c := x copyFrom: 7 to: 4.
	self assert: c value equals: 16rC.
	d := x copyFrom: 3 to: 0.
	self assert: d value equals: 16rD.
	all := x copyFrom: 31 to: 0.
	self assert: all equals: x
]

{ #category : #'tests - arithmetic' }
IntValueTest >> testThreePlus4 [
	| x y |
	x := 3 toBitVector: 32.
	y := 4.
	self assert: (x + y) value equals: 7.
]

{ #category : #'tests - arithmetic' }
IntValueTest >> testThreePlusFour [
	| x y |
	x := 3 toBitVector: 32.
	y := 4 toBitVector: 32.
	self assert: (x + y) value equals: 7.
]

{ #category : #'tests - basic' }
IntValueTest >> testTooBig [
	"
	This is a reflection of the state of affairs in the code right now,
	and something of a food-for-thought,
	as opposed to testing/stating how things should be.
	See https://github.com/shingarov/MachineArithmetic/issues/3
	"
	| x |
	x := BitVector value: 16rFFFFFFFF length: 4.
	self assert: x length equals: 4.
	self assert: x value  equals: 16r000F.
]

{ #category : #'tests - basic' }
IntValueTest >> testZeros [
	| z |
	z := 16 zeros.
	self assert: z length equals: 16.
	self assert: z value equals: 0
]
