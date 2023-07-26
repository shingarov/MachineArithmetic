Class {
	#name : #UncurriedFFunc,
	#superclass : #PreSort,
	#instVars : [
		'dom',
		'cod'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
UncurriedFFunc class >> dom: D cod: C [
	^self basicNew
		dom: D;
		cod: C;
		yourself
]

{ #category : #comparing }
UncurriedFFunc >> = rhs [ 
	rhs class = self class ifFalse: [ ^false ].
	^cod = rhs cod and: [ dom = rhs dom ]
]

{ #category : #accessing }
UncurriedFFunc >> cod [
	^ cod
]

{ #category : #accessing }
UncurriedFFunc >> cod: anObject [
	cod := anObject
]

{ #category : #accessing }
UncurriedFFunc >> dom [
	^ dom
]

{ #category : #accessing }
UncurriedFFunc >> dom: anObject [
	dom := anObject
]

{ #category : #comparing }
UncurriedFFunc >> hash [
	^cod hash
]

{ #category : #sorting }
UncurriedFFunc >> subst: j _: tj [
	^UncurriedFFunc
		dom: (dom collect: [ :eachArgSort | eachArgSort subst: j _: tj ])
		cod: (cod subst: j _: tj)
]

{ #category : #'as yet unclassified' }
UncurriedFFunc >> uncurriedZ3sig [
	^dom -> cod
]

{ #category : #yoneda }
UncurriedFFunc >> uncurry [
	^self
]
