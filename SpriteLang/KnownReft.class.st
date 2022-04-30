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

{ #category : #'as yet unclassified' }
KnownReft >> freshR: Γ base: b [
	^self
]

{ #category : #testing }
KnownReft >> isKnown [
	^true
]

{ #category : #printing }
KnownReft >> printOn: aStream [
	aStream nextPutAll: 'Known "';
		nextPutAll: symbol;
		nextPutAll: '" '.
	expr printOn: aStream
]

{ #category : #accessing }
KnownReft >> reft [
	"The inverse of #known."
	^Reft symbol: symbol expr: expr
]

{ #category : #'as yet unclassified' }
KnownReft >> subst1: e for: varName [
	"TODO: what's with substExcept?"
	varName = symbol ifTrue: [ ^self ].
	^KnownReft symbol: symbol expr: (expr subst1: e for: varName)
]

{ #category : #accessing }
KnownReft >> symbol [
	^ symbol
]

{ #category : #accessing }
KnownReft >> symbol: anObject [
	symbol := anObject
]
