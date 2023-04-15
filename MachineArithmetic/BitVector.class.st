Class {
	#name : #BitVector,
	#superclass : #Z3Node,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
BitVector class >> /// xlen [
	^Z3Sort bv: xlen
]

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

{ #category : #'bit operators' }
BitVector >> & rhs [
	^ self bitAnd: rhs

]

{ #category : #arithmetic }
BitVector >> * rhs [
	"Signed multiplication"

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvmul: ctx _: self _: rhs.
	].
	^self retry: #* coercing: rhs

]

{ #category : #arithmetic }
BitVector >> + rhs [
	"Signed addition"

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvadd: ctx _: self _: rhs.
	].
	^self retry: #+ coercing: rhs

]

{ #category : #slicing }
BitVector >> , anotherBitVector [ 
	"Concatenate two bit strings (not necessarily of the same length)."

	self assert: anotherBitVector isBitVector.
	anotherBitVector length = 0 ifTrue: [ ^self ].
	^ Z3 mk_concat: ctx _: self _: anotherBitVector

]

{ #category : #arithmetic }
BitVector >> - rhs [
	"Signed subtraction"

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvsub: ctx _: self _: rhs.
	].
	^self retry: #- coercing: rhs

]

{ #category : #arithmetic }
BitVector >> / rhs [
	"Signed division"

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvsdiv: ctx _: self _: rhs.
	].
	^self retry: #/ coercing: rhs

]

{ #category : #arithmetic }
BitVector >> < rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvslt: ctx _: self _: rhs.
	].
	^self retry: #< coercing: rhs

]

{ #category : #'bit operators' }
BitVector >> << shamt [
   ^ self bitShiftLeft: shamt

]

{ #category : #arithmetic }
BitVector >> <= rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvsle: ctx _: self _: rhs.
	].
	^self retry: #<= coercing: rhs

]

{ #category : #arithmetic }
BitVector >> > rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvsgt: ctx _: self _: rhs.
	].
	^self retry: #> coercing: rhs

]

{ #category : #arithmetic }
BitVector >> >= rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvsge: ctx _: self _: rhs.
	].
	^self retry: #>= coercing: rhs

]

{ #category : #'bit operators' }
BitVector >> >> shamt [
	"Perform logical shift right by `shamt` bits"

	^ self bitShiftRight: shamt
]

{ #category : #converting }
BitVector >> beLikeMe: value [
	^value toBitVector: self length
]

{ #category : #'as yet unclassified' }
BitVector >> between: min and: max [
	^self >= min & (self <= max)
]

{ #category : #'bit operators' }
BitVector >> bitAnd: rhs [
	"Bitwise and"
	
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvand: ctx _: self _: rhs.
	].
	^self retry: #bitAnd: coercing: rhs


]

{ #category : #'bit operators' }
BitVector >> bitInvert [
	"Bitwise negation"
	^Z3 mk_bvnot: ctx _: self

]

{ #category : #'bit operators' }
BitVector >> bitOr: rhs [
	"Bitwise or"
	
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvor: ctx _: self _: rhs.
	].
	^self retry: #bitOr: coercing: rhs


]

{ #category : #'bit operators' }
BitVector >> bitRotateLeft: shamt [
	^ Z3 mk_rotate_left: ctx _: shamt _: self

]

{ #category : #'bit operators' }
BitVector >> bitRotateRight: shamt [
	^ Z3 mk_rotate_right: ctx _: shamt _: self

]

{ #category : #'bit operators' }
BitVector >> bitShiftLeft: shamt [
	(self isLikeMe: shamt) ifTrue:[
		^ Z3 mk_bvshl: ctx _: self _: shamt.
	].
	^self retry: #bitShiftLeft: coercing: shamt
]

{ #category : #'bit operators' }
BitVector >> bitShiftRight: shamt [
	"Perform logical shift right by `shamt` bits"

	(self isLikeMe: shamt) ifTrue:[
		^ Z3 mk_bvlshr: ctx _: self _: shamt.
	].
	^self retry: #bitShiftRight: coercing: shamt
]

{ #category : #'bit operators' }
BitVector >> bitShiftRightArithmetic: shamt [
	"Perform arithmetic shift right by `shamt` bits"

	(self isLikeMe: shamt) ifTrue:[
		^ Z3 mk_bvashr: ctx _: self _: shamt.
	].
	^self retry: #bitShiftRightArithmetic: coercing: shamt
]

{ #category : #slicing }
BitVector >> copyFrom: start to: stop [
	"This is like the usual SequenceableCollection>>copyFrom:to:,
	but NB the numbering of bits: right-to-left, the LSB is bit 0."
	^ Z3 mk_extract: ctx _: start _: stop _: self

]

{ #category : #testing }
BitVector >> isBitVector [
	^true
]

{ #category : #accessing }
BitVector >> length [
	"Return length in bits"
	^self sort length  

]

{ #category : #printing }
BitVector >> printString [
	^ 'BV' , self length printString , ':' , self astToString

]

{ #category : #slicing }
BitVector >> repeat: n [
	^ Z3 mk_repeat: ctx _: n _: self

]

{ #category : #adapting }
BitVector >> retry: selector coercing: rhs [
	^rhs adaptToBitVector: self length: self length andSend: selector
]

{ #category : #accessing }
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
BitVector >> udiv: rhs [
	"Unsigned division"

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvudiv: ctx _: self _: rhs.
	].
	^self retry: #udiv: coercing: rhs

]

{ #category : #'bit operators' }
BitVector >> | rhs [
	^ self bitOr: rhs

]
