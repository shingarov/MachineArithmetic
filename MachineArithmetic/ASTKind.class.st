Class {
	#name : #ASTKind,
	#superclass : #AST,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'known names' }
ASTKind class >> APP [
	^ 1
]

{ #category : #'known names' }
ASTKind class >> FUNC_DECL [
	^ 5
]

{ #category : #'known names' }
ASTKind class >> NUMERAL [
	^ 0
]

{ #category : #'known names' }
ASTKind class >> QUANTIFIER [
	^ 3
]

{ #category : #'known names' }
ASTKind class >> SORT [
	^ 4
]

{ #category : #'known names' }
ASTKind class >> UNKNOWN [
	^ 1000
]

{ #category : #'known names' }
ASTKind class >> VAR [
	^ 2
]

{ #category : #dispatch }
ASTKind class >> forCode: code [
	^self knownKinds at: code
]

{ #category : #'known names' }
ASTKind class >> knownKinds [
	^Dictionary new
		at: self APP        put: ASTKindAPP;
		at: self FUNC_DECL  put: ASTKindFUNCDECL;
		at: self NUMERAL    put: ASTKindNUMERAL;
		at: self QUANTIFIER put: ASTKindQUANTIFIER;
		at: self SORT       put: ASTKindSORT;
		at: self UNKNOWN    put: ASTKindUNKNOWN;
		at: self VAR        put: ASTKindVAR;
		yourself
]

{ #category : #dispatch }
ASTKind class >> of: anAST [
	^self forCode: anAST getKindCode
]

{ #category : #typing }
ASTKind >> asAST [
	^AST wrap: self handle in: self ctx
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
