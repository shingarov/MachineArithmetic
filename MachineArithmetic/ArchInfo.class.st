"
I provide the ability to use the Python ArchInfo library.

Placing this in MachineArithmetic is illogical and will be reorganized in the near future.  The reason we do it like this for now, is that we need solvers for algebra, and for simplicity we don't distinguish between angr solvers (which we get from SimStates, and therefore we need a CPU architecture) and Z3 solvers.
"
Class {
	#name : #ArchInfo,
	#superclass : #External,
	#category : #'MachineArithmetic-SymSim'
}

{ #category : #crap }
ArchInfo class >> arch: archName [
	"Instantiate a new symbolic simulation state.
	The design of this will change in the future,
	because it is illogical to need a whole machine state
	(knowing the PDL etc) to just create a bit vector."
	
	| knownArchinfo |
	knownArchinfo := ArchInfo knownArchinfos at: archName.
	^P compute: 'archinfo.', knownArchinfo
]

{ #category : #crap }
ArchInfo class >> knownArchinfos [
	^Dictionary new
		at: 'powerpc' put: 'ArchPPC32(archinfo.Endness.BE)';
		at: 'arm'     put: 'ArchARM(archinfo.Endness.LE)';
		at: 'mips'    put: 'ArchMIPS32(archinfo.Endness.BE)';
		at: 'IA32'    put: 'ArchX86(archinfo.Endness.LE)';
		yourself 
		"We don't have ArchC models for these:
			ArchAMD64,
			ArchAArch64,
			ArchPPC64,
			ArchMIPS64,
			ArchSoot,
			ArchS390X.
		 We don't have ArchInfo for these:
			riscv,
			sparc (ArchC models v8)
		"

]

{ #category : #crap }
ArchInfo class >> pythonClassName [ 
	^'Arch'
]

{ #category : #functions }
ArchInfo >> registerNames [
	^self at: 'register_names'
]

{ #category : #functions }
ArchInfo >> registerOffset: regName [
	^Integer readFrom: (self registerNames keyAtValue: regName)
]
