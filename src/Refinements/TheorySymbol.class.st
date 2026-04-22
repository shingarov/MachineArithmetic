"
Cf. Types/Theories.hs
--------------------------------------------------------------------------------
-- | 'TheorySymbol' represents the information about each interpreted 'Symbol'
--------------------------------------------------------------------------------
data TheorySymbol  = Thy
  { tsSym    :: !Symbol          -- ^ name
  , tsRaw    :: !Raw             -- ^ serialized SMTLIB2 name
  , tsSort   :: !Sort            -- ^ sort
  , tsInterp :: !Sem             -- ^ TRUE = defined (interpreted), FALSE = declared (uninterpreted)
  }
  deriving (Eq, Ord, Show, Data, Typeable, Generic)


"
Class {
	#name : #TheorySymbol,
	#superclass : #Object,
	#instVars : [
		'tsSym',
		'tsRaw',
		'tsSort',
		'tsInterp'
	],
	#category : #'Refinements-Theories'
}

{ #category : #'known theories - function sorts' }
TheorySymbol class >> bvBopSort [
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

{ #category : #'known theories - function sorts' }
TheorySymbol class >> bvCmpSort [
"
-- cmp :: forall a. BitVec a -> BitVec a -> Bool
bvCmpSort :: Sort
bvCmpSort = FAbs 0 $ FFunc (bitVecSort 0) $ FFunc (bitVecSort 0) boolSort
"
	^FAbs
		int: 0
		sort: (FFunc
			from: (0 bitVecSort)
			to: (FFunc
					from: 0 bitVecSort
					to: Bool sort))
]

{ #category : #'known theories - function sorts' }
TheorySymbol class >> bvConcatSort [
"
-- concat :: forall a b c. BitVec a -> BitVec b -> BitVec c
bvConcatSort :: Sort
bvConcatSort = FAbs 0 $ FAbs 1 $ FAbs 2 $
                     FFunc (bitVecSort 0) $ FFunc (bitVecSort 1) (bitVecSort 2)
"
	^FAbs
		int: 0
		sort: (FAbs
			int: 1
			sort: (FAbs
				int: 2
				sort: (FFunc
					from: (0 bitVecSort)
					to: (FFunc
						from: 1 bitVecSort
						to: 2 bitVecSort))))
]

{ #category : #'known theories - function sorts' }
TheorySymbol class >> bvExtendSort [
"
-- Indexed identifier operation, purposely didn't place FAbs!
--
-- extend :: Int -> BitVec a -> BitVec b
bvExtendSort :: Sort
bvExtendSort  = FFunc FInt $ FFunc (bitVecSort 1) (bitVecSort 2)
"
	^TLFFunc
		from: Int sort
		to: (FFunc
			from: (FApp s: (FTC new: FTyconBitVec new) t: (FTC new: FTyconUnknownBitVecSize new) )
			to:   (FApp s: (FTC new: FTyconBitVec new) t: (FTC new: FTyconUnknownBitVecSize new) )
		)
]

{ #category : #'known theories' }
TheorySymbol class >> bvInterpSymbols [
	^{
		"---- Size changes"
		'concat' interpSym: [ :bvs :returnSort | bvs first, bvs second ] sort: self bvConcatSort.
		'extract' interpSymₜ: [ :i :j :bv | bv copyFrom: i to: j ] sort: (TLFFunc from: Int sort to: self bvExtendSort).
		'repeat' interpSymₜ: [ :n :x | x repeat: n ] sort: self bvExtendSort.
		'zero_extend' interpSymₜ: [ :n :x | x zeroExtend:  n ] sort: self bvExtendSort.
		'sign_extend' interpSymₜ: [ :n :x | x signExtend:  n ] sort: self bvExtendSort.

		"-- Unary Logic"
		'bvnot'  interpBvUop: #bitInvert .
		'bvneg'  interpBvUop: #negated   .
		
		"-- Binary Logic"
		'bvand'  interpBvBop: #bitAnd:   .
		'bvnand' interpBvBop: #bitNand:  .
		'bvor'   interpBvBop: #bitOr:    .
		'bvnor'  interpBvBop: #bitNor:   .
		'bvxor'  interpBvBop: #bitXor:   .
		'bvxnor' interpBvBop: #bitXnor:  .

		"-- Shifts"
		'bvshl'  interpBvBop: #bitShiftLeft:            .
		'bvlshr' interpBvBop: #bitShiftRight:           .
		'bvashr' interpBvBop: #bitShiftRightArithmetic: .
		"NB: shamt in rotate is a C int, not a BV, so these are indexed TLFs"
		'rotate_left'  interpBvRot: #bitRotateLeft:  .
		'rotate_right' interpBvRot: #bitRotateRight: .
		
		"-- Arithmetic"
		'bvadd'  interpBvBop: #+       .
		'bvsub'  interpBvBop: #-       .
		'bvmul'  interpBvBop: #*       .
		'bvsdiv' interpBvBop: #/       .
		'bvsmod' interpBvBop: #\\      .
		'bvudiv' interpBvBop: #bvudiv: .
		'bvurem' interpBvBop: #bvurem: .
		'bvsrem' interpBvBop: #bvsrem: .

		"-- Comparisons"
		'bvslt' interpBvCmp: #<   .
		'bvsle' interpBvCmp: #<=  .
		'bvsgt' interpBvCmp: #>   .
		'bvsge' interpBvCmp: #>=  .
		'bvult' interpBvCmp: #<+  .
		'bvule' interpBvCmp: #<=+ .
		'bvugt' interpBvCmp: #>+  .
		'bvuge' interpBvCmp: #>=+ .
		'bveq'  interpBvCmp: #===   .
		'bvne'  interpBvCmp: #~==  .

		'toBitVector' interpSym: [ :args :returnSort | args first toBitVector: returnSort length ] sort: self toBitVectorSort.
		
		'bv' interpSymₜ: [ :sz :v  | v toBitVector: sz asInteger ] sort: self bvSort.
	}
]

{ #category : #'known theories - function sorts' }
TheorySymbol class >> bvRotSort [
"
-- Indexed identifier operation, purposely didn't place FAbs!
--
-- rot :: Int -> BitVec a -> BitVec a
bvRotSort :: Sort
bvRotSort  = FFunc FInt $ FFunc (bitVecSort 0) (bitVecSort 0)
"
	^TLFFunc
		from: Int sort
		to: (FFunc
			from: (FApp s: (FTC new: FTyconBitVec new) t: (FTC new: FTyconUnknownBitVecSize new) )
			to:   (FApp s: (FTC new: FTyconBitVec new) t: (FTC new: FTyconUnknownBitVecSize new) )
		)
]

{ #category : #'known theories - function sorts' }
TheorySymbol class >> bvSort [
	^TLFFunc
		from: Int sort
		to: (TLFFunc
			from: Int sort
			to: (FApp s: (FTC new: FTyconBitVec new) t: (FTC new: FTyconUnknownBitVecSize new) )	
		)
]

{ #category : #'known theories - function sorts' }
TheorySymbol class >> bvUopSort [
"
-- uOp :: forall a. BitVec a -> BitVec a
bvUopSort :: Sort
bvUopSort = FAbs 0 $ FFunc (bitVecSort 0) (bitVecSort 0)
"
	^FAbs
		int: 0
		sort: (FFunc
			from: 0 bitVecSort
			to: 0 bitVecSort)
]

{ #category : #'known theories' }
TheorySymbol class >> interpSymbol: key [
	^(Dictionary newFromAssociations: self interpSymbols) at: key
]

{ #category : #'known theories' }
TheorySymbol class >> interpSymbols [
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

{ #category : #'known theories - function sorts' }
TheorySymbol class >> setAddSort [
"
setAddSort = FAbs 0 $ FFunc (setSort $ FVar 0) $ FFunc (FVar 0)           (setSort $ FVar 0)
"
	^FAbs
		int: 0
		sort: (FFunc
			from: (FVar new: 0) mkSetSort
			to: (FFunc from: (FVar new: 0) to: (FVar new: 0) mkSetSort))
]

{ #category : #'known theories - function sorts' }
TheorySymbol class >> setBopSort [
"
setBopSort = FAbs 0 $ FFunc (setSort $ FVar 0) $ FFunc (setSort $ FVar 0) (setSort $ FVar 0)
"
	^FAbs
		int: 0
		sort: (FFunc
			from: (FVar new: 0) mkSetSort
			to: (FFunc from: (FVar new: 0) mkSetSort to: (FVar new: 0) mkSetSort))
]

{ #category : #'known theories - function sorts' }
TheorySymbol class >> setEmptySort [
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
TheorySymbol class >> setInterpSymbols [
	^{
		'Set_empty' interpSym: [ :args :returnSort | Z3Set emptyOf: returnSort domain ] sort: self setEmptySort.
		'Set_sng' interpSym: [ :args :_ | Z3Set with: args first ] sort: self setSngSort.
		'Set_add' interpSym: [ :args :_ | args first add: args second ] sort: self setAddSort.
		'Set_cup' interpSym: [ :args :_ | args first ∪ args second ] sort: self setBopSort.
		'Set_cap' interpSym: [ :args :_ | args first ∩ args second ] sort: self setBopSort.
		'Set_mem' interpSym: [ :args :_ | args first ∈ args second ] sort: self setMemSort.
	}
]

{ #category : #'known theories - function sorts' }
TheorySymbol class >> setMemSort [
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

{ #category : #'known theories - function sorts' }
TheorySymbol class >> setSngSort [
"
(FAbs 0 $ FFunc (FVar 0) (setSort $ FVar 0))
"
	^FAbs
		int: 0
		sort: (FFunc
			from: (FVar new: 0)
			to: (FVar new: 0) mkSetSort)
]

{ #category : #'known theories - function sorts' }
TheorySymbol class >> toBitVectorSort [
	^FAbs
		int: 0
		sort: (FFunc
			from: Z3Sort int
			to: (FApp s: (FTC new: FTyconBitVec new) t: (FVar new: 0)))
]

{ #category : #'instance creation' }
TheorySymbol class >> tsSym: tsSym tsRaw: tsRaw tsSort: tsSort tsInterp: tsInterp [
	^self basicNew
		tsSym: tsSym;
		tsRaw: tsRaw;
		tsSort: tsSort;
		tsInterp: tsInterp;
		yourself


]

{ #category : #printing }
TheorySymbol >> printOn: aStream [
"
instance Fixpoint TheorySymbol where
  toFix (Thy x _ t d) = text 'TheorySymbol' <+> pprint (x, t) <+> parens (pprint d)
"
	aStream
		nextPutAll: 'TheorySymbol ';
		nextPutAll: tsSym;
		nextPutAll: ' : '.
	tsSort printOn: aStream.
	aStream
		nextPutAll: ' (';
		nextPutAll: tsInterp name;
		nextPutAll: ')'.
]

{ #category : #accessing }
TheorySymbol >> thyAppInfo [
"
thyAppInfo :: TheorySymbol -> Maybe Int
"
	^tsInterp = SemField
		ifTrue: [ 1 ]
		ifFalse:  [ tsSort sortAppInfo ]
]

{ #category : #accessing }
TheorySymbol >> tsInterp [
	^ tsInterp
]

{ #category : #accessing }
TheorySymbol >> tsInterp: anObject [
	tsInterp := anObject
]

{ #category : #accessing }
TheorySymbol >> tsRaw [
	^ tsRaw
]

{ #category : #accessing }
TheorySymbol >> tsRaw: anObject [
	tsRaw := anObject
]

{ #category : #accessing }
TheorySymbol >> tsSort [
	^ tsSort
]

{ #category : #accessing }
TheorySymbol >> tsSort: anObject [
	tsSort := anObject
]

{ #category : #accessing }
TheorySymbol >> tsSym [
	^ tsSym
]

{ #category : #accessing }
TheorySymbol >> tsSym: anObject [
	tsSym := anObject
]
