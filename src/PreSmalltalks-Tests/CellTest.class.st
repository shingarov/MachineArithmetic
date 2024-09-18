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
