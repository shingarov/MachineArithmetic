Class {
	#name : #BoolValue,
	#superclass : #Bool,
	#category : #'MachineArithmetic-Logic'
}

{ #category : #private }
BoolValue class >> fromExternalID: anExternalID [ 
	| truth |
	truth := P eval: anExternalID ref, '.args[0]'.
	^truth
		ifTrue: [ BoolTrue var: anExternalID ]
		ifFalse: [ BoolFalse var: anExternalID ]
]

{ #category : #testing }
BoolValue >> isLeaf [ 
	^true
]

{ #category : #evaluating }
BoolValue >> value [ 
	^self subclassResponsibility 
]
