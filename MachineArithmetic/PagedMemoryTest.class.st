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
	| page |
	page := RAMPage
		contents: #[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]
		startAddr: 256
		permissions: 2r001.
	self assert: (page isKindOf: RAMPage).
	self assert: page @'concrete_permissions'  equals: 2r001.
	self assert: page @'_page_size' equals: 16.
	self assert: (page load_mo: nil page_idx: 256+1) equals: 2.

]

{ #category : #tests }
PagedMemoryTest >> testPagedRAMwithPage [
	| page pagedRAM |
	page := RAMPage
		contents: #[1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16]
		startAddr: 0
		permissions: 2r001.
	pagedRAM := GenericPyObject
		create: 'angr.storage.paged_memory.SimPagedMemory'
		constructorNamedArgs: (Dictionary new "FIXME figure out page sizes"
			at: 'pages' put: (Dictionary new 
				at: 0
				put: page;
				yourself);
			yourself).
			
			pagedRAM __getitem__: 0.
			
	self assert: page @'concrete_permissions'  equals: 2r001.
	self assert: page @'_page_size' equals: 16.
	self assert: (page load_mo: nil page_idx: 256+1) equals: 2.

]
