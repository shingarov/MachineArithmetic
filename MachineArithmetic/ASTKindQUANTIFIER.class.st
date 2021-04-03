Class {
	#name : #ASTKindQUANTIFIER,
	#superclass : #ASTKind,
	#category : #'MachineArithmetic-Core'
}

{ #category : #printing }
ASTKindQUANTIFIER class >> printAST: aQuantifierAST on: aStream [
	aStream nextPutAll: aQuantifierAST astToString 
]
