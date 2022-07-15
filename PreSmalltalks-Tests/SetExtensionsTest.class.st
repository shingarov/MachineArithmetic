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
