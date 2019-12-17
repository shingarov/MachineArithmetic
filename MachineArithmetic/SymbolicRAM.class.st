Class {
	#name : #SymbolicRAM,
	#superclass : #SimSymbolicMemory,
	#category : #'MachineArithmetic-SymSim'
}

{ #category : #private }
SymbolicRAM class >> pagedMemory: mem endian: bigOrLittle [
	| endian |
	endian := bigOrLittle.
	endian = #big ifTrue: [ 'Iend_BE' ].
	endian = #little ifTrue: [ 'Iend_LE' ].
	^GenericPyObject
		create: 'angr.state_plugins.symbolic_memory.SimSymbolicMemory'
		constructorNamedArgs: (Dictionary new 
			at: 'mem' put: mem;
			at: 'memory_id' put: 'mem';
			at: 'endness' put: 'endian';
			yourself).
			
]

{ #category : #permissions }
SymbolicRAM >> getReadableAt: addr [
	"NB: we can also do permissions: addr _: newPermissionsBits.
	Should write a test case about it."
	^(self permissions: addr) value bitAnd: 2r001
]
