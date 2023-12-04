Class {
	#name : #SequenceGroupTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
SequenceGroupTest >> testEmptyPowerset [
	self assert: Set new powerset equals: (Set with: Set new)
]

{ #category : #tests }
SequenceGroupTest >> testGroup0 [
	"well-known test from the Haskell reference"
	self assert: 'aabb' group equals: { 'aa' . 'bb' }
]

{ #category : #tests }
SequenceGroupTest >> testGroup1 [
	"well-known test from the Haskell reference"
	self assert: #(1 2 2 1 1 1 2 2 2 1) group equals: { #(1) . #(2 2) . #(1 1 1) . #(2 2 2) . #(1) }
]

{ #category : #tests }
SequenceGroupTest >> testGroup2 [
	"well-known test from the Haskell reference"
	self assert: 'abbcdddeea' group equals: { 'a' . 'bb' . 'c' . 'ddd' . 'ee' . 'a' }
]

{ #category : #tests }
SequenceGroupTest >> testGroup3 [
	"well-known test from the Haskell reference"
	self assert: 'Mississippi' group equals: { 'M'.'i'.'ss'.'i'.'ss'.'i'.'pp'.'i' }

]

{ #category : #tests }
SequenceGroupTest >> testPowerset [
	self
		assert: #(1 2 3) asSet powerset
		equals: {
			#() asSet.
			#(1) asSet.
			#(2) asSet.
			#(3) asSet.
			#(1 2) asSet.
			#(1 3) asSet.
			#(2 3) asSet.
			#(1 2 3) asSet
		} asSet
]

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
