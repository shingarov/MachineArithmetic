Class {
	#name : #ObjectExtensionsTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #'tests - maybe' }
ObjectExtensionsTest >> testEvaluateUntil_1 [
	self assert: (
		1 evaluate: [ :x | x*2 ] until: [ :x | x>100]
	) equals: 128 

]

{ #category : #'tests - maybe' }
ObjectExtensionsTest >> testEvaluateUntil_2 [
	self assert: (
		400 evaluate: [ :x | x/2 ] until: #odd
	) equals: 25
]

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
