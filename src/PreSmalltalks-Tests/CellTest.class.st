Class {
	#name : #CellTest,
	#superclass : #TestCase,
	#instVars : [
		'cell'
	],
	#category : #'PreSmalltalks-Tests'
}

{ #category : #running }
CellTest >> setUp [
	cell := Cell new
]

{ #category : #tests }
CellTest >> testArrayAPI [
	self assert: (cell at: 1) isNil.
	self assert: (cell first) isNil.	
	
	cell at: 1 put: 'abc'.
	self assert: (cell at: 1) = 'abc'.
	self assert: (cell first) = 'abc'.
	
	self should: [ cell at: 2 ] raise: AssertionFailure.
	self should: [ cell at: 2 put: 'xyz' ] raise: AssertionFailure.
	 
]

{ #category : #tests }
CellTest >> testGetBeforeSet [
	self should: [ cell get ] raise: Error
]

{ #category : #tests }
CellTest >> testSetAfterSet [
	cell set: 42.
	self should: [ cell set: 43 ] raise: Error
]

{ #category : #tests }
CellTest >> testSetGet [
	cell set: 'abc'.
	self assert: cell get == 'abc'
]
