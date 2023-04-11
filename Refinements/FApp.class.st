"
I am a brain-damaged function-application Sort which is not a Z3Sort.
Cf. Sorts.hs:
data Sort =
  ...
  | FApp  !Sort !Sort    -- ^ constructed type
"
Class {
	#name : #FApp,
	#superclass : #PreSort,
	#instVars : [
		's',
		't'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FApp class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
FApp class >> s: aSort t: anotherSort [
	^self basicNew
		s: aSort;
		t: anotherSort;
		yourself
]

{ #category : #comparing }
FApp >> = rhs [
	self class = rhs class ifFalse: [ ^false ].
	^s = rhs s and: [ t = rhs t ]
]

{ #category : #'as yet unclassified' }
FApp >> goMapSort: stepBlock [
"cf. Visitor.hs"
	^FApp s: (stepBlock value: s) t: (stepBlock value: t)
]

{ #category : #comparing }
FApp >> hash [
	^s hash
]

{ #category : #printing }
FApp >> printOn: aStream [
	aStream nextPutAll: '(FApp '.
	s printOn: aStream.
	aStream space.
	t printOn: aStream.
	aStream nextPutAll: ')'.
]

{ #category : #accessing }
FApp >> s [
	^ s
]

{ #category : #accessing }
FApp >> s: anObject [
	s := anObject
]

{ #category : #sorting }
FApp >> sortSubst: θ [
"
sortSubst θ (FApp t1 t2)  = FApp  (sortSubst θ t1) (sortSubst θ t2)
"
	^θ at: self ifAbsent: [
		FApp
			s: (s sortSubst: θ)
			t: (t sortSubst: θ)
		]
]

{ #category : #'as yet unclassified' }
FApp >> subst: j _: tj [ 
	| s_ t_ |
	s_ := s subst: j _: tj.
	t_ := t subst: j _: tj.
	^FApp s: s_ t: t_
]

{ #category : #accessing }
FApp >> t [
	^ t
]

{ #category : #accessing }
FApp >> t: anObject [
	t := anObject
]

{ #category : #'as yet unclassified' }
FApp >> z3sort [
	| h j |
	(s isKindOf: Z3Sort) ifFalse: [ self error ].
	(t isKindOf: Z3Sort) ifFalse: [ self error ].
	h := self class hotel.
	j := h addElement: self.
	^Z3Sort uninterpretedSortNamed: j
]
