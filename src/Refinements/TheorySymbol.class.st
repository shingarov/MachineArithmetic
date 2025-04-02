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

{ #category : #'known theories' }
TheorySymbol class >> interpSymbols [
"
interpSymbols :: [(Symbol, TheorySymbol)]
Cf. Smt/Theories.hs
"
	^{
		"#interpSym:sort: takes two arguments.
		 The first is a two-argument block which actually computes the
		 value of the interpreted symbol given the actual argument values
		 (the first argument to the block) — which are guaranteed to be
		 Z3 nodes — and the Z3 return sort in the second argument to the
		 block."

		'Set_empty' interpSym: [ :args :returnSort | Z3Set emptyOf: returnSort domain ] sort: self setEmptySort.
		'Set_sng' interpSym: [ :args :_ | Z3Set with: args first ] sort: self setSngSort.
		'Set_add' interpSym: [ :args :_ | args first add: args second ] sort: self setAddSort.
		'Set_cup' interpSym: [ :args :_ | args first ∪ args second ] sort: self setBopSort.
		'Set_cap' interpSym: [ :args :_ | args first ∩ args second ] sort: self setBopSort.
		'Set_mem' interpSym: [ :args :_ | args first ∈ args second ] sort: self setMemSort.
		
		'toBitVector' interpSym: [ :args :returnSort | args first toBitVector: returnSort length ] sort: self toBitVectorSort.
	}
]

{ #category : #'known theories' }
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

{ #category : #'known theories' }
TheorySymbol class >> setBopSort [
"
setAddSort = FAbs 0 $ FFunc (setSort $ FVar 0) $ FFunc (FVar 0)           (setSort $ FVar 0) →
setBopSort = FAbs 0 $ FFunc (setSort $ FVar 0) $ FFunc (setSort $ FVar 0) (setSort $ FVar 0)
"
	^FAbs
		int: 0
		sort: (FFunc
			from: (FVar new: 0) mkSetSort
			to: (FFunc from: (FVar new: 0) mkSetSort to: (FVar new: 0) mkSetSort))
]

{ #category : #'known theories' }
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

{ #category : #'known theories' }
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

{ #category : #'known theories' }
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
