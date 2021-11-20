Class {
	#name : #ShallowRefinement,
	#superclass : #Object,
	#instVars : [
		'B',
		'e'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
ShallowRefinement class >> base: B predicate: e [
	^self basicNew 
		base: B; predicate: e;
		yourself
]

{ #category : #'as yet unclassified' }
ShallowRefinement >> allElements [
	| nu solver elements |
	nu := B mkFreshConst: 'nu'.
	solver := Z3Solver new.
	solver assert: (e value: nu).
	elements := OrderedCollection new.
	[ solver check ] whileTrue: [
		| m instance |
		m := solver getModel.
		instance := m eval: nu completion: true.
		elements add: instance.
		solver assert: m blockerContradictions
	].
	solver del.
	^elements
]

{ #category : #accessing }
ShallowRefinement >> anyOne [
	| nu solver instance |
	nu := B mkFreshConst: 'nu'.
	solver := Z3Solver new.
	solver assert: (e value: nu).
	solver check == true ifFalse: [ ^SubscriptOutOfBounds signalFor: 1 ].
	instance := solver getModel eval: nu completion: true.
	solver del.
	^instance
]

{ #category : #accessing }
ShallowRefinement >> base [
	^B
]

{ #category : #accessing }
ShallowRefinement >> base: aSort [
	B := aSort
]

{ #category : #accessing }
ShallowRefinement >> predicate [
	^e
]

{ #category : #accessing }
ShallowRefinement >> predicate: aBlock [
	e := aBlock
]

{ #category : #printing }
ShallowRefinement >> printOn: aStream [
	aStream nextPut: ${.
	B printOn: aStream.
	aStream nextPutAll: ' | '.
	e printOn: aStream.
	aStream nextPut: $}.
]

{ #category : #'as yet unclassified' }
ShallowRefinement >> toPredicateOver: varName [
	| var |
	var := self base mkConst: varName.
	^self predicate value: var
]

{ #category : #comparing }
ShallowRefinement >> isSubsetOrEqual: [ rhs
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
