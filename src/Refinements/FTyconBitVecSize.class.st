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
	(aString beginsWith: 'Size') ifFalse: [ ^nil ].
	XX := aString copyFrom: 5 to: aString size.
	i := PPParser decimalNat end parse: XX. "Pharo's asInteger and readFrom: happily eat junk postfices"
	^i isPetitFailure
		ifTrue: [ nil ]
		ifFalse: [ self length: i ]
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
