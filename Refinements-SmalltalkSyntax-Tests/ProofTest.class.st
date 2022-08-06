Class {
	#name : #ProofTest,
	#superclass : #TestCaseWithZ3Context,
	#instVars : [
		'ℤ',
		'ℝ'
	],
	#category : #'Refinements-SmalltalkSyntax-Tests'
}

{ #category : #'z3 context' }
ProofTest >> setUp [ 
	super setUp.
	ℤ := Int sort.
	ℝ := Real sort.
]
