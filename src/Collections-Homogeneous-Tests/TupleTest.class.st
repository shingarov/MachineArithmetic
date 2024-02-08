Class {
	#name : #TupleTest,
	#superclass : #TestCase,
	#category : #'Collections-Homogeneous-Tests'
}

{ #category : #tests }
TupleTest >> testEmptyProduct [
	| t |
	t := Tuple empty.
	self assert: t slots size equals: 0.
	self assert: (t⨰Integer) slots size equals: 1
]

{ #category : #tests }
TupleTest >> testProductComposition [
	| t |
	t := Int ⨰ String ⨰ Int.
	self assert: t slots size equals: 3
]
