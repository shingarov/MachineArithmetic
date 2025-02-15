Class {
	#name : #SubC,
	#superclass : #AbstractC,
	#instVars : [
		'lhs'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
SubC class >> mkSubC: env lhs: lhs rhs: rhs i: i tag: tag [
"
mkSubC :: IBindEnv -> SortedReft -> SortedReft -> Maybe Integer -> Tag -> a  -> SubC a
           env          lhs           rhs             i            tag   label
Cf. Constraints.hs
"
	^self basicNew
		env: env;
		rhs: rhs;
		lhs: lhs;
		id: i;
		tag: tag;
		yourself
]

{ #category : #'instance creation' }
SubC class >> new [
	self shouldNotImplement
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
