Class {
	#name : #EVar,
	#superclass : #Object,
	#instVars : [
		'varName'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
EVar class >> of: v [
	^self basicNew
		varName: v;
		yourself
]

{ #category : #comparing }
EVar >> = rhs [
	rhs class == self class ifFalse: [ ^false ].
	^varName = rhs varName
]

{ #category : #comparing }
EVar >> hash [
	^varName hash
]

{ #category : #'as yet unclassified' }
EVar >> inZ3: bindingsInSmt [ 
	(varName beginsWith: 'bßºº')
		ifTrue: [ | index |
			index := (varName allButFirst: 4) asInteger.
			^bindingsInSmt at: index ]
		ifFalse: [ self shouldBeImplemented ]
]

{ #category : #'as yet unclassified' }
EVar >> isKVar [
	^false
]

{ #category : #printing }
EVar >> printOn: aStream [
	aStream nextPut: $«.
	aStream nextPutAll: varName.
	aStream nextPut: $».
]

{ #category : #'as yet unclassified' }
EVar >> readStream [
	^varName readStream
]

{ #category : #'as yet unclassified' }
EVar >> refaConjuncts [
	^{self}
]

{ #category : #'as yet unclassified' }
EVar >> subst1: expr for: sym [
	^varName = sym
		ifTrue: [ expr ]
		ifFalse: [ self ]

]

{ #category : #'term rewriting' }
EVar >> subst: θ [
	θ list do: [ :ass | varName = ass key ifTrue: [ ^ass value ] ].
	^self
]

{ #category : #accessing }
EVar >> varName [
	^ varName
]

{ #category : #accessing }
EVar >> varName: anObject [
	varName := anObject
]
