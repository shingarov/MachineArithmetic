Class {
	#name : #SetExtensionsTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
SetExtensionsTest >> testUnions [
	self
		assert: (Set unionAll: { #(1 2 3) asSet . #(3 4) asSet })
		equals: #(1 2 3 4) asSet
]

{ #category : #tests }
SetExtensionsTest >> testWithout [
	| initialSet finalSet |
	initialSet := Set with: 1 with: 2 with: 3.
	finalSet := initialSet without: 2.
	
	self
		assert: finalSet
		equals: #(1 3) asSet
]

{ #category : #tests }
SetExtensionsTest >> testWithoutMeansEquality [
	| initialSet finalSet |
	initialSet := Set with: #a with: #b.
	finalSet := initialSet without: 'a'.
	
	self
		assert: finalSet
		equals: #(b) asSet
]

{ #category : #tests }
SetExtensionsTest >> testWithoutNotFound [
	| initialSet finalSet |
	initialSet := Set with: 1 with: 2 with: 3.
	finalSet := initialSet without: 5.
	
	self
		assert: finalSet
		equals: #(1 2 3) asSet
]
