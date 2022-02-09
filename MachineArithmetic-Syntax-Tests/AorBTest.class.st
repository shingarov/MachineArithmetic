Class {
	#name : #AorBTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Syntax-Tests'
}

{ #category : #tests }
AorBTest >> testA [
	self
		assert: (AorB parser parse: '(-12345)') class
		equals: A
]

{ #category : #tests }
AorBTest >> testBFigured [
	self
		assert: (AorB parser parse: '{-12345}') class
		equals: BFigured 
]

{ #category : #tests }
AorBTest >> testBSquared [
	self
		assert: (AorB parser parse: '[-12345]') class
		equals: BSquared
]

{ #category : #tests }
AorBTest >> testInteger [
	self
		assert: (Integer parser parse: '12345')
		equals: 12345
]

{ #category : #tests }
AorBTest >> testNegativeInteger [
	self
		assert: (Integer parser parse: '-12345')
		equals: -12345
]
