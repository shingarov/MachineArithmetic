Class {
	#name : #Z3VarAST,
	#superclass : #ASTKind,
	#category : #'MachineArithmetic-Core'
}

{ #category : #printing }
Z3VarAST class >> printAST: var on: aStream [ 
	aStream nextPutAll: var astToString 
]
