Class {
	#name : #CstrAny,
	#superclass : #CstrQuantifier,
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #logic }
CstrAny >> isNNF [ 
	^ false
]

{ #category : #printing }
CstrAny >> tagName [
	^ 'exists'
]
