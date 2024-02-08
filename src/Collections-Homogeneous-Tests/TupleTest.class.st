Class {
	#name : #TupleTest,
	#superclass : #TestCase,
	#category : #'Collections-Homogeneous-Tests'
}

{ #category : #tests }
TupleTest >> testAccessingElements [
	| P p |

	P := Tuple ofAll: { Integer . Integer }.
	p := P new.

	self assert: (p at: 1) isNil.
	self assert: (p at: 2) isNil.

	self should: [ p at: 0 ] raise: SubscriptOutOfBounds.
	self should: [ p at: 3 ] raise: SubscriptOutOfBounds.
	self should: [ p at: #xuz ] raise: Error.

	p at: 1 put: 10.

	self assert: (p at: 1) = 10.

	self should: [ p at: 0 put: 0] raise: SubscriptOutOfBounds.
	self should: [ p at:10 put: 0] raise: SubscriptOutOfBounds.
]

{ #category : #tests }
TupleTest >> testSubclassing [
	| T |
	
	T := Tuple empty.
	self assert: T slots size equals: 0.
	
	T := Tuple ofAll: { Integer. String }.
	self assert: T slots size equals: 2.
	

]
