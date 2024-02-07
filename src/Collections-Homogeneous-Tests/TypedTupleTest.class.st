Class {
	#name : #TypedTupleTest,
	#superclass : #TestCase,
	#category : #'Collections-Homogeneous-Tests'
}

{ #category : #tests }
TypedTupleTest >> testEmptyProduct [
	| t |
	t := TypedTuple empty.
	self assert: t slots size equals: 0.
	self assert: (t⨰Integer) slots size equals: 1
]

{ #category : #tests }
TypedTupleTest >> testProductComposition [
	| t |
	t := Int ⨰ String ⨰ Int.
	self assert: t slots size equals: 3
]
