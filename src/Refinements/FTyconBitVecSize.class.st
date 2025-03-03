Class {
	#name : #FTyconBitVecSize,
	#superclass : #FTycon,
	#instVars : [
		'size'
	],
	#category : #Refinements
}

{ #category : #names }
FTyconBitVecSize class >> conName [
	^self shouldNotImplement
]

{ #category : #'instance creation' }
FTyconBitVecSize class >> named: aString [
	| XX i |
	(aString beginsWith: 'Size') ifFalse: [ ^nil ].
	XX := aString copyFrom: 5 to: aString size.
	i := PPParser decimalNat end parse: XX. "Pharo's asInteger and readFrom: happily eat junk postfices"
	^i isPetitFailure
		ifTrue: [ nil ]
		ifFalse: [ self size: i ]
]

{ #category : #'instance creation' }
FTyconBitVecSize class >> size: anInteger [
	^self basicNew
		size: anInteger;
		yourself
]

{ #category : #printing }
FTyconBitVecSize >> printOn: aStream [
	aStream nextPutAll: 'Size'.
	size printOn: aStream
]

{ #category : #accessing }
FTyconBitVecSize >> size [
	^ size
]

{ #category : #accessing }
FTyconBitVecSize >> size: anObject [
	size := anObject
]
