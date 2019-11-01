Class {
	#name : #RAMPage,
	#superclass : #External,
	#category : #'MachineArithmetic-SymSim'
}

{ #category : #'instance creation' }
RAMPage class >> contents: aByteArray
startAddr: addr
permissions: xwr [
	"Create a new Page"

	| initParms |
	initParms := Dictionary new
		at: 'page_addr' put: addr;
		at: 'page_size' put: (aByteArray size);
		at: 'permissions' put: (xwr asBitVector: 3);
		at: 'storage' put: aByteArray;
		yourself.
	^GenericPyObject create: 'angr.storage.paged_memory.Page' constructorNamedArgs: initParms
]

{ #category : #'instance creation' }
RAMPage class >> pythonClassName [ 
	^'ListPage'
]
