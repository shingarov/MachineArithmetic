Class {
	#name : #KnownTheorySymbols,
	#superclass : #Object,
	#category : #'Refinements-Theories'
}

{ #category : #'function sorts' }
KnownTheorySymbols class >> bv2intSort [
	^FFunc
			from: (FApp s: (FTC new: FTyconBitVec new) t: (FVar new: 0))
			to:   Z3Sort int

]

{ #category : #'function sorts' }
KnownTheorySymbols class >> bvBopSort [
"
-- bOp :: forall a. BitVec a -> BitVec a -> BitVec a
bvBopSort :: Sort
bvBopSort = FAbs 0 $ FFunc (bitVecSort 0) $ FFunc (bitVecSort 0) (bitVecSort 0)
"
	^FAbs
		int: 0
		sort: (FFunc
			from: (0 bitVecSort)
			to: (FFunc
					from: 0 bitVecSort
					to: 0 bitVecSort))
]

{ #category : #'function sorts' }
KnownTheorySymbols class >> bvCmpSort [
"
-- cmp :: forall a. BitVec a -> BitVec a -> Bool
bvCmpSort :: Sort
bvCmpSort = FAbs 0 $ FFunc (bitVecSort 0) $ FFunc (bitVecSort 0) boolSort
"
	^FFunc
			from: (0 bitVecSort)
			to: (FFunc
					from: 0 bitVecSort
					to: Bool sort)
]

{ #category : #'function sorts' }
KnownTheorySymbols class >> bvConcatSort [
	^ConstrainedFFunc
		from: (0 bitVecSort)
		to: (ConstrainedFFunc
			from: 1 bitVecSort
			to:   2 bitVecSort)
]

{ #category : #'function sorts' }
KnownTheorySymbols class >> bvExtendSort [
	^TLFFunc
			from: Int sort
			to: (FFunc
					from: 0 bitVecSort
					to:   1 bitVecSort)
]

{ #category : #'function sorts' }
KnownTheorySymbols class >> bvExtractSort [
	^TLFFunc
			from: Int sort
			to: (TLFFunc
					from: Int sort
					to: (FFunc
							from: 0 bitVecSort
							to:   1 bitVecSort))
]

{ #category : #'known theories' }
KnownTheorySymbols class >> bvInterpSymbols [
	^{
		self bv_concat.
		self bv_extract.
		self bv_repeat.
		self bv_zero_extend.
		self bv_sign_extend.

		self bv_bvnot.
		self bv_bvneg.
		
		self bv_bvand.
		self bv_bvnand.
		self bv_bvor.
		self bv_bvnor.
		self bv_bvxor.
		self bv_bvxnor.

		self bv_bvshl.
		self bv_bvlshr.
		self bv_bvashr.
		self bv_rotate_left.
		self bv_rotate_right.
		
		self bv_bvadd.
		self bv_bvsub.
		self bv_bvmul.
		self bv_bvsdiv.
		self bv_bvsmod.
		self bv_bvudiv.
		self bv_bvurem.
		self bv_bvsrem.

		self bv_bvslt.
		self bv_bvsle.
		self bv_bvsgt.
		self bv_bvsge.
		self bv_bvult.
		self bv_bvule.
		self bv_bvugt.
		self bv_bvuge.
		self bv_bveq.
		self bv_bvne.

		self bv_bvSignedValue.
		self bv_toBitVector.
		self bv_bv.
	}
]

{ #category : #'function sorts' }
KnownTheorySymbols class >> bvRotSort [
	^FFunc
			from: Int sort
			to: (FFunc
					from: 0 bitVecSort
					to:   0 bitVecSort)
]

{ #category : #'function sorts' }
KnownTheorySymbols class >> bvSort [
	^TLFFunc
		from: Int sort
		to: (FFunc
			from: Int sort
			to: 0 bitVecSort
		)
]

{ #category : #'function sorts' }
KnownTheorySymbols class >> bvUopSort [
	^FFunc
			from: 0 bitVecSort
			to:   0 bitVecSort
]

{ #category : #'bv - integer interpretation' }
KnownTheorySymbols class >> bv_bv [
		^'bv'
			interpSymₜ: [ :sz :v  | v toBitVector: sz asInteger ]
			sort: (FAbs int: 0 sort: (
				self bvSort typeLevelBlock: [ :arg :ot | ot rTypeSort to length toInt === arg ]
			))
]

{ #category : #'bv - integer interpretation' }
KnownTheorySymbols class >> bv_bvSignedValue [
	^'bvSignedValue' 		interpSym: [ :args :returnSort |
					| bv |
					self assert: (args size = 1).
					bv := args anyOne.
					self assert: bv isBitVector.
					self assert: returnSort = Int sort.
					bv signedValue ]
		sort: (FAbs int: 0 sort: self bv2intSort)
]

{ #category : #'bv - arithmetic' }
KnownTheorySymbols class >> bv_bvadd [
		^'bvadd'  interpBvBop: #+
]

{ #category : #'bv - binary logic' }
KnownTheorySymbols class >> bv_bvand [
	^'bvand'  interpBvBop: #bitAnd:
]

{ #category : #'bv - shifts' }
KnownTheorySymbols class >> bv_bvashr [
	^'bvashr' interpBvBop: #bitShiftRightArithmetic:
]

{ #category : #'bv - comparisons' }
KnownTheorySymbols class >> bv_bveq [
		^'bveq'  interpBvCmp: #===
]

{ #category : #'bv - shifts' }
KnownTheorySymbols class >> bv_bvlshr [
	^'bvlshr' interpBvBop: #bitShiftRight:
]

{ #category : #'bv - arithmetic' }
KnownTheorySymbols class >> bv_bvmul [
		^'bvmul'  interpBvBop: #*
]

{ #category : #'bv - binary logic' }
KnownTheorySymbols class >> bv_bvnand [
	^'bvnand' interpBvBop: #bitNand:
]

{ #category : #'bv - comparisons' }
KnownTheorySymbols class >> bv_bvne [
		^'bvne'  interpBvCmp: #~==
]

{ #category : #'bv - unary logic' }
KnownTheorySymbols class >> bv_bvneg [
		^'bvneg'  interpBvUop: #negated
]

{ #category : #'bv - binary logic' }
KnownTheorySymbols class >> bv_bvnor [
	^'bvnor'  interpBvBop: #bitNor:
]

{ #category : #'bv - unary logic' }
KnownTheorySymbols class >> bv_bvnot [
		^'bvnot'  interpBvUop: #bitInvert
]

{ #category : #'bv - binary logic' }
KnownTheorySymbols class >> bv_bvor [
	^'bvor'   interpBvBop: #bitOr:
]

{ #category : #'bv - arithmetic' }
KnownTheorySymbols class >> bv_bvsdiv [
		^'bvsdiv' interpBvBop: #/
]

{ #category : #'bv - comparisons' }
KnownTheorySymbols class >> bv_bvsge [
		^'bvsge' interpBvCmp: #>=
]

{ #category : #'bv - comparisons' }
KnownTheorySymbols class >> bv_bvsgt [
		^'bvsgt' interpBvCmp: #>
]

{ #category : #'bv - shifts' }
KnownTheorySymbols class >> bv_bvshl [
	^'bvshl'  interpBvBop: #bitShiftLeft:
]

{ #category : #'bv - comparisons' }
KnownTheorySymbols class >> bv_bvsle [
		^'bvsle' interpBvCmp: #<=
]

{ #category : #'bv - comparisons' }
KnownTheorySymbols class >> bv_bvslt [
		^'bvslt' interpBvCmp: #<
]

{ #category : #'bv - arithmetic' }
KnownTheorySymbols class >> bv_bvsmod [
		^'bvsmod' interpBvBop: #\\
]

{ #category : #'bv - arithmetic' }
KnownTheorySymbols class >> bv_bvsrem [
		^'bvsrem' interpBvBop: #bvsrem:
]

{ #category : #'bv - arithmetic' }
KnownTheorySymbols class >> bv_bvsub [
		^'bvsub'  interpBvBop: #-
]

{ #category : #'bv - arithmetic' }
KnownTheorySymbols class >> bv_bvudiv [
		^'bvudiv' interpBvBop: #bvudiv:
]

{ #category : #'bv - comparisons' }
KnownTheorySymbols class >> bv_bvuge [
		^'bvuge' interpBvCmp: #>=+
]

{ #category : #'bv - comparisons' }
KnownTheorySymbols class >> bv_bvugt [
		^'bvugt' interpBvCmp: #>+
]

{ #category : #'bv - comparisons' }
KnownTheorySymbols class >> bv_bvule [
		^'bvule' interpBvCmp: #<=+
]

{ #category : #'bv - comparisons' }
KnownTheorySymbols class >> bv_bvult [
		^'bvult' interpBvCmp: #<+
]

{ #category : #'bv - arithmetic' }
KnownTheorySymbols class >> bv_bvurem [
		^'bvurem' interpBvBop: #bvurem:
]

{ #category : #'bv - binary logic' }
KnownTheorySymbols class >> bv_bvxnor [
	^'bvxnor' interpBvBop: #bitXnor:
]

{ #category : #'bv - binary logic' }
KnownTheorySymbols class >> bv_bvxor [
	^'bvxor'  interpBvBop: #bitXor:
]

{ #category : #'bv - size changes' }
KnownTheorySymbols class >> bv_concat [
	^'concat'
		interpSym: [ :bvs :returnSort | bvs first, bvs second ]
		sort: (FAbs int: 0 sort: (FAbs int: 1 sort: (FAbs int: 2 sort: (
			self bvConcatSort typeLevelBlock: [ :t1 :t2 :ot | t1 rTypeSort length toInt + t2 rTypeSort length === ot rTypeSort length ]
		))))
]

{ #category : #'bv - size changes' }
KnownTheorySymbols class >> bv_extract [
	^'extract'
		interpSymₜ: [ :high :low :x | x copyFrom: high to: low ]
		sort: (FAbs int: 0 sort: (FAbs int: 1 sort: (
			self bvExtractSort typeLevelBlock: [ :high :low :ot | high toInt - low + 1 === ot rTypeSort to length ]
		)))
]

{ #category : #'bv - size changes' }
KnownTheorySymbols class >> bv_repeat [
	^'repeat'
		interpSymₜ: [ :n :x | x repeat: n ]
		sort: (FAbs int: 0 sort: (FAbs int: 1 sort: (
				self bvExtendSort typeLevelBlock: [ :arg :ot | ot rTypeSort from length toInt * arg === ot rTypeSort to length toInt ]
	)))
]

{ #category : #'bv - shifts' }
KnownTheorySymbols class >> bv_rotate_left [
		"NB: shamt in rotate is a C int, not a BV, so these are indexed TLFs"
		^'rotate_left'  interpBvRot: #bitRotateLeft:
]

{ #category : #'bv - shifts' }
KnownTheorySymbols class >> bv_rotate_right [
		"NB: shamt in rotate is a C int, not a BV, so these are indexed TLFs"
		^'rotate_right' interpBvRot: #bitRotateRight:
]

{ #category : #'bv - size changes' }
KnownTheorySymbols class >> bv_sign_extend [
	^'sign_extend'
		interpSymₜ: [ :n :x | x signExtend:  n ]
		sort: (FAbs int: 0 sort: (FAbs int: 1 sort: (
			self bvExtendSort typeLevelBlock: [ :arg :ot | ot rTypeSort from length toInt + arg === ot rTypeSort to length toInt ]
		)))
]

{ #category : #'bv - integer interpretation' }
KnownTheorySymbols class >> bv_toBitVector [
		^'toBitVector'
			interpSym: [ :args :returnSort | args first toBitVector: returnSort length ]
			sort: (FAbs int: 0 sort: self int2bvSort)
]

{ #category : #'bv - size changes' }
KnownTheorySymbols class >> bv_zero_extend [
	^'zero_extend'
		interpSymₜ: [ :n :x | x zeroExtend:  n ]
		sort: (FAbs int: 0 sort: (FAbs int: 1 sort: (
			self bvExtendSort typeLevelBlock: [ :arg :ot | ot rTypeSort from length toInt + arg === ot rTypeSort to length toInt ]
		)))
]

{ #category : #'function sorts' }
KnownTheorySymbols class >> int2bvSort [
	^FFunc
			from: Z3Sort int
			to: (FApp s: (FTC new: FTyconBitVec new) t: (FVar new: 0))
]

{ #category : #'known theories' }
KnownTheorySymbols class >> interpSymbol: key [
	^(Dictionary newFromAssociations: self interpSymbols) at: key
]

{ #category : #'known theories' }
KnownTheorySymbols class >> interpSymbols [
"
interpSymbols :: [(Symbol, TheorySymbol)]
Cf. Smt/Theories.hs
"
		"#interpSym:sort: takes two arguments.
		 The first is a two-argument block which actually computes the
		 value of the interpreted symbol given the actual argument values
		 (the first argument to the block) — which are guaranteed to be
		 Z3 nodes — and the Z3 return sort in the second argument to the
		 block."
	^self setInterpSymbols, self bvInterpSymbols
]

{ #category : #'function sorts' }
KnownTheorySymbols class >> setAddSort [
"
setAddSort = FAbs 0 $ FFunc (setSort $ FVar 0) $ FFunc (FVar 0)           (setSort $ FVar 0)
"
	^FAbs
		int: 0
		sort: (FFunc
			from: (FVar new: 0) mkSetSort
			to: (FFunc from: (FVar new: 0) to: (FVar new: 0) mkSetSort))
]

{ #category : #'function sorts' }
KnownTheorySymbols class >> setBopSort [
"
setBopSort = FAbs 0 $ FFunc (setSort $ FVar 0) $ FFunc (setSort $ FVar 0) (setSort $ FVar 0)
"
	^FAbs
		int: 0
		sort: (FFunc
			from: (FVar new: 0) mkSetSort
			to: (FFunc from: (FVar new: 0) mkSetSort to: (FVar new: 0) mkSetSort))
]

{ #category : #'function sorts' }
KnownTheorySymbols class >> setEmptySort [
"
(FAbs 0 $ FFunc intSort (setSort $ FVar 0))
"
	^FAbs
		int: 0
		sort: (FFunc
			from: Int sort
			to: (FVar new: 0) mkSetSort)
]

{ #category : #'known theories' }
KnownTheorySymbols class >> setInterpSymbols [
	^{
		'Set_empty' interpSym: [ :args :returnSort | Z3Set emptyOf: returnSort domain ] sort: self setEmptySort.
		'Set_sng' interpSym: [ :args :_ | Z3Set with: args first ] sort: self setSngSort.
		'Set_add' interpSym: [ :args :_ | args first add: args second ] sort: self setAddSort.
		'Set_cup' interpSym: [ :args :_ | args first ∪ args second ] sort: self setBopSort.
		'Set_cap' interpSym: [ :args :_ | args first ∩ args second ] sort: self setBopSort.
		'Set_mem' interpSym: [ :args :_ | args first ∈ args second ] sort: self setMemSort.
	}
]

{ #category : #'function sorts' }
KnownTheorySymbols class >> setMemSort [
"
setMemSort = FAbs 0 $ FFunc (FVar 0) $ FFunc (setSort $ FVar 0) boolSort
"
	^FAbs
		int: 0
		sort: (FFunc
			from: (FVar new: 0)
			to: (FFunc
					from: (FVar new: 0) mkSetSort
					to: Bool sort))
]

{ #category : #'function sorts' }
KnownTheorySymbols class >> setSngSort [
"
(FAbs 0 $ FFunc (FVar 0) (setSort $ FVar 0))
"
	^FAbs
		int: 0
		sort: (FFunc
			from: (FVar new: 0)
			to: (FVar new: 0) mkSetSort)
]
