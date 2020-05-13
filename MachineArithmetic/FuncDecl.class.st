"
The kind of AST used to represent fucntion symbols.
"
Class {
	#name : #FuncDecl,
	#superclass : #Z3ContextedObject,
	#category : #'MachineArithmetic-Core'
}

{ #category : #accessing }
FuncDecl >> app [
	^(LibZ3 uniqueInstance mkApp00: ctx funcDecl: self) ctx: self ctx
]

{ #category : #accessing }
FuncDecl >> app: argumentArray [
	self shouldBeImplemented 
]

{ #category : #applying }
FuncDecl >> binaryApp: arg1 and: arg2 [
	| args |
	args := FFIExternalArray externalNewType: 'void*' size: 2.
	args at: 1 put: arg1 getHandle getHandle.
	args at: 2 put: arg2 getHandle getHandle.
	^AST wrap: (LibZ3 uniqueInstance mkApp: ctx func: self arity: 2 args: args) in: ctx
]

{ #category : #accessing }
FuncDecl >> name [
	"My name is a Z3Symbol."
	^(LibZ3 uniqueInstance getDeclName: ctx funcDecl: self) ctx: self ctx
]

{ #category : #applying }
FuncDecl >> unaryApp: argAST [
	| args |
	args := FFIExternalArray externalNewType: 'void*' size: 1.
	args at: 1 put: argAST getHandle getHandle.
	^AST wrap: (LibZ3 uniqueInstance mkApp: ctx func: self arity: 1 args: args) in: ctx
]
