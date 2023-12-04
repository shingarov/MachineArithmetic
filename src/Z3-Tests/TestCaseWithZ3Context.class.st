Class {
	#name : #TestCaseWithZ3Context,
	#superclass : #TestCase,
	#category : #'Z3-Tests'
}

{ #category : #'z3 context' }
TestCaseWithZ3Context >> setUp [
	Z3Context createGlobalContext 
]

{ #category : #'z3 context' }
TestCaseWithZ3Context >> tearDown [
	Z3Context current del
]
