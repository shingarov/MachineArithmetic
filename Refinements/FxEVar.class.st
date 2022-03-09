Class {
	#name : #FxEVar,
	#superclass : #Object,
	#instVars : [
		'sym'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FxEVar class >> of: v [
	^self basicNew
		sym: v;
		yourself
]

{ #category : #comparing }
FxEVar >> = rhs [
	rhs class == self class ifFalse: [ ^false ].
	^sym = rhs sym
]

{ #category : #compilation }
FxEVar >> evaluateIn: aBindEnv [ 
	^(aBindEnv sortOf: sym) mkConst: sym
]

{ #category : #comparing }
FxEVar >> hash [
	^sym hash
]

{ #category : #'as yet unclassified' }
FxEVar >> isKVar [
	^false
]

{ #category : #printing }
FxEVar >> printOn: aStream [
	aStream nextPut: $«.
	aStream nextPutAll: sym.
	aStream nextPut: $».
]

{ #category : #'as yet unclassified' }
FxEVar >> readStream [
	^sym readStream
]

{ #category : #'as yet unclassified' }
FxEVar >> refaConjuncts [
	^{self}
]

{ #category : #'as yet unclassified' }
FxEVar >> subst1: expr for: oldSym [
	^sym = oldSym
		ifTrue: [ expr ]
		ifFalse: [ self ]

]

{ #category : #'term rewriting' }
FxEVar >> subst: θ [
	θ list do: [ :ass | sym = ass key ifTrue: [ ^ass value ] ].
	^self
]

{ #category : #accessing }
FxEVar >> sym [
	^ sym
]

{ #category : #accessing }
FxEVar >> sym: anObject [
	sym := anObject
]
