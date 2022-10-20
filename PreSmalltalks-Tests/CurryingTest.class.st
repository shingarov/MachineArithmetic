Class {
	#name : #CurryingTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
CurryingTest >> testChainedCurry [
	| block applied1 applied2 |
	block := [ :x :y :z | x+y+z ].
	applied1 := block value: 3.
	applied2 := applied1 value: 4.
	self
		assert: (applied2 value: 5)
		equals: 12
]

{ #category : #tests }
CurryingTest >> testCurry [
	| block partiallyAppliedBlock |
	block := [ :x :y | x+y ].
	partiallyAppliedBlock := block value: 3.
	self
		assert: (partiallyAppliedBlock value: 4)
		equals: 7
]

{ #category : #tests }
CurryingTest >> testCurryingCollect [
	| partial |
	self skip "http://lists.squeakfoundation.org/pipermail/vm-dev/2022-October/038462.html".
	partial := { 'abc' . 'xyz' . '123' } collect: #beginsWith: .
	self
		assert: (partial collect: [ :x | x value: 'a' ])
		equals: { true . false . false }
]

{ #category : #tests }
CurryingTest >> testCurryingCollectInt [
	| partial |
	self skip "http://lists.squeakfoundation.org/pipermail/vm-dev/2022-October/038462.html".
	partial := { 5 . 6 . 7 } collect: #isDivisibleBy: .
	self
		assert: (partial collect: [ :x | x value: 2 ])
		equals: { false . true . false }
]

{ #category : #tests }
CurryingTest >> testPartialPerform [
	| partial |
	partial := 15 perform: #isDivisibleBy: .
	self
		assert: (partial value: 2)
		equals: false.
	self
		assert: (partial value: 3)
		equals: true.
]

{ #category : #tests }
CurryingTest >> testUncurry [
	self
		assert: ([ :x | [ :y | x+y ]] value: 3 value: 4)
		equals: 7
]
