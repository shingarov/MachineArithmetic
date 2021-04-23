Class {
	#name : #Uninterpreted,
	#superclass : #Z3AST,
	#category : #'MachineArithmetic-Core'
}

{ #category : #printing }
Uninterpreted class >> printSort: anUninterpretedSort on: aStream [ 
	anUninterpretedSort name printOn: aStream 
]
