Class {
	#name : #HoleTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
HoleTest >> testNotHole [
	self deny: nil isHole.
	self deny: 123 isHole
]

{ #category : #tests }
HoleTest >> testUnderbar [
	self assert: _ isHole
]
