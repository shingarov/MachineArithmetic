Class {
	#name : #FVar,
	#superclass : #PreSort,
	#instVars : [
		'i'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FVar class >> new [
	^self shouldNotImplement
]

{ #category : #'instance creation' }
FVar class >> new: i [
	^self basicNew 
		i: i;
		yourself
]

{ #category : #comparing }
FVar >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^i = rhs i
]

{ #category : #'target resize' }
FVar >> apply: θ [ 
	self shouldBeImplemented
]

{ #category : #'as yet unclassified' }
FVar >> checkFunSort [
"
Cf. SortCheck.hs
"
	self shouldBeImplemented.
]

{ #category : #comparing }
FVar >> hash [
	^i hash
]

{ #category : #accessing }
FVar >> i [
	^ i
]

{ #category : #accessing }
FVar >> i: anObject [
	i := anObject
]

{ #category : #printing }
FVar >> printOn: aStream [
	aStream nextPutAll: '@('.
	self i printOn: aStream.
	aStream nextPutAll: ')'
	
]

{ #category : #sorting }
FVar >> sortSubst: θ [
	^θ at: i ifAbsent: [self]
]

{ #category : #'sort-checking' }
FVar >> subst: j _: tj [ 
	^i=j
		ifTrue: [ tj ]
		ifFalse: [ self ]
]
