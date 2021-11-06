"
I am an environment of unrefined type bindings.
"
Class {
	#name : #Gamma,
	#superclass : #Object,
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'well-formedness' }
Gamma >> |- c [
	^c wfIn: self
]
