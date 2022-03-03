Class {
	#name : #EVar,
	#superclass : #Object,
	#instVars : [
		'sym'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EVar class >> of: v [
	^self basicNew
		sym: v;
		yourself
]

{ #category : #comparing }
EVar >> = rhs [
	rhs class == self class ifFalse: [ ^false ].
	^sym = rhs sym
]

{ #category : #compilation }
EVar >> evaluateIn: aBindEnv [ 
	^(aBindEnv sortOf: sym) mkConst: sym
]

{ #category : #comparing }
EVar >> hash [
	^sym hash
]

{ #category : #'as yet unclassified' }
EVar >> isKVar [
	^false
]

{ #category : #printing }
EVar >> printOn: aStream [
	aStream nextPut: $«.
	aStream nextPutAll: sym.
	aStream nextPut: $».
]

{ #category : #'as yet unclassified' }
EVar >> readStream [
	^sym readStream
]

{ #category : #'as yet unclassified' }
EVar >> refaConjuncts [
	^{self}
]

{ #category : #'as yet unclassified' }
EVar >> subst1: expr for: oldSym [
	^sym = oldSym
		ifTrue: [ expr ]
		ifFalse: [ self ]

]

{ #category : #'term rewriting' }
EVar >> subst: θ [
	θ list do: [ :ass | sym = ass key ifTrue: [ ^ass value ] ].
	^self
]

{ #category : #accessing }
EVar >> sym [
	^ sym
]

{ #category : #accessing }
EVar >> sym: anObject [
	sym := anObject
]
