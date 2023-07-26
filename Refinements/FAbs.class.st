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
	^sort checkFunSort
]

{ #category : #'as yet unclassified' }
FAbs >> containsFVar [
	^sort containsFVar
]

{ #category : #'as yet unclassified' }
FAbs >> goFunctionSort: vs _: ss [
"
go vs ss (FAbs i t)    = go (i:vs) ss t
"
	^sort goFunctionSort: {int}, vs _: ss
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
"
instantiate :: Sort -> CheckM Sort
go (FAbs !i !t) = do ...
"
	| t′ v |
	t′ := sort instantiate.
	v := Integer fresh.
	^t′ subst: int _: (FVar new: v)
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

{ #category : #substitution }
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

{ #category : #'sort-checking' }
FAbs >> subst: j _: tj [
	self shouldBeImplemented
	
"
  subst !j !tj (FAbs !i !t)
    | i == j                  = FAbs i t
    | otherwise               = FAbs i t'
    where
      !t'                     = subst j tj t
"
]
