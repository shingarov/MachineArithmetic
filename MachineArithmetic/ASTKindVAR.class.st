Class {
	#name : #ASTKindVAR,
	#superclass : #ASTKind,
	#category : #'MachineArithmetic-Core'
}

{ #category : #printing }
ASTKindVAR class >> printAST: var on: aStream [ 
	aStream nextPutAll: var astToString 
]
