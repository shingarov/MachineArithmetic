Class {
	#name : #ASTKindFUNCDECL,
	#superclass : #ASTKind,
	#category : #'MachineArithmetic-Core'
}

{ #category : #printing }
ASTKindFUNCDECL class >> printAST: fdecl on: aStream [
	aStream nextPutAll: fdecl astToString 
]
