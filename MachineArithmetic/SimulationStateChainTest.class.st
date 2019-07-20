Class {
	#name : #SimulationStateChainTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests'
}

{ #category : #tests }
SimulationStateChainTest >> testIdiocy [
	| c |
	c := thisContext findContextSuchThat: [ :aContext | aContext hasTemporaryNamed: 'specialSimulationState' ].
	c tempNamed: 'specialSimulationState'.
	c
]
