"
An algebraic expression which may contain some variables.
"
Class {
	#name : #AST,
	#superclass : #External,
	#category : #'MachineArithmetic-Bits'
}

{ #category : #private }
AST class >> opOf: anExternalID [
	^P eval: anExternalID ref, '.op'
]

{ #category : #comparing }
AST >> = anotherAST [
	| ref |
	ref := '(', self ref, ') == (', anotherAST ref, ')'.
	^P compute: ref
]

{ #category : #access }
AST >> argNo: anInteger [ 
	| ref |
	ref := self ref, '.args[', (anInteger - 1) printString, ']'.
	^P compute: ref
]

{ #category : #access }
AST >> args [
	^(1 to: self nArgs) collect: [ :argN | self argNo: argN ]
	
]

{ #category : #substitution }
AST >> inEnvironment: aDictionary [
	| op args ref |
	op := self op.
	args := self args collect: [ :aChild | aChild inEnvironment: aDictionary ].
	ref := (args inject: '( ' into: [ :soFar :currentArg | soFar, currentArg ref, ', '  ]), ' )'.
	ref := 'claripy.ast.bv.', self class pythonClassName, '.', op, ref.
	ref := 'angr.state_plugins.solver.SimSolver().simplify(', ref, ')'.
	^P compute: ref
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
AST >> nArgs [
	| ref |
	self isLeaf ifTrue: [ ^0 ].
	ref := 'len(', self ref, '.args)'.
	^P eval: ref

]

{ #category : #access }
AST >> op [
	^self class opOf: self var
]

{ #category : #access }
AST >> variables [
	| ref |
	ref := 'list(', self ref, '.variables)'.
	^P eval: ref

]
