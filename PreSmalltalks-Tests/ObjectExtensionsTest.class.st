Class {
	#name : #ObjectExtensionsTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #'tests - maybe' }
ObjectExtensionsTest >> testMaybe_default [
	self deny: (
		nil maybe: false f: #odd
	)
]

{ #category : #'tests - maybe' }
ObjectExtensionsTest >> testMaybe_just [
	self assert: (
		3 maybe: false f: #odd
	)
]
