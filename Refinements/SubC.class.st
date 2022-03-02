Class {
	#name : #SubC,
	#superclass : #AbstractC,
	#instVars : [
		'lhs'
	],
	#category : #Refinements
}

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

{ #category : #'as yet unclassified' }
SubC >> outVV: m_fi i: i [
	| m fi sr x cm1 bId_be1 m1 c1 fi1 |
	m := m_fi key. fi := m_fi value.
	sr := self lhs.
	x := sr sr_reft symbol.
	bId_be1 := fi bs insertVar: x sort: sr.
	m1 := m copy 
		at: i put: bId_be1 key;
		yourself.
	c1 := self copy.
	c1 env: (self env insert: bId_be1 key).
	cm1 := fi cm copy
		at: i put: c1;
		yourself.
	fi1 := fi copy.
	fi1 bs: bId_be1 value.
	fi1 cm: cm1.
	^m1 -> fi1
]

{ #category : #accessing }
SubC >> senv [
	^env
]

{ #category : #'as yet unclassified' }
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

{ #category : #'as yet unclassified' }
SubC >> toSimpC: bindm [
	^SimpC basicNew initializeFrom: self bindm: bindm
]
