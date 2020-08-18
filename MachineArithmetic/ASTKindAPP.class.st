Class {
	#name : #ASTKindAPP,
	#superclass : #ASTKind,
	#category : #'MachineArithmetic-Core'
}

{ #category : #printing }
ASTKindAPP class >> printAST: anAppAST on: aStream [ 
	| app arity |
	app := anAppAST term.
	aStream nextPutAll: app functorName.
	arity := 	app arity.
	arity = 0 ifTrue: [ ^self ].
	aStream nextPut: $(.
	1 to: arity do: [ :index |
		index > 1 ifTrue: [ aStream nextPut: $, ].
		(app argAt: index) printOn: aStream ].
	aStream nextPut: $)
	
]

{ #category : #function }
ASTKindAPP >> argAt: index [
	"Answer the i-th argument.
	Indexing is 1-based (i.e. Smalltalk convention)."
	index > self arity ifTrue: [ self errorSubscriptBounds: index ].
	^AST wrap: (LibZ3 uniqueInstance getAppArg: ctx app: self index: index - 1) in: ctx
]

{ #category : #function }
ASTKindAPP >> args [
	self arity = 0 ifTrue: [ ^#() ].
	^(1 to: self arity) collect: [ :index |
		self argAt: index ]
]

{ #category : #function }
ASTKindAPP >> arity [
	"Return the number of argument of an application.
	A function of zero arguments is called a constant."
	^LibZ3 uniqueInstance getAppNumArgs: ctx app: self
]

{ #category : #function }
ASTKindAPP >> funcDecl [
	^(LibZ3 uniqueInstance getAppDecl: ctx app: self) ctx: ctx
]

{ #category : #function }
ASTKindAPP >> functorName [
	^self funcDecl name getString
]

{ #category : #'term rewriting' }
ASTKindAPP >> inEnvironment: aDictionary [
	^self shouldNotImplement 
]

{ #category : #'term rewriting' }
ASTKindAPP >> inEnvironmentLeaf: aDictionary [
	^aDictionary at: self functorName ifAbsent: [ self asAST ]
]

{ #category : #'term rewriting' }
ASTKindAPP >> inEnvironmentNonLeaf: aDictionary [
	self shouldBeImplemented.
]

{ #category : #testing }
ASTKindAPP >> isConstant [
	^self arity = 0
]

{ #category : #testing }
ASTKindAPP >> isLeaf [
	^self isConstant
]

{ #category : #function }
ASTKindAPP >> sym [
	| thing |
	thing := self.
	thing isLeaf ifFalse: [ thing := thing simplify term ]. "trying to be helpful"
	thing isLeaf ifFalse: [ self error ].
	^thing functorName 
]

{ #category : #function }
ASTKindAPP >> variables [
	^self isLeaf  
		ifTrue: [ Set with: self asAST ]
		ifFalse: [ | children |
			children := self args.
			children inject: Set new into: [ :soFar :currentChild | soFar addAll: (currentChild variables); yourself ]
		]
]
