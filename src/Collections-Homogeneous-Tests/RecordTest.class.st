Class {
	#name : #RecordTest,
	#superclass : #TestCase,
	#category : #'Collections-Homogeneous-Tests'
}

{ #category : #tests }
RecordTest >> testAccessingElements [
	| R r |

	R := Record ofAll: { #x ∷ Integer . #y ∷ Integer }.
	r := R basicNew.

	self assert: (r at: #x) isNil.
	self assert: (r at: #y) isNil.

	self should: [ r at: #foo ] raise: KeyNotFound.
	self should: [ r at: self ] raise: KeyNotFound.
	self should: [ r at: 1 ] raise: KeyNotFound.

	r at:#x put: 10.
	r at:#y put: 20.

	self assert: (r at: #x) equals: 10.
	self assert: (r at: #y) equals: 20.

	self should: [ r at: #foo put: true ] raise: KeyNotFound.
	self should: [ r at: self put: false] raise: KeyNotFound.
]

{ #category : #tests }
RecordTest >> testSubclassing [
	| R |
	
	R := Record empty.
	self assert: R slots size equals: 0.
	self should: [ R new ] raise: ShouldNotImplement.
	self assert: R basicNew class equals: R.
	
	R := Record ofAll: { #x ∷ Integer. #y ∷ String }.
	self assert: R slots size equals: 2.
	self should: [ R new ] raise: ShouldNotImplement.
	self assert: R basicNew class equals: R.

	

]
