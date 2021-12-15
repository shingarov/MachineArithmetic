Class {
	#name : #QualParam,
	#superclass : #HThing,
	#instVars : [
		'symbol',
		'pattern',
		'sort'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
QualParam class >> symbol: sym sort: srt [
	^self basicNew 
		symbol: sym;
		sort: srt;
		yourself
]

{ #category : #'as yet unclassified' }
QualParam >> eraseSymbol [
	^self copy
		symbol: HBind dummyName;
		yourself
]

{ #category : #accessing }
QualParam >> pattern [
	^ pattern
]

{ #category : #accessing }
QualParam >> pattern: anObject [
	pattern := anObject
]

{ #category : #printing }
QualParam >> printOn: aStream [
	pattern isNil ifFalse: [ self shouldBeImplemented ].
	aStream nextPutAll: symbol.
	aStream nextPut: (Character value: 16r2208).
	sort printOn: aStream

]

{ #category : #accessing }
QualParam >> sort [
	^ sort
]

{ #category : #accessing }
QualParam >> sort: anObject [
	sort := anObject
]

{ #category : #accessing }
QualParam >> symbol [
	^ symbol
]

{ #category : #accessing }
QualParam >> symbol: anObject [
	symbol := anObject
]
