"
TODO: rename in the honor of its inventor
"
Class {
	#name : #SimSymbolicMemory,
	#superclass : #External,
	#category : #'MachineArithmetic-SymSim'
}

{ #category : #private }
SimSymbolicMemory class >> categoryOf: anExternalID [
	^P eval: anExternalID ref, '.category'
]

{ #category : #private }
SimSymbolicMemory class >> fromExternalID: anExternalID [ 
	| cat concreteClass |
	cat := self categoryOf: anExternalID.
	"only mem and reg exist, so the following should be safe"
	concreteClass := cat='reg' ifTrue: [ SymbolicRegisterFile ] ifFalse: [ SymbolicRAM ].
	^concreteClass var: anExternalID
]

{ #category : #private }
SimSymbolicMemory class >> pythonClassName [ 
	^'SimSymbolicMemory'
]

{ #category : #operations }
SimSymbolicMemory >> permissionsAt: addr [
	"Here, addr is a concrete Integer"
	^P compute: self ref, '.permissions(', addr printString, ')'
]
