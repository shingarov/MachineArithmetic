Class {
	#name : #SimState,
	#superclass : #External,
	#instVars : [
		'solver'
	],
	#category : #'MachineArithmetic-SymSim'
}

{ #category : #'instance creation' }
SimState class >> arch: archName [
	"Instantiate a new symbolic simulation state.
	The design of this will change in the future,
	because it is illogical to need a whole machine state
	(knowing the PDL etc) to just create a bit vector."
	| args |
	args := Dictionary new
		at: 'arch' put: (ArchInfo arch: archName);
		at: 'mode' put: 'symbolic';
		yourself.
	^GenericPyObject create: 'angr.SimState' constructorNamedArgs: args
]

{ #category : #'instance creation' }
SimState class >> ensureArch: archName [
	self now ifNotNil: [ :simStateNow | ^simStateNow ].
	"Nothing in the caller chain, return a new one"
	^self arch: archName
]

{ #category : #'instance creation' }
SimState class >> now [
	| c |
	c := thisContext findContextSuchThat:
		[ :aContext | aContext hasTemporaryVariableNamed: 'specialSimulationState' ].
	c isNil ifTrue: [ ^nil ].
	^c tempNamed: 'specialSimulationState'

]

{ #category : #private }
SimState class >> pythonClassName [ 
	^'SimState'
]

{ #category : #access }
SimState >> archInfo [
	^ArchInfo fromExternalID: (self var, '.arch')
]

{ #category : #access }
SimState >> cacheSolver [
	solver := Solver fromExternalID: (self var, '.solver')
]

{ #category : #ivar }
SimState >> cgc [
	"Information about the cgc environment"
	^P compute: self ref, '.cgc'
]

{ #category : #ivar }
SimState >> fs [
	"The current state of the simulated filesystem"
	^P compute: self ref, '.fs'
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

{ #category : #ivar }
SimState >> libc [
	"Information about the standard library we are emulating"
	^P compute: self ref, '.libc'
]

{ #category : #ivar }
SimState >> log [
	"Information about the state's history"
	^P compute: self ref, '.log'
]

{ #category : #ivar }
SimState >> mem [
	"A convenient view of the state's memory, a SimMemView"
	^P compute: self ref, '.mem'
]

{ #category : #ivar }
SimState >> memory [
	"The state's memory as a flat memory region"
	^P compute: self ref, '.memory'
]

{ #category : #ivar }
SimState >> posix [
	"MISNOMER: information about the operating system or environment model"
	^P compute: self ref, '.posix'
]

{ #category : #ivar }
SimState >> registers [
	"The state's register file as a flat memory region"
	^P compute: self ref, '.registers'
]

{ #category : #ivar }
SimState >> regs [
	"A convenient view of the state's registers, where each register is a property"
	^P compute: self ref, '.regs'
]

{ #category : #ivar }
SimState >> scratch [
	"Information about the current execution step"
	^P compute: self ref, '.scratch'
]

{ #category : #ivar }
SimState >> simInspector [
	"The breakpoint manager, a SimInspector"
	^P compute: self ref, '.inspect'
]

{ #category : #access }
SimState >> solver [
	solver isNil ifTrue: [ self cacheSolver ].
	^solver
]

{ #category : #ivar }
SimState >> ucManager [
	"Control of under-constrained symbolic execution"
	^P compute: self ref, '.uc_manager'
]

{ #category : #ivar }
SimState >> unicorn [
	"Control of the Unicorn Engine"
	^P compute: self ref, '.unicorn'
]
