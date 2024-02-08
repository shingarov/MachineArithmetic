Class {
	#name : #RecordTest,
	#superclass : #TestCase,
	#category : #'Collections-Homogeneous-Tests'
}

{ #category : #tests }
RecordTest >> testSubclassing [
	| R |
	
	R := Record empty.
	self assert: R slots size equals: 0.
	
	R := Record ofAll: { #x ∷ Integer. #y ∷ String }.
	self assert: R slots size equals: 2.
	

]
