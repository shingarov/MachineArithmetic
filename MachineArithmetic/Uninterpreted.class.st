Class {
	#name : #Uninterpreted,
	#superclass : #AST,
	#category : #'MachineArithmetic-Core'
}

{ #category : #printing }
Uninterpreted class >> printSort: anUninterpretedSort on: aStream [ 
	anUninterpretedSort name printOn: aStream 
]

{ #category : #adapting }
Uninterpreted >> beLikeMe: anUninterpreted [ 
	^anUninterpreted "too bad if it's not"
]
