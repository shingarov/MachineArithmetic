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
	^(be envCs: env) copyWith: lhs bind
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
	| m fi sr x cm′ bId_be′ m′ c′ fi′ |
	m := m_fi key. fi := m_fi value.
	sr := self lhs.
	x := sr sr_reft symbol.
	bId_be′ := fi bs insertVar: x sort: sr.
	m′ := m copy 
		at: i put: bId_be′ key;
		yourself.
	c′ := self copy.
	c′ env: (self env insert: bId_be′ key).
	cm′ := fi cm copy
		at: i put: c′;
		yourself.
	fi′ := fi copy.
	fi′ bs: bId_be′ value.
	fi′ cm: cm′.
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
