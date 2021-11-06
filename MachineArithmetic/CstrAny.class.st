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
CstrAny >> mathSymbol [
	^Character value: 16r2203
]
