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
	^ Z3 mk_app: ctx _: self _: 0 _: #()

]

{ #category : #applying }
Z3FuncDecl >> app: args [
	^ Z3 mk_app: ctx _: self _: args size _: args

]

{ #category : #accessing }
Z3FuncDecl >> arity [
	^Z3 get_arity: ctx _: self

]

{ #category : #applying }
Z3FuncDecl >> binaryApp: arg1 and: arg2 [
	^ self app: { arg1. arg2 }

]

{ #category : #accessing }
Z3FuncDecl >> domain [
	^(1 to: self domainSize) collect: [ :j | self domainAt: j ]
]

{ #category : #accessing }
Z3FuncDecl >> domainAt: j [
	^Z3 get_domain: ctx _: self _: j-1
]

{ #category : #accessing }
Z3FuncDecl >> domainSize [
	^Z3 get_domain_size: ctx _: self
]

{ #category : #accessing }
Z3FuncDecl >> kind [
	^ FUNC_DECL_AST

]

{ #category : #accessing }
Z3FuncDecl >> name [
	"Return the name of the function (functor name) as Z3Symbol"
	^ Z3 get_decl_name: ctx _: self.

]

{ #category : #accessing }
Z3FuncDecl >> range [
	^Z3 get_range: ctx _: self
]

{ #category : #accessing }
Z3FuncDecl >> sort [
	^ Z3 get_sort: ctx _: self

]

{ #category : #applying }
Z3FuncDecl >> unaryApp: argAST [
	^ self app: { argAST }

]
