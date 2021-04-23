Class {
	#name : #Z3NumeralAST,
	#superclass : #ASTKind,
	#category : #'MachineArithmetic-Core'
}

{ #category : #printing }
Z3NumeralAST class >> printAST: anAST on: aStream [
	| numeralString |
	aStream nextPut: $<.
	anAST sort printOn: aStream.
	aStream nextPutAll: ': '.
	numeralString := LibZ3 uniqueInstance getNumeralString: anAST ctx ast: anAST.
	aStream nextPutAll: numeralString.
	aStream nextPut: $>.	
]

{ #category : #'term rewriting' }
Z3NumeralAST >> inEnvironment: aDictionary [
	^self
]

{ #category : #testing }
Z3NumeralAST >> isConstant [
	^true
]

{ #category : #'term rewriting' }
Z3NumeralAST >> isLeaf [
	^true
]
