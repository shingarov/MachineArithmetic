Class {
	#name : #DecidableRefinementTest,
	#superclass : #TestCase,
	#category : #'Refinements-Tests'
}

{ #category : #tests }
DecidableRefinementTest >> testUndeclaredVar [
	| p evalEnv |
	p := DecidableRefinement text: 'x+1'.
	evalEnv := EvalEnv constants: Dictionary new.
	self
		should: [p evaluateIn: evalEnv]
		raise: VariableNotDeclared
]
