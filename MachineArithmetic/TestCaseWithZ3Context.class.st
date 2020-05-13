Class {
	#name : #TestCaseWithZ3Context,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests-Z3'
}

{ #category : #'z3 context' }
TestCaseWithZ3Context >> setUp [
	Z3Context createGlobalContext 
]

{ #category : #'z3 context' }
TestCaseWithZ3Context >> tearDown [
	Z3Context current del
]
