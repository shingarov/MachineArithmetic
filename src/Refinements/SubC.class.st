"
data SubC a = SubC
  { _senv  :: !IBindEnv
  , slhs   :: !SortedReft
  , srhs   :: !SortedReft
  , _sid   :: !(Maybe SubcId) 
  , _stag  :: !Tag
  , _sinfo :: !a
  } 
  deriving (Eq, Generic, Functor)
Cf. Types/Constraints.hs
"
Class {
	#name : #SubC,
	#superclass : #AbstractC,
	#instVars : [
		'lhs'
	],
	#category : #'Refinements-Constraints'
}

{ #category : #'instance creation' }
SubC class >> env: env lhs: lhs rhs: rhs i: i tag: tag [
"
mkSubC :: IBindEnv -> SortedReft -> SortedReft -> Maybe Integer -> Tag -> a  -> SubC a
           env          lhs           rhs             i            tag   label
Cf. Types/Constraints.hs
"
	^self basicNew
		env: env;
		lhs: lhs;
		rhs: rhs;
		id: i;
		tag: tag;
		yourself
]

{ #category : #'instance creation' }
SubC class >> mkSubC: env lhs: lhs rhs: rhs i: i tag: tag [
"
mkSubC :: IBindEnv -> SortedReft -> SortedReft -> Maybe Integer -> Tag -> a  -> SubC a
           env          lhs           rhs             i            tag   label
mkSubC = SubC
Cf. Types/Constraints.hs

So really this is just another name for SubC constructor,
mkSubC only used in goS′ in Horn/Info.hs to create the subC's
programmatically, and SubC when directly specifying them in
FQ tests (this path going through subC/subC′).
"
	^self
		env: env
		lhs: lhs
		rhs: rhs
		i: i
		tag: tag
]

{ #category : #'instance creation' }
SubC class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
SubC class >> subC: γ lhs: sr1 rhs: sr2 i: i tag: y [
"
subC :: IBindEnv -> SortedReft -> SortedReft -> Maybe Integer -> Tag -> a -> [SubC a]
Cf. Types/Constraints.hs
"
	| t1 r1 t2 r2 sr1′ sr2′ vv′ |
	t1 := sr1 sr_sort.  r1 := sr1 sr_reft.
	t2 := sr2 sr_sort.  r2 := sr2 sr_reft.
	vv′ := i mkVV.
	sr1′ := SortedReft sort: t1 reft: (r1 shiftVV: vv′).
	sr2′ := [ :r | SortedReft sort: t2 reft: (r shiftVV: vv′) ].
	^r2 reftConjuncts collect: [ :r2′ | SubC env: γ lhs: sr1′ rhs: (sr2′ value: r2′) i: i tag: y ]
]

{ #category : #'instance creation' }
SubC class >> subC′: env lhs: lhs rhs: rhs i: i tag: tag [
"
subC' :: IBindEnv
      -> SortedReft
      -> SortedReft
      -> Integer
      -> Tag
    ((-> SourcePos))
    ((-> SourcePos))
      -> SubC ()
Cf. Parse.hs
"
	| cs |
	cs := self subC: env lhs: lhs rhs: rhs i: i tag: tag.
	cs size = 1 ifFalse: [self error: 'RHS without single conjunct'].
	^cs anyOne
]

{ #category : #logic }
SubC >> clhs: be [
"
class TaggedC c a where
  ...
  clhs  :: BindEnv -> c a -> [(Symbol, SortedReft)]

instance TaggedC SubC a where
  ...
  clhs be c = sortedReftBind (slhs c) : envCs be (senv c)
"
	^{lhs bind}, (be envCs: env)
]

{ #category : #logic }
SubC >> crhs [
	^rhs sr_reft expr
]

{ #category : #accessing }
SubC >> lhs [
	^ lhs
]

{ #category : #accessing }
SubC >> lhs: anObject [
	lhs := anObject
]

{ #category : #logic }
SubC >> outVV: m_fi i: i [
"
outVV :: (BindM, FInfo a) -> Integer -> SubC a -> (BindM, FInfo a)
"
	| m fi sr x cm′ bId_be′ bId be′ m′ c′ fi′ |
	m := m_fi key. fi := m_fi value.
	sr := self lhs.
	x := sr sr_reft symbol.
	bId_be′ := fi bs insertBindEnv: x sortedReft: sr.
	bId := bId_be′ key.  be′ := bId_be′ value.
	m′ := m insert: bId at: i.
	c′ := self copy
		env: (self senv insertsIBindEnv: {bId});
		yourself.
	cm′ := fi cm insert: c′ at: i.
	fi′ := fi copy
		bs: be′;
		cm: cm′;
		yourself.
	^m′ -> fi′
]

{ #category : #accessing }
SubC >> senv [
	^env
]

{ #category : #logic }
SubC >> shiftId: i [ 
	id := i.
	lhs := lhs shiftSR: i.
	rhs := rhs shiftSR: i.
	^self
]

{ #category : #GT }
SubC >> textForGT_subclassSpecific [
	^'lhs: ', lhs printString, String cr
]

{ #category : #GT }
SubC >> textTabLabel [
	^'Constraint'
]

{ #category : #logic }
SubC >> toSimpC: bindm [
	^SimpC basicNew initializeFrom: self bindm: bindm
]
