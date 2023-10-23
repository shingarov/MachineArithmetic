Class {
	#name : #ShallowRefinementTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'Refinements-Tests'
}

{ #category : #'tests - factorial' }
ShallowRefinementTest >> testAllFactorialsDiverge [
	| factLT100 |
	factLT100 := Int sort | [ :n | n factorial < 100 ].
	false ifTrue: [ factLT100 allElements ] "DIVERGES!"

]

{ #category : #'tests - creating refinements' }
ShallowRefinementTest >> testAllGT10LT15 [
	| gt10 lt20 S |
	gt10 := Int sort | [ :n | n > 10 ].
	lt20 := Int sort | [ :n | n < 15 ].
	S := (lt20 ∩ gt10) allElements.
	self assert: 12 ∈ S.
	self deny:   10 ∈ S.
	self assert: S size equals: 4.
]

{ #category : #'tests - creating refinements' }
ShallowRefinementTest >> testGT10 [
	| gt10 |
	gt10 := Int sort | [ :n | n > 10 ].
	self assert: gt10 anyOne > 10
]

{ #category : #'tests - creating refinements' }
ShallowRefinementTest >> testGT10LT15 [
	| gt10 lt20 x |
	gt10 := Int sort | [ :n | n > 10 ].
	lt20 := Int sort | [ :n | n < 15 ].
	x := (lt20 ∩ gt10) anyOne.
	self assert: x > 10.
	self assert: x < 15
]

{ #category : #'tests - factorial' }
ShallowRefinementTest >> testInvertFactorial [
	self
		assert: (Int sort | [ :n | n factorial === 120 ]) anyOne
		equals: 5
]

{ #category : #'tests - sets' }
ShallowRefinementTest >> testSubset [
	| gt1 gt0 |
	gt1 := Int sort | [ :n | n > 1 ].
	gt0 := Int sort | [ :n | n > 0 ].
	self assert: gt1 ⊆ gt0.
	self deny:   gt0 ⊆ gt1.
]
