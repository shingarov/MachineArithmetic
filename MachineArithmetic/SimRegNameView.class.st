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
	P rawExec: self ref, '.', regName, ' = ', vv ref.
	^nil
]

{ #category : #accessing }
SimRegNameView >> keys [
	^P eval: self ref, '.__dir__()'
]
