Class {
	#name : #TupleTest,
	#superclass : #TestCase,
	#category : #'Collections-Homogeneous-Tests'
}

{ #category : #tests }
TupleTest >> testSubclassing [
	| T |
	
	T := Tuple empty.
	self assert: T slots size equals: 0.
	
	T := Tuple ofAll: { Integer. String }.
	self assert: T slots size equals: 2.
	

]
