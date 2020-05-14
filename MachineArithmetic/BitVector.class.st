Class {
	#name : #BitVector,
	#superclass : #AST,
	#category : #'MachineArithmetic-Core'
}

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
	xlen = 0 ifTrue: [ ^EmptyBitVector instance ].
	bvSort := Z3Sort bv: xlen.
	^AST numeral: anInteger printString ofSort: bvSort
]

{ #category : #arithmetic }
BitVector >> & y [ 
	^(LibZ3 uniqueInstance  mkBVand: ctx t1: self t2: (self beLikeMe: y))
		ctx: ctx
]

{ #category : #arithmetic }
BitVector >> * y [
	"Two's complement multiplication."
	^(LibZ3 uniqueInstance  mkBVmul: ctx t1: self t2: (self beLikeMe: y))
		ctx: ctx
]

{ #category : #arithmetic }
BitVector >> + y [
	"Two's complement addition."
	^(LibZ3 uniqueInstance  mkBVadd: ctx t1: self t2: (self beLikeMe: y))
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
	^(LibZ3 uniqueInstance  mkBVsub: ctx t1: self t2: (self beLikeMe: y))
		ctx: ctx
]

{ #category : #arithmetic }
BitVector >> / y [
	"Unsigned division"
	^(LibZ3 uniqueInstance  mkBVudiv: ctx t1: self t2: (self beLikeMe: y))
		ctx: ctx
]

{ #category : #arithmetic }
BitVector >> /- y [
	"Two's complement signed division"
	^(LibZ3 uniqueInstance  mkBVsdiv: ctx t1: self t2: (self beLikeMe: y))
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
		t2: (self beLikeMe: shamt)) "This is on purpose: in Z3 self and shamt must be same length"
	ctx: ctx
]

{ #category : #arithmetic }
BitVector >> <= y [
	"Two's complement signed less than or equal."
	^(LibZ3 uniqueInstance  mkBVsle: ctx t1: self t2: (self beLikeMe: y))
		ctx: ctx
]

{ #category : #testing }
BitVector >> = anotherObject [
	| y |
	y := [ self beLikeMe: anotherObject ] on: Error do: [^false].
	^super = y
]

{ #category : #converting }
BitVector >> asBitVector: xlen [
	self length = xlen ifFalse: [ self error: 'bit length mismatch' ].
	^self
]

{ #category : #converting }
BitVector >> beLikeMe: aNumber [
	^aNumber asBitVector: self length
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
BitVector >> signedValue [
	| unsignedValue topBit |
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

{ #category : #arithmetic }
BitVector >> | y [
	"Bitwise or"
	^(LibZ3 uniqueInstance  mkBVor: ctx t1: self t2: (self beLikeMe: y))
		ctx: ctx
]
