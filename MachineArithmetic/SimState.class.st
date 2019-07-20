Class {
	#name : #SimState,
	#superclass : #External,
	#instVars : [
		'solver'
	],
	#category : #'MachineArithmetic-SymSim'
}

{ #category : #'instance creation' }
SimState class >> arch: aPDL [
	"Instantiate a new symbolic simulation state.
	The design of this will change in the future,
	because it is illogical to need a whole machine state
	(knowing the PDL etc) to just create a bit vector.
	Also, right now we don't even do anything with aPDL,
	the Gate assumes PPC32: this is totally bogus."
	^P compute: 'angr.SimState(arch=arch, mode="symbolic")'
]

{ #category : #'instance creation' }
SimState class >> now [
	| c s |
	c := thisContext findContextSuchThat: [ :aContext | aContext hasTemporaryVariableNamed: 'specialSimulationState' ].
	(c notNil and: [ s := c tempNamed: 'specialSimulationState'. s notNil ]) ifTrue: [ ^s ].
	"Nothing in the caller chain, return a new one"
	^SimState arch: #bogus
]

{ #category : #private }
SimState class >> pythonClassName [ 
	^'SimState'
]

{ #category : #access }
SimState >> cacheSolver [
	solver := P compute: self ref, '.solver'.

]

{ #category : #GT }
SimState >> gtInspectorItemsIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ (composite fastTable)
		title: 'Registers';
		display: [ self regs associations ];
		column: 'Reg' evaluated: #key;
		column: 'Value' evaluated: #value;
		beSingle;
		send: [ :selection | 
			selection isNil 
			ifTrue:[nil]
			ifFalse:[ self regs at: selection key ]]
]

{ #category : #'machine state' }
SimState >> ip [
	^P eval: self ref, '.ip.args[0]'
]

{ #category : #'machine state' }
SimState >> registers [
	^P compute: self ref, '.registers'
]

{ #category : #'machine state' }
SimState >> regs [
	^P compute: self ref, '.regs'
]

{ #category : #access }
SimState >> solver [
	solver isNil ifTrue: [ self cacheSolver ].
	^solver
]
