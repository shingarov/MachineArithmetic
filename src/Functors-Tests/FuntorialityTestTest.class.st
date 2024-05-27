Class {
	#name : #FuntorialityTestTest,
	#superclass : #TestCase,
	#category : #'Functors-Tests'
}

{ #category : #tests }
FuntorialityTestTest >> checkFunctorialityFor: aClass [
	self
		assert: ((aClass with: 42) collect: #squared)
		equals: (aClass with: 42 squared)
]

{ #category : #tests }
FuntorialityTestTest >> functorsUnderTest [
	^{ Array. Bag. Set. OrderedCollection. Just }
]

{ #category : #tests }
FuntorialityTestTest >> testCommutativityEmpty [
	self
		assert: (nil collect: #moooooo)
		equals: nil
]

{ #category : #tests }
FuntorialityTestTest >> testFunctoriality [
	self functorsUnderTest do: [ :F | self checkFunctorialityFor: F ]
]

{ #category : #tests }
FuntorialityTestTest >> testIdentityEmpty [
	self
		assert: (nil collect: #yourself)
		equals: nil
]
