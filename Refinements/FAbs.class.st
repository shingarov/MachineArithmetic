Class {
	#name : #FAbs,
	#superclass : #PreSort,
	#instVars : [
		'int',
		'sort'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FAbs class >> int: i sort: s [ 
	^self basicNew
		int: i;
		sort: s;
		yourself 
		
]

{ #category : #comparing }
FAbs >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^int = rhs int and: [ sort = rhs sort ]
]

{ #category : #'as yet unclassified' }
FAbs >> checkFunSort [
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
FAbs >> goMapSort: stepBlock [
"cf. Visitor.hs"
	^FAbs int: int sort: (stepBlock value: sort)
]

{ #category : #comparing }
FAbs >> hash [
	^int hash
]

{ #category : #'as yet unclassified' }
FAbs >> instantiate [
	| t_ v |
	t_ := sort instantiate.
	v := Integer fresh.
	^t_ subst: int _: (FVar new: v)
]

{ #category : #accessing }
FAbs >> int [
	^ int
]

{ #category : #accessing }
FAbs >> int: anObject [
	int := anObject
]

{ #category : #printing }
FAbs >> printOn: aStream [
	aStream nextPutAll: 'FAbs '.
	self int printOn: aStream.
	aStream space.
	self sort printOn: aStream
]

{ #category : #accessing }
FAbs >> sort [
	^ sort
]

{ #category : #accessing }
FAbs >> sort: anObject [
	sort := anObject
]

{ #category : #sorting }
FAbs >> sortSubst: θ [
"
sortSubst θ (FAbs i t)    = FAbs i (sortSubst θ t)
"
	^θ at: self ifAbsent: [
		FAbs
			int: int
			sort: (sort sortSubst: θ) guest
		]
]

{ #category : #'as yet unclassified' }
FAbs >> z3sort [
	^sort z3sort
]
