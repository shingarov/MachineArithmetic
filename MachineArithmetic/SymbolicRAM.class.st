Class {
	#name : #SymbolicRAM,
	#superclass : #SimSymbolicMemory,
	#category : #'MachineArithmetic-SymSim'
}

{ #category : #permissions }
SymbolicRAM >> getReadableAt: addr [
	"NB: we can also do permissions: addr _: newPermissionsBits.
	Should write a test case about it."
	^(self permissions: addr) value bitAnd: 2r001
]
