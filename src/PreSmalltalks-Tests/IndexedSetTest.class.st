Class {
	#name : #IndexedSetTest,
	#superclass : #TestCase,
	#instVars : [
		'hotel'
	],
	#category : #'PreSmalltalks-Tests'
}

{ #category : #running }
IndexedSetTest >> setUp [
	hotel := IndexedSet new
]

{ #category : #tests }
IndexedSetTest >> testAddGuest [
	self assert: hotel size equals: 0.
	self assert: (hotel addElement: 'abc') equals: 1.
	self assert: (hotel addElement: 'def') equals: 2.
	self assert: (hotel addElement: 'abc') equals: 1.

]

{ #category : #tests }
IndexedSetTest >> testIndicesStay [
	self assert: hotel size equals: 0.
	self assert: (hotel addElement: 'a') equals: 1.
	self assert: (hotel addElement: 'b') equals: 2.
	self assert: (hotel addElement: 'c') equals: 3.
	self assert: (hotel addElement: 'a') equals: 1.
	hotel remove: 'a'.
	self assert: (hotel addElement: 'b') equals: 2.
	self assert: (hotel addElement: 'c') equals: 3.
]
