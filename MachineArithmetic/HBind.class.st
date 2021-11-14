Class {
	#name : #HBind,
	#superclass : #Object,
	#instVars : [
		'x',
		'τ',
		'p'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #naming }
HBind class >> dummy [
	^self x: self dummyName τ: Int sort p: (HPredAnd of: #())
]

{ #category : #naming }
HBind class >> dummyName [
	^'LIQUIDßdummy'
]

{ #category : #'instance creation' }
HBind class >> x: x τ: τ p: p [
	^self basicNew 
		x: x;
		τ: τ;
		p: p;
		yourself 
]

{ #category : #accessing }
HBind >> p [
	^ p
]

{ #category : #accessing }
HBind >> p: anObject [
	p := anObject
]

{ #category : #printing }
HBind >> printOn: aStream [
	aStream nextPutAll: self x.
	aStream nextPutAll: ':Int | '.  "BOGUS, for now pretend only Z3Int exists"
	self p printOn: aStream
]

{ #category : #accessing }
HBind >> x [
	^ x
]

{ #category : #accessing }
HBind >> x: anObject [
	x := anObject
]

{ #category : #accessing }
HBind >> τ [
	^ τ
]

{ #category : #accessing }
HBind >> τ: anObject [
	τ := anObject
]
