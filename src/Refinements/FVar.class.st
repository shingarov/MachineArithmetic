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
	^θ at: i ifAbsent: [ self ]
]

{ #category : #'sort-checking' }
FVar >> checkFunSort [
"
Cf. SortCheck.hs
"
	self shouldBeImplemented.
]

{ #category : #'sort-checking' }
FVar >> containsFVar [
	^true
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

{ #category : #'sort-checking' }
FVar >> subst: j _: tj [ 
	^i=j
		ifTrue: [ tj ]
		ifFalse: [ self ]
]

{ #category : #hotel }
FVar >> z3sort [
	self error: 'Control cant reach here because at this stage everything is monomorphized'
]
