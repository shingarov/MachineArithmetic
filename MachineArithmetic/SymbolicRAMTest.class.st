Class {
	#name : #SymbolicRAMTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests-RAM'
}

{ #category : #tests }
SymbolicRAMTest >> testCreateSymbolicRAM [
	| page pagedMemory ram |
	page := RAMPage
		contents: #[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]
		startAddr: 256
		permissions: 2r001.	
	pagedMemory := SimPagedMemory with: page state: (SimState ensureArch: 'powerpc').
	ram := SymbolicRAM pagedMemory: pagedMemory endian: #big.
	self assert: (ram isKindOf: SymbolicRAM).
	self assert: (ram permissionsAt: 3) equals: 2r001
]
