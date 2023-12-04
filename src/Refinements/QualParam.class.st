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
	^self symbol: sym sort: srt pattern: nil
]

{ #category : #'instance creation' }
QualParam class >> symbol: sym sort: srt pattern: p [
	^self basicNew 
		symbol: sym;
		sort: srt;
		pattern: (p ifNil: [PatNone new]);
		yourself
]

{ #category : #comparing }
QualParam >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^symbol = rhs symbol
	and: [ pattern = rhs pattern
	and: [ sort = rhs sort ] ]
]

{ #category : #'as yet unclassified' }
QualParam >> applyQPP: su [
"
applyQPP :: So.TVSubst -> F.QualParam -> F.QualParam
             su           self
"
	^self copy
		sort: (sort apply: su);
		yourself

]

{ #category : #'as yet unclassified' }
QualParam >> eraseSymbol [
	^self copy
		symbol: HBind dummyName;
		yourself
]

{ #category : #comparing }
QualParam >> hash [
	^symbol hash
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
	"TODO pattern isNil ifFalse: [ self shouldBeImplemented ]."
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
