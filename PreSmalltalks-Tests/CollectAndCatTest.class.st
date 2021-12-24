Class {
	#name : #CollectAndCatTest,
	#superclass : #TestCase,
	#category : #'PreSmalltalks-Tests'
}

{ #category : #tests }
CollectAndCatTest >> test1 [
	| ω result |
	ω := 1000000000000000000000000000000000000000000000000000000000.
	result := { 1 to: ω.  10 to: ω.  100 to: ω.  1000 to: ω. }
	 "{ 1 to: ∞.  10 to: ∞.  100 to: ∞.  1000 to: ∞. }"
			collectAndCat: [ :a | a copyFrom: 1 to: 3 ].
	self assert: result equals: #(1 2 3 10 11 12 100 101 102 1000 1001 1002)
]
