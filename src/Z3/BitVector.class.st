Class {
	#name : #BitVector,
	#superclass : #Z3Node,
	#pools : [
		'Z3FuncDeclKind'
	],
	#category : #'Z3-Core'
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
	"Bitwise and"
	
	^ self bitAnd: rhs

]

{ #category : #arithmetic }
BitVector >> * rhs [
	"Standard two's complement multiplication,
	 works irrespective of whether the bitvector is interpreted
	 as signed or unsigned (so there aren't separate 'ubvmul' /
	 'sbvmul' versions of bvmul, unlike there are for, say, div).
	"
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvmul: ctx _: self _: rhs.
	].
	^self retry: #* coercing: rhs

]

{ #category : #arithmetic }
BitVector >> + rhs [
	"Standard two's complement addition,
	 works irrespective of whether the bitvector is interpreted
	 as signed or unsigned (so there aren't separate 'ubvadd' /
	 'sbvadd' versions of bvadd, unlike there are for, say, div).
	"
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
	"Standard two's complement subtraction,
	 works irrespective of whether the bitvector is interpreted
	 as signed or unsigned (so there aren't separate 'ubvsub' /
	 'sbvsub' versions of bvsub, unlike there are for, say, div).
	"
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvsub: ctx _: self _: rhs.
	].
	^self retry: #- coercing: rhs

]

{ #category : #arithmetic }
BitVector >> / rhs [
	"Two's complement signed division"

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvsdiv: ctx _: self _: rhs.
	].
	^self retry: #/ coercing: rhs

]

{ #category : #'comparing - signed' }
BitVector >> < rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvslt: ctx _: self _: rhs.
	].
	^self retry: #< coercing: rhs

]

{ #category : #'comparing - unsigned' }
BitVector >> <+ rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvult: ctx _: self _: rhs.
	].
	^self retry: #'<+' coercing: rhs

]

{ #category : #'bit operators' }
BitVector >> << shamt [
   ^ self bitShiftLeft: shamt

]

{ #category : #'comparing - signed' }
BitVector >> <= rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvsle: ctx _: self _: rhs.
	].
	^self retry: #<= coercing: rhs

]

{ #category : #'comparing - unsigned' }
BitVector >> <=+ rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvule: ctx _: self _: rhs.
	].
	^self retry: #'<=+' coercing: rhs

]

{ #category : #'comparing - signed' }
BitVector >> > rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvsgt: ctx _: self _: rhs.
	].
	^self retry: #> coercing: rhs

]

{ #category : #'comparing - unsigned' }
BitVector >> >+ rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvugt: ctx _: self _: rhs.
	].
	^self retry: #'>+' coercing: rhs

]

{ #category : #'comparing - signed' }
BitVector >> >= rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvsge: ctx _: self _: rhs.
	].
	^self retry: #>= coercing: rhs

]

{ #category : #'comparing - unsigned' }
BitVector >> >=+ rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvuge: ctx _: self _: rhs.
	].
	^self retry: #'>=+' coercing: rhs

]

{ #category : #'bit operators' }
BitVector >> >> shamt [
	"Perform logical shift right by `shamt` bits"

	^ self bitShiftRight: shamt
]

{ #category : #arithmetic }
BitVector >> \\ rhs [
	"Two's complement signed remainder (sign follows divisor)"

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvsmod: ctx _: self _: rhs.
	].
	^self retry: #\\ coercing: rhs

]

{ #category : #'comparing - signed' }
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
BitVector >> bitNand: rhs [
	"Bitwise nand"
	
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvnand: ctx _: self _: rhs.
	].
	^self retry: #bitNand: coercing: rhs


]

{ #category : #'bit operators' }
BitVector >> bitNor: rhs [
	"Bitwise nor"
	
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvor: ctx _: self _: rhs.
	].
	^self retry: #bitOr: coercing: rhs
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

{ #category : #'bit operators' }
BitVector >> bitXnor: rhs [
	"Bitwise exclusive-or"

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvxnor: ctx _: self _: rhs.
	].
	^self retry: #bitXnor: coercing: rhs
]

{ #category : #'bit operators' }
BitVector >> bitXor: rhs [
	"Bitwise exclusive-or"

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvxor: ctx _: self _: rhs.
	].
	^self retry: #bitXor: coercing: rhs
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

{ #category : #'fx expr classification' }
BitVector >> isEBin [
	"Answer whether Fixpoint would consider this node a EBin."

	^{
		"Arithmetic" Z3_OP_BADD. Z3_OP_BSUB. Z3_OP_BMUL. Z3_OP_BSDIV. Z3_OP_BUDIV . Z3_OP_BSREM. Z3_OP_BUREM. Z3_OP_BSMOD.
		"Shifts"     Z3_OP_BSHL. Z3_OP_BLSHR. Z3_OP_BASHR.
	} includes: self funcDeclKind.
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

{ #category : #'bit operators' }
BitVector >> redAnd [
	"Take conjunction of all bits in the receiver, answer vector of length 1
	 (1 if all bits of the receiver are ones; 0 if any bit is zero)."
	^Z3 mk_bvredand: ctx _: self

]

{ #category : #'bit operators' }
BitVector >> redOr [
	"Take disjunction of all bits in the receiver, answer vector of length 1
	 (1 if any bit of the receiver is set to 1, 0 if they are all zeros)."
	^Z3 mk_bvredor: ctx _: self

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
	^self toSignedInt value
]

{ #category : #arithmetic }
BitVector >> srem: rhs [
	"Two's complement signed remainder (sign follows dividend)"

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvsrem: ctx _: self _: rhs.
	].
	^self retry: #srem: coercing: rhs

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

{ #category : #converting }
BitVector >> toSignedInt [
	^ Z3 mk_bv2int: ctx _: self _: true
]

{ #category : #converting }
BitVector >> toUnsignedInt [
	^ Z3 mk_bv2int: ctx _: self _: false
]

{ #category : #arithmetic }
BitVector >> udiv: rhs [
	"Unsigned division"

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvudiv: ctx _: self _: rhs.
	].
	^self retry: #udiv: coercing: rhs

]

{ #category : #'comparing - unsigned' }
BitVector >> unsignedBetween: min and: max [
	^self >=+ min & (self <=+ max)
]

{ #category : #accessing }
BitVector >> unsignedValue [
	^self toUnsignedInt value
]

{ #category : #arithmetic }
BitVector >> urem: rhs [
	"Unsigned remainder"

	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_bvurem: ctx _: self _: rhs.
	].
	^self retry: #urem: coercing: rhs

]

{ #category : #'bit operators' }
BitVector >> | rhs [
	"Bitwise or"
	
	^ self bitOr: rhs

]
