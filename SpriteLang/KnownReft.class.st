Class {
	#name : #KnownReft,
	#superclass : #'ΛReft',
	#instVars : [
		'symbol',
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
KnownReft class >> new [
	^Reft new known
]

{ #category : #'instance creation' }
KnownReft class >> symbol: s expr: p [
	^self basicNew 
		symbol: s;
		expr: p;
		yourself
]

{ #category : #semigroup }
KnownReft >> , anotherReft [
	^anotherReft isKnown 
		ifTrue: [ (self reft, anotherReft reft) known ]
		ifFalse: [ ^self ]
]

{ #category : #accessing }
KnownReft >> expr [
	^ expr
]

{ #category : #accessing }
KnownReft >> expr: anObject [
	expr := anObject
]

{ #category : #testing }
KnownReft >> isKnown [
	^true
]

{ #category : #accessing }
KnownReft >> reft [
	"The inverse of #known."
	^Reft symbol: symbol expr: expr
]

{ #category : #accessing }
KnownReft >> symbol [
	^ symbol
]

{ #category : #accessing }
KnownReft >> symbol: anObject [
	symbol := anObject
]
