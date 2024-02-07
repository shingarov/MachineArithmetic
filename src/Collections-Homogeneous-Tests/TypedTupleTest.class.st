Class {
	#name : #TypedTupleTest,
	#superclass : #TestCase,
	#category : #'Collections-Homogeneous-Tests'
}

{ #category : #tests }
TypedTupleTest >> testAccessingNamedElements [
	| P p |
	
	P := TypedTuple ofAll: { #x ∷ Integer . #y ∷ Integer }.
	p := P new.
	
	self assert: (p at: 1) isNil.
	self assert: (p at: 2) isNil.

	self should: [ p at: 0 ] raise: SubscriptOutOfBounds. 
	self should: [ p at: 3 ] raise: SubscriptOutOfBounds.
	
	self assert: (p at: #x) isNil.
	self assert: (p at: #y) isNil.
	
	self should: [ p at: #foo ] raise: KeyNotFound. 
	self should: [ p at: self ] raise: KeyNotFound.
	
	p at: 1 put: 10.
	p at:#y put: 20.
	
	self assert: (p at: 1) = 10.
	self assert: (p at: 2) = 20.

	self should: [ p at: 0 put: 0] raise: SubscriptOutOfBounds. 
	self should: [ p at:10 put: 0] raise: SubscriptOutOfBounds. 
	
	self should: [ p at: #foo put: true ] raise: KeyNotFound. 
	self should: [ p at: self put: false] raise: KeyNotFound.
]

{ #category : #tests }
TypedTupleTest >> testEmptyProduct [
	| t |
	t := TypedTuple empty.
	self assert: t slots size equals: 0.
	self assert: (t⨰Integer) slots size equals: 1
]

{ #category : #tests }
TypedTupleTest >> testProductComposition [
	| t |
	t := Int ⨰ String ⨰ Int.
	self assert: t slots size equals: 3
]
