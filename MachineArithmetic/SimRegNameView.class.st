Class {
	#name : #SimRegNameView,
	#superclass : #External,
	#category : #'MachineArithmetic-SymSim'
}

{ #category : #private }
SimRegNameView class >> pythonClassName [ 
	^'SimRegNameView'
]

{ #category : #accessing }
SimRegNameView >> associations [
	^self keys collect: [ :regName |
		regName -> (self at: regName) printForRegisterInspector ]

]

{ #category : #accessing }
SimRegNameView >> at: regName [
	^P compute: self ref, '.', regName
]

{ #category : #accessing }
SimRegNameView >> at: regName put: v [ 
	"Here, addr is a concrete Integer"
	| vv |
	vv := v asBitVector: 32.
	super at: regName put: vv
]

{ #category : #accessing }
SimRegNameView >> keys [
	"SimRegNameView.__dir__() contains non-orthogonal black magic:
	it checks for arch name and does special things on X86, AMD64 and arm."
	^(#('X86' 'AMD64') includes: self @ 'state' @ 'arch' @ 'name')
		ifTrue: [ self __dir__ ]
		ifFalse: [ P compute: 'list(', self ref, '.__dir__())' ]
]
