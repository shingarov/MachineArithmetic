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
CurryingTest >> testUncurry [
	self
		assert: ([ :x | [ :y | x+y ]] value: 3 value: 4)
		equals: 7
]
