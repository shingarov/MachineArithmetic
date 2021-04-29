"
The kind of AST used to represent fucntion symbols.
"
Class {
	#name : #Z3FuncDecl,
	#superclass : #Z3AST,
	#pools : [
		'Z3ASTKind'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #accessing }
Z3FuncDecl >> app [
	| args |
	
	args := self externalArrayFrom: #().
	^Z3AST wrap: (LibZ3 uniqueInstance mkApp: ctx func: self arity: 0 args: args) in: self ctx

]

{ #category : #applying }
Z3FuncDecl >> app: args [
	| externalArgs |
	externalArgs := self externalArrayFrom: args.
	^Z3AST
		wrap: (LibZ3 uniqueInstance mkApp: ctx func: self arity: args size args: externalArgs)
		in: ctx

]

{ #category : #accessing }
Z3FuncDecl >> arity [
	^LibZ3 uniqueInstance getArity: ctx funcDecl: self
]

{ #category : #applying }
Z3FuncDecl >> binaryApp: arg1 and: arg2 [
	| args |
	args := self externalArrayFrom: { arg1. arg2 }.
	^Z3AST wrap: (LibZ3 uniqueInstance mkApp: ctx func: self arity: 2 args: args) in: ctx

]

{ #category : #accessing }
Z3FuncDecl >> kind [
	^ FUNC_DECL_AST

]

{ #category : #accessing }
Z3FuncDecl >> name [
	"My name is a Z3Symbol."
	^(LibZ3 uniqueInstance getDeclName: ctx funcDecl: self) ctx: self ctx
]

{ #category : #accessing }
Z3FuncDecl >> sort [
	^ Z3 get_sort: ctx _: self

]

{ #category : #applying }
Z3FuncDecl >> unaryApp: argAST [
	| args |
	args := self externalArrayFrom: { argAST }.
	^Z3AST wrap: (LibZ3 uniqueInstance mkApp: ctx func: self arity: 1 args: args) in: ctx

]
