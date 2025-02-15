Class {
	#name : #FTyconBitVecSize,
	#superclass : #FTycon,
	#instVars : [
		'length'
	],
	#category : #Refinements
}

{ #category : #names }
FTyconBitVecSize class >> conName [
	^self shouldNotImplement
]

{ #category : #'instance creation' }
FTyconBitVecSize class >> length: anInteger [
	^self basicNew
		length: anInteger;
		yourself
]

{ #category : #'instance creation' }
FTyconBitVecSize class >> named: aString [
	| XX i |
	aString = 'SizeXX' ifTrue: [ ^FTyconUnknownBitVecSize new ].
	(aString beginsWith: 'Size') ifFalse: [ ^nil ].
	XX := aString copyFrom: 5 to: aString size.
	i := PPParser decimalNat end parse: XX. "Pharo's asInteger and readFrom: happily eat junk postfices"
	^i isPetitFailure
		ifTrue: [ nil ]
		ifFalse: [ self length: i ]
]

{ #category : #comparing }
FTyconBitVecSize >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^self length = rhs length
]

{ #category : #'sort-checking' }
FTyconBitVecSize >> checkBitVector: srt in: _ tvSubst: θ [
	(srt isKindOf: Z3BitVectorSort) ifTrue: [
		^length = srt length
			ifTrue: [ θ ] ifFalse: [ nil ]	].
	(srt isKindOf: FTC) ifFalse: [ ^nil ].
	srt typeConstructor isBitVecSizeTC ifFalse: [ ^nil ].
	^length = srt typeConstructor length
	ifTrue: [ θ ] ifFalse: [ nil ]
]

{ #category : #comparing }
FTyconBitVecSize >> hash [
	^self length
]

{ #category : #testing }
FTyconBitVecSize >> isBitVecSizeTC [
	^true
]

{ #category : #accessing }
FTyconBitVecSize >> length [
	^ length
]

{ #category : #accessing }
FTyconBitVecSize >> length: anObject [
	length := anObject
]

{ #category : #printing }
FTyconBitVecSize >> printOn: aStream [
	aStream nextPutAll: 'Size'.
	length printOn: aStream
]
