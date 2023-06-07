"
In Z3, expressions, sorts and declarations are called ASTs. ASTs are directed acyclic graphs. Every expression has a sort. Send #sort to get the sort of an expression.

When we get an AST handle from Z3, we look at the sort, and create an instance of the concrete subclass (BitVector, Bool etc) appropriate for the sort.

In addition to sorts, ASTs also have kinds: VAR, NUMERAL, APP etc.  This becomes tricky because in Smalltalk this would correspond to something like a two-dimensional class membership, which we don't have.  So to send messages understood by AST of particular kinds (e.g. arity is a concept specific to function applications), we can downcast an AST to its kind by sending #asKind, and back by sending #asAST.
"
Class {
	#name : #Z3AST,
	#superclass : #Z3ContextedObject,
	#pools : [
		'Z3ASTKind'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3AST class >> fromExternalAddress: anExternalAddress inContext: aZ3Context [
	| kind sort |

	self assert: self == Z3AST description: 'Attempting to instantiate AST subclass directly'.
	anExternalAddress isNull ifTrue: [ ^nil ].

	kind := Z3 get_ast_kind: aZ3Context _: anExternalAddress.
	kind == FUNC_DECL_AST ifTrue: [ 
		^ aZ3Context internAST: Z3FuncDecl address: anExternalAddress
	].

	kind == SORT_AST ifTrue: [ 
		^ Z3Sort fromExternalAddress: anExternalAddress inContext: aZ3Context
	].

	sort := Z3 get_sort: aZ3Context _: anExternalAddress.
	
	kind == QUANTIFIER_AST ifTrue: [ 
		^ aZ3Context internAST: Z3QuantifierNode address: anExternalAddress kind: kind sort: sort
	].

	^ aZ3Context internAST: sort nodeClass address: anExternalAddress kind: kind sort: sort

]

{ #category : #'particular sort creation' }
Z3AST class >> mkConst: aSymbol ofSort: aSort [
	^ Z3 mk_const: aSymbol ctx _: aSymbol _: aSort

]

{ #category : #'particular sort creation' }
Z3AST class >> numeral: aString ofSort: ty [
	^ Z3 mk_numeral: ty ctx _: aString _: ty

]

{ #category : #'particular sort creation' }
Z3AST class >> var: varName ofSort: ty [
	| sym |
	sym := Z3Symbol from: varName on: ty ctx.
	^self mkConst: sym ofSort: ty
]

{ #category : #'instance creation' }
Z3AST class >> wrap: aPointer in: aZ3Context [
	<resource: #obsolete>
	self error: 'Should no longer be used'

]

{ #category : #comparing }
Z3AST >> = another [
	self == another ifTrue: [ ^ true ].
	self class ~~ another class ifTrue: [ ^ false ].
	ctx ~~ another ctx ifTrue: [ ^ false ].
	self kind == SORT_AST ifTrue: [ 
		^ Z3 is_eq_sort: ctx _: self _: another
	] ifFalse: [ 
		^ Z3 is_eq_ast: ctx _: self simplify _: another simplify
	].

]

{ #category : #printing }
Z3AST >> astToString [
	^ Z3 ast_to_string: ctx _: self.

]

{ #category : #utilities }
Z3AST >> ensureSet [
	"No-op is receiver is a set, error otherwise"
	self error: 'Receiver is not Z3 set'
]

{ #category : #utilities }
Z3AST >> ensureValidZ3AST [
	self ensureValidZ3Object
]

{ #category : #utilities }
Z3AST >> ensureValidZ3ASTOfKind: kind [
	self ensureValidZ3Object.
	self kind ~~ kind ifTrue:[ self error: 'Invalid Z3 AST (wrong kind)' ].
]

{ #category : #GT }
Z3AST >> gtInspectorKindIn: composite [
	<gtInspectorPresentationOrder: 70>
	Z3ASTKind bindingsDo: [ :eachClassVariable | eachClassVariable value = 1 ifTrue: [
			^ composite text
					title: 'Kind';
					display: [ eachClassVariable key ]
			] ].
	^self error "can't happen"
]

{ #category : #comparing }
Z3AST >> hash [
	^ Z3 get_ast_hash: ctx _: self

]

{ #category : #testing }
Z3AST >> isAST [
	^true
]

{ #category : #testing }
Z3AST >> isApp [
	^self kind == APP_AST

]

{ #category : #testing }
Z3AST >> isAsArray [
	^Z3 is_as_array: ctx _: self

]

{ #category : #testing }
Z3AST >> isExists [
	^ false

]

{ #category : #testing }
Z3AST >> isForAll [
	^ false

]

{ #category : #testing }
Z3AST >> isNumeral [
	^self kind == NUMERAL_AST

]

{ #category : #testing }
Z3AST >> isShortExpr [
	^false

]

{ #category : #testing }
Z3AST >> isSymbolic [
	"Answer whether [even the simplified form of] the receiver
	 contains algebraic symbols ('ς' in Diophantus, or 'cosa' in
	 Rinascimento authors.  The constants 'true' and 'false' are
	 not considered symbolic.
	
	 Due to diagonal arguments, the precise #isSymbolic is uncomputable.
	 In cases when we don't know, we answer true.
	
	 See PR#50 for discussion."

	^self simplify isNumeral not
]

{ #category : #accessing }
Z3AST >> kind [
	^ self subclassResponsibility

]

{ #category : #printing }
Z3AST >> printOn: aStream [
	^ aStream nextPutAll: self printString

]

{ #category : #printing }
Z3AST >> printString [
	^ self astToString

]

{ #category : #'refinement typing' }
Z3AST >> singletonExpr: v [ 
	^nil
]
