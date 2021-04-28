Class {
	#name : #BitVector,
	#superclass : #Z3Node,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
BitVector class >> concatAll: bitVectors [
	^bitVectors
		inject: self empty
		into: [ :soFar :thisOne | soFar, thisOne ]
]

{ #category : #'instance creation' }
BitVector class >> empty [
	^EmptyBitVector instance
]

{ #category : #printing }
BitVector class >> printSort: ty on: aStream [
	aStream nextPutAll: 'BV';
		nextPutAll: ty getBVSortSize printString
]

{ #category : #'instance creation' }
BitVector class >> sym: variableNameString length: xlen [ 
	^BitVector var: variableNameString ofSort: (Z3Sort bv: xlen)
]

{ #category : #'instance creation' }
BitVector class >> value: anInteger length: xlen [
	| bvSort |
	xlen = 0 ifTrue: [ ^self empty ].
	bvSort := Z3Sort bv: xlen.
	^Z3AST numeral: anInteger printString ofSort: bvSort

]

{ #category : #arithmetic }
BitVector >> & y [ 
	^(LibZ3 uniqueInstance  mkBVand: ctx t1: self t2: (self coerce: y))
		ctx: ctx
]

{ #category : #arithmetic }
BitVector >> * y [
	"Two's complement multiplication."
	^(LibZ3 uniqueInstance  mkBVmul: ctx t1: self t2: (self coerce: y))
		ctx: ctx
]

{ #category : #arithmetic }
BitVector >> + y [
	"Two's complement addition."
	^(LibZ3 uniqueInstance  mkBVadd: ctx t1: self t2: (self coerce: y))
		ctx: ctx
]

{ #category : #slicing }
BitVector >> , anotherBitVector [ 
	"Concatenate two bit strings (not necessarily of the same length)."
	anotherBitVector length = 0 ifTrue: [ ^self ].
	^(LibZ3 uniqueInstance  mkConcat: ctx t1: self t2: anotherBitVector)
		ctx: ctx
]

{ #category : #arithmetic }
BitVector >> - y [
	"Two's complement subtraction."
	^(LibZ3 uniqueInstance  mkBVsub: ctx t1: self t2: (self coerce: y))
		ctx: ctx
]

{ #category : #arithmetic }
BitVector >> / y [
	"Unsigned division"
	^(LibZ3 uniqueInstance  mkBVudiv: ctx t1: self t2: (self coerce: y))
		ctx: ctx
]

{ #category : #arithmetic }
BitVector >> /- y [
	"Two's complement signed division"
	^(LibZ3 uniqueInstance  mkBVsdiv: ctx t1: self t2: (self coerce: y))
		ctx: ctx
]

{ #category : #arithmetic }
BitVector >> < y [
	"Two's complement signed less than"
	^(LibZ3 uniqueInstance  mkBVslt: ctx t1: self t2: y)
		ctx: ctx
]

{ #category : #arithmetic }
BitVector >> << shamt [
	"Shift left"
	^(LibZ3 uniqueInstance
		mkBVshl: ctx
		t1: self
		t2: (self coerce: shamt)) "This is on purpose: in Z3 self and shamt must be same length"
	ctx: ctx
]

{ #category : #arithmetic }
BitVector >> <= y [
	"Two's complement signed less than or equal."
	^(LibZ3 uniqueInstance  mkBVsle: ctx t1: self t2: (self coerce: y))
		ctx: ctx
]

{ #category : #testing }
BitVector >> = anotherObject [
	| y |
	y := [ self coerce: anotherObject ] on: Error do: [^false].
	^super = y
]

{ #category : #converting }
BitVector >> asBEByteArray [
	self isSymbolic ifTrue: [ MustBeConcrete signal ].
	"length of 0 is covered in EmptyBitVector".
	self length == 32 ifFalse: [ self shouldBeImplemented ].
	^ByteArray
		with: (self copyFrom: 31 to: 24) value
		with: (self copyFrom: 23 to: 16) value
		with: (self copyFrom: 15 to: 8)  value
		with: (self copyFrom: 7 to: 0) value

]

{ #category : #converting }
BitVector >> asByteArrayEndian: e [
	e == #big    ifTrue: [ ^self asBEByteArray ].
	e == #little ifTrue: [ ^self asLEByteArray ].
	self error
]

{ #category : #converting }
BitVector >> asLEByteArray [
	self isSymbolic ifTrue: [ MustBeConcrete signal ].
	"length of 0 is covered in EmptyBitVector".
	self length == 32 ifFalse: [ self shouldBeImplemented ].
	^ByteArray
		with: (self copyFrom: 7 to: 0) value
		with: (self copyFrom: 15 to: 8)  value
		with: (self copyFrom: 23 to: 16) value
		with: (self copyFrom: 31 to: 24) value
]

{ #category : #converting }
BitVector >> beLikeMe: value [
	^value toBitVector: self length
]

{ #category : #arithmetic }
BitVector >> bitInvert [
	"Bitwise negation"
	^(LibZ3 uniqueInstance mkBVnot: ctx t1: self)
		ctx: ctx	
]

{ #category : #slicing }
BitVector >> copyFrom: start to: stop [
	"This is like the usual SequenceableCollection>>copyFrom:to:,
	but NB the numbering of bits: right-to-left, the LSB is bit 0."
	^(LibZ3 uniqueInstance mkExtract: ctx high: start low: stop t1: self)
		ctx: ctx	
]

{ #category : #printing }
BitVector >> displaySortOn: aStream [
	aStream nextPutAll: 'bv'
	self shouldBeImplemented 
]

{ #category : #testing }
BitVector >> isBitVector [
	^true
]

{ #category : #access }
BitVector >> length [
	^self sort getBVSortSize  
]

{ #category : #slicing }
BitVector >> repeat: n [
	^(LibZ3 uniqueInstance mkRepeat: ctx i: n t1: self)
		ctx: ctx
]

{ #category : #arithmetic }
BitVector >> rotateLeft: shamt [
	"Rotate right"
	^(LibZ3 uniqueInstance
		mkRotateLeft: ctx
		i: shamt
		t1: self)
	ctx: ctx
]

{ #category : #arithmetic }
BitVector >> rotateRight: shamt [
	"Rotate right"
	^(LibZ3 uniqueInstance
		mkRotateRight: ctx
		i: shamt
		t1: self)
	ctx: ctx
]

{ #category : #arithmetic }
BitVector >> signedValue [
	| unsignedValue topBit |
	self simplify isNumeral ifFalse: [ ^self ].
	unsignedValue := self value.
	topBit := unsignedValue bitAt: self length.
	topBit == 0
		ifTrue: [ ^unsignedValue ]
		ifFalse: [ | onlyTopBit otherBits |
			onlyTopBit := 1 << (self length - 1).
			otherBits := unsignedValue bitXor: onlyTopBit.
			^otherBits - onlyTopBit 
		 ]
	
]

{ #category : #slicing }
BitVector >> subrange: anInterval [
	^(self copyFrom: anInterval first to: anInterval last) simplify
]

{ #category : #converting }
BitVector >> toBitVector: xlen [
	self length = xlen ifFalse: [ self error: 'bit length mismatch' ].
	^self
]

{ #category : #arithmetic }
BitVector >> | y [
	"Bitwise or"
	^(LibZ3 uniqueInstance  mkBVor: ctx t1: self t2: (self coerce: y))
		ctx: ctx
]
