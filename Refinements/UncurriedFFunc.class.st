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

{ #category : #sorting }
UncurriedFFunc >> sortSubst: θ [
	^UncurriedFFunc
		dom: (dom collect: [ :eachArgSort | eachArgSort sortSubst: θ ])
		cod: (cod sortSubst: θ)
]

{ #category : #sorting }
UncurriedFFunc >> subst: j _: tj [
	^UncurriedFFunc
		dom: (dom collect: [ :eachArgSort | eachArgSort subst: j _: tj ])
		cod: (cod subst: j _: tj)
]

{ #category : #sorting }
UncurriedFFunc >> z3sort [
	^Z3Symbol new mkFuncFrom: (dom collect: #z3sort) to: cod z3sort

]
