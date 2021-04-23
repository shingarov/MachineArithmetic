Class {
	#name : #Z3QuantifierAST,
	#superclass : #ASTKind,
	#category : #'MachineArithmetic-Core'
}

{ #category : #printing }
Z3QuantifierAST class >> printAST: aQuantifierAST on: aStream [
	aStream nextPutAll: aQuantifierAST astToString 
]
