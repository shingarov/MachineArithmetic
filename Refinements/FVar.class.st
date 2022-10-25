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

{ #category : #'as yet unclassified' }
FVar >> checkFunSort [
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

{ #category : #'as yet unclassified' }
FVar >> subst: j _: tj [ 
	^i=j
		ifTrue: [ tj ]
		ifFalse: [ self ]
]
