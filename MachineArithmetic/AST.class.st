"
An algebraic expression which may contain some variables.
"
Class {
	#name : #AST,
	#superclass : #Object,
	#instVars : [
		'var'
	],
	#category : #'MachineArithmetic-Bits'
}

{ #category : #private }
AST class >> opOf: anExternalID [
	^P eval: anExternalID ref, '.op'
]

{ #category : #private }
AST class >> pythonClassName [ 
	self subclassResponsibility 
]

{ #category : #private }
AST class >> var: v [
	^self new 
		var: v;
		yourself
]

{ #category : #comparing }
AST >> = anotherAST [
	| ref |
	ref := self ref, ' == ', anotherAST ref.
	^P fetchVar: (P evalAndAssign: ref)
]

{ #category : #testing }
AST >> isLeaf [ 
	^false
]

{ #category : #testing }
AST >> isSymbolic [
	"Answer whether the receiver's tree contains any Cardano-Tartaglia cosas."
	| ref |
	ref := self ref, '.symbolic'.
	^P eval: ref

]

{ #category : #access }
AST >> op [
	^self class opOf: self var
]

{ #category : #printing }
AST >> printOn: aStream [
	aStream nextPutAll: self var pythonStr
]

{ #category : #private }
AST >> ref [ 
	^self var ref
]

{ #category : #private }
AST >> var [
	^ var
]

{ #category : #private }
AST >> var: anExternalID [
	var := anExternalID
]

{ #category : #access }
AST >> variables [
	| ref |
	ref := 'list(', self ref, '.variables)'.
	^P eval: ref

]
