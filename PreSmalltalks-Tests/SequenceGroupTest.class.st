Class {
	#name : #SequenceGroupTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
SequenceGroupTest >> testSpan0 [
	| result |
	result := #(1 9) span: [ :x | x < 3 ].
	self assert: result equals: (Array with: #(1) with: #(9))
]

{ #category : #tests }
SequenceGroupTest >> testSpan1 [
	| result |
	result := #(1 2 3 4 1 2 3 4) span: [ :x | x < 3 ].
	self assert: result equals: (Array with: #(1 2) with: #(3 4 1 2 3 4))
]

{ #category : #tests }
SequenceGroupTest >> testSpan2 [
	| result |
	result := #(1 2 3) span: [ :x | x < 9 ].
	
	self assert: result size equals: 2.
	self assert: result second isEmpty.
	self assert: result first equals: #(1 2 3)
]

{ #category : #tests }
SequenceGroupTest >> testSpan3 [
	| result |
	result := #(1 2 3) span: [ :x | x < 0 ].
	
	self assert: result size equals: 2.
	self assert: result first isEmpty.
	self assert: result second equals: #(1 2 3)
]

{ #category : #tests }
SequenceGroupTest >> testSpanEmpty [
	| result |
	result := #() span: [ :x | x < 3 ].
	
	self assert: result size equals: 2.
	self assert: result first isEmpty.
	self assert: result second isEmpty.

]
