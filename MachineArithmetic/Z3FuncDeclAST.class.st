Class {
	#name : #Z3FuncDeclAST,
	#superclass : #ASTKind,
	#category : #'MachineArithmetic-Core'
}

{ #category : #printing }
Z3FuncDeclAST class >> printAST: fdecl on: aStream [
	aStream nextPutAll: fdecl astToString 
]
