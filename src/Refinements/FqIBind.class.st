Class {
	#name : #FqIBind,
	#superclass : #Object,
	#instVars : [
		'int',
		'symbol',
		'sortedReft'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FqIBind class >> int: i symbol: s sortedReft: sr [
	^self basicNew
		int: i;
		symbol: s;
		sortedReft: sr;
		yourself
]

{ #category : #accessing }
FqIBind >> int [
	^ int
]

{ #category : #accessing }
FqIBind >> int: anObject [
	int := anObject
]

{ #category : #printing }
FqIBind >> printOn: aStream [
	aStream nextPut: $(.
	int printOn: aStream.
	aStream nextPut: $,.
	aStream nextPutAll: symbol.
	aStream nextPut: $,.
	sortedReft printOn: aStream.
	aStream nextPut: $).
]

{ #category : #accessing }
FqIBind >> sortedReft [
	^ sortedReft
]

{ #category : #accessing }
FqIBind >> sortedReft: anObject [
	sortedReft := anObject
]

{ #category : #accessing }
FqIBind >> symbol [
	^ symbol
]

{ #category : #accessing }
FqIBind >> symbol: anObject [
	symbol := anObject
]
