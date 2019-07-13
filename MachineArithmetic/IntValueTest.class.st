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
IntValueTest >> testBasicCreation [
	| x |
	x := IntValue value: 42 length: 32.
	self assert: x length equals: 32.
	self assert: x value  equals: 42.
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
