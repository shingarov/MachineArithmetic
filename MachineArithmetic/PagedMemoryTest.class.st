Class {
	#name : #PagedMemoryTest,
	#superclass : #TestCase,
	#category : #'MachineArithmetic-Tests-RAM'
}

{ #category : #tests }
PagedMemoryTest >> testInstantiateEmptyPagedRAM [
	| pagedMem page |
	pagedMem := GenericPyObject create: 'angr.storage.SimPagedMemory' constructorSequentialArgs: #().
	pagedMem at: 'state' put: (SimState ensureArch: 'powerpc').
	pagedMem map_region: 0 length: 256 permissions: 2r101 initZero: true.
	page := pagedMem @'_pages' at: 0.
	self assert: page @'concrete_permissions'  equals: 2r101.
	
]

{ #category : #tests }
PagedMemoryTest >> testInstantiatePage [
	| initParms page |
	initParms := Dictionary new
		at: 'page_addr' put: 256;
		at: 'page_size' put: 16;
		at: 'permissions' put: (2r001 asBitVector: 3);
		at: 'storage' put: #[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
		yourself.
	page := GenericPyObject create: 'angr.storage.paged_memory.Page' constructorNamedArgs: initParms.
	self assert: page @'concrete_permissions'  equals: 2r001.
	self assert: page @'_page_size' equals: 16.
	self assert: (page load_mo: nil page_idx: 256+1) equals: 2.

]

{ #category : #tests }
PagedMemoryTest >> testPagedRAMwithPage [
	| pageParms page |
	pageParms := Dictionary new
		at: 'page_addr' put: 256;
		at: 'page_size' put: 16;
		at: 'permissions' put: (2r001 asBitVector: 3);
		at: 'storage' put: #[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
		yourself.
	page := GenericPyObject create: 'angr.storage.paged_memory.Page' constructorNamedArgs: pageParms.
	self assert: page @'concrete_permissions'  equals: 2r001.
	self assert: page @'_page_size' equals: 16.
	self assert: (page load_mo: nil page_idx: 256+1) equals: 2.

]
