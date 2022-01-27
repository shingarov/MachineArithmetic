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
AorBTest >> testB [
	self
		assert: (AorB parser parse: '[-12345]') class
		equals: B
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
