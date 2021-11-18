Class {
	#name : #ShallowRefinementTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-MathNotation-Tests'
}

{ #category : #tests }
ShallowRefinementTest >> testGT10 [
	| gt10 |
	gt10 := Int sort | [ :n | n > 10 ].
	self assert: gt10 anyOne > 10
]
