Class {
	#name : #ASTKind,
	#superclass : #Z3AST,
	#category : #'MachineArithmetic-Core'
}

{ #category : #dispatch }
ASTKind class >> of: anAST [
	^Z3ASTKind astClassForAst: anAST

]

{ #category : #typing }
ASTKind >> asAST [
	^Z3AST wrap: self handle in: self ctx

]

{ #category : #typing }
ASTKind >> asKind [
	^self
]

{ #category : #'term rewriting' }
ASTKind >> inEnvironment: aDictionary [
	self shouldBeImplemented 
]

{ #category : #testing }
ASTKind >> isConstant [
	^false
]

{ #category : #arity }
ASTKind >> isLeaf [
	self subclassResponsibility 
]

{ #category : #printing }
ASTKind >> printOn: aStream [
	aStream nextPutAll: 'kind of '.
	self asAST printOn: aStream
]

{ #category : #arity }
ASTKind >> variables [
	^Set new "only function applications have 'variables' in this sense of the word"
]
