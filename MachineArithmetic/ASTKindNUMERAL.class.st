Class {
	#name : #ASTKindNUMERAL,
	#superclass : #ASTKind,
	#category : #'MachineArithmetic-Core'
}

{ #category : #printing }
ASTKindNUMERAL class >> printAST: anAST on: aStream [
	| numeralString |
	aStream nextPut: $<.
	anAST sort printOn: aStream.
	aStream nextPutAll: ': '.
	numeralString := LibZ3 uniqueInstance getNumeralString: anAST ctx ast: anAST.
	aStream nextPutAll: numeralString.
	aStream nextPut: $>.	
]

{ #category : #'term rewriting' }
ASTKindNUMERAL >> inEnvironment: aDictionary [
	^self
]

{ #category : #testing }
ASTKindNUMERAL >> isConstant [
	^true
]

{ #category : #'term rewriting' }
ASTKindNUMERAL >> isLeaf [
	^true
]
