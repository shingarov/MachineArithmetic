Class {
	#name : #BaseRefinement,
	#superclass : #Object,
	#instVars : [
		'B',
		'e'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
BaseRefinement class >> base: B predicate: e [
	^self basicNew 
		base: B; predicate: e;
		yourself
]

{ #category : #comparing }
BaseRefinement >> <= rhs [
	| x solver |
	self base == rhs base ifFalse: [ self error: 'To compare refinement types, first the base types must already be the same' ].
	x := self base mkFreshConst: nil.
	solver := Z3Solver new.
	[
		solver proveValid: (self predicate value: x) ==> (rhs predicate value: x).
		solver del.
		^true
	] on: NotValid
	do: [ solver del. ^false ]
]

{ #category : #accessing }
BaseRefinement >> anyOne [
	| nu solver instance |
	nu := B mkFreshConst: 'nu'.
	solver := Z3Solver new.
	solver assert: (e value: nu).
	solver check == true ifFalse: [ self error ].
	instance := solver getModel eval: nu completion: true.
	solver del.
	^instance
]

{ #category : #accessing }
BaseRefinement >> base [
	^B
]

{ #category : #accessing }
BaseRefinement >> base: aSort [
	B := aSort
]

{ #category : #accessing }
BaseRefinement >> predicate [
	^e
]

{ #category : #accessing }
BaseRefinement >> predicate: aBlock [
	e := aBlock
]

{ #category : #printing }
BaseRefinement >> printOn: aStream [
	aStream nextPut: ${.
	B printOn: aStream.
	aStream nextPutAll: ' | '.
	e printOn: aStream.
	aStream nextPut: $}.
]

{ #category : #'as yet unclassified' }
BaseRefinement >> toPredicateOver: varName [
	| var |
	var := self base mkConst: varName.
	^self predicate value: var
]
