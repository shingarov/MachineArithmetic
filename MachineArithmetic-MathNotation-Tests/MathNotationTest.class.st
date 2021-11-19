Class {
	#name : #MathNotationTest,
	#superclass : #TestCaseWithZ3Context,
	#category : #'MachineArithmetic-MathNotation-Tests'
}

{ #category : #'z3 context' }
MathNotationTest >> setUp [
	super setUp.
	ℤ := Int sort. "needed because every test run re-creates a new Z3Context"
]
