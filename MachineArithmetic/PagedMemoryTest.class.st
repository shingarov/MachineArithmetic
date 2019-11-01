Class {
	#name : #PagedMemoryTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests-RAM'
}

{ #category : #tests }
PagedMemoryTest >> testExperiment1 [
	| pagedMem page |
	pagedMem := GenericPyObject create: 'angr.storage.SimPagedMemory' constructorSequentialArgs: #().
	pagedMem at: 'state' put: (SimState ensureArch: 'powerpc').
	pagedMem map_region: 0 length: 256 permissions: 2r111 initZero: true.
	page := pagedMem @'_pages' at: 0.
	self assert: page @'concrete_permissions'  equals: 7
]
