Class {
	#name : #ArithmeticTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
ArithmeticTest >> testEuclideanMod [
	self assert: (7  mod:  3) equals: 1.
	self assert: (7  mod: -3) equals: 1.
	self assert: (-7 mod:  3) equals: 2.
	self assert: (-7 mod: -3) equals: 2.
]
