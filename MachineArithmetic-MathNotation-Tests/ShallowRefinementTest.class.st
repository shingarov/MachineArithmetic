Class {
	#name : #ShallowRefinementTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-MathNotation-Tests'
}

{ #category : #tests }
ShallowRefinementTest >> testAllGT10LT15 [
	| gt10 lt20 S |
	gt10 := Int sort | [ :n | n > 10 ].
	lt20 := Int sort | [ :n | n < 15 ].
	S := (lt20 ∩ gt10) allElements.
	self assert: 12 ∈ S.
	self deny:   10 ∈ S.
	self assert: S size equals: 4.
]

{ #category : #tests }
ShallowRefinementTest >> testGT10 [
	| gt10 |
	gt10 := Int sort | [ :n | n > 10 ].
	self assert: gt10 anyOne > 10
]

{ #category : #tests }
ShallowRefinementTest >> testGT10LT15 [
	| gt10 lt20 x |
	gt10 := Int sort | [ :n | n > 10 ].
	lt20 := Int sort | [ :n | n < 15 ].
	x := (lt20 ∩ gt10) anyOne.
	self assert: x > 10.
	self assert: x < 15
]

{ #category : #tests }
ShallowRefinementTest >> testInvertFactorial [
	| factLT1000 |
	factLT1000 := Int sort | [ :n | (Z3FactorialTest factorial value: n) < 100 ].
	false ifTrue: [ factLT1000 allElements ] "DIVERGES!"

]

{ #category : #tests }
ShallowRefinementTest >> testSubset [
	| gt1 gt0 |
	gt1 := Int sort | [ :n | n > 1 ].
	gt0 := Int sort | [ :n | n > 0 ].
	self assert: gt1 <= gt0.
	self deny:   gt0 <= gt1.
]
