Class {
	#name : #DecidableRefinementTest,
	#superclass : #TestCase,
	#category : #'Refinements-Doodles'
}

{ #category : #tests }
DecidableRefinementTest >> testEvalEnvMonoid [
	| p γ1 γ2 |
	γ1 := EvalEnv constants: (Dictionary newFromAssociations: {'x'->3}).
	γ2 := EvalEnv constants: (Dictionary newFromAssociations: {'y'->4}).
	p := DecidableRefinement text: 'x+y'.
	self
		assert: ( p evaluateIn: γ1, γ2 )
		equals: 7
]

{ #category : #tests }
DecidableRefinementTest >> testUndeclaredVar [
	| p evalEnv |
	p := DecidableRefinement text: 'x+1'.
	evalEnv := EvalEnv constants: Dictionary new.
	self
		should: [p evaluateIn: evalEnv]
		raise: VariableNotDeclared
]
