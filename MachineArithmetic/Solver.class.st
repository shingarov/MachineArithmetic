Class {
	#name : #Solver,
	#superclass : #External,
	#category : #'MachineArithmetic-SymSim'
}

{ #category : #private }
Solver class >> pythonClassName [
	^'SimSolver'
]

{ #category : #operations }
Solver >> add: aConstraint [
	P compute: self ref, '.add(', aConstraint ref, ')'
]

{ #category : #operations }
Solver >> eval: anAST [ 
	^P compute: self ref, '.eval(', anAST ref, ')'
]

{ #category : #operations }
Solver >> isSatisfiable [
	^P eval: self ref, '.satisfiable()'
]
