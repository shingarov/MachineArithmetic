"
The kind of AST used to represent fucntion symbols.
"
Class {
	#name : #Z3FuncDecl,
	#superclass : #Z3AST,
	#pools : [
		'Z3ASTKind'
	],
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3FuncDecl class >> fromExternalAddress: anExternalAddress inContext: aZ3Context [
	| kind |

	kind := Z3 get_ast_kind: aZ3Context _: anExternalAddress.
	self assert: kind == FUNC_DECL_AST description: 'Attempting to instantiate func decl for something that is not a func decl'.
	^ aZ3Context internAST: Z3FuncDecl address: anExternalAddress
]

{ #category : #accessing }
Z3FuncDecl >> arity [
	^Z3 get_arity: ctx _: self

]

{ #category : #accessing }
Z3FuncDecl >> declKind [
	^ Z3 get_decl_kind: ctx _: self

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

{ #category : #GT }
Z3FuncDecl >> gtInspectorDomainIn: composite [
	<gtInspectorPresentationOrder: 71>
	^ composite fastList
		title: 'Domain';
		display: [ self domain ]
]

{ #category : #accessing }
Z3FuncDecl >> kind [
	^ FUNC_DECL_AST

]

{ #category : #accessing }
Z3FuncDecl >> name [
	"Return the name of the function (functor name) as a Smalltalk String"
	^ (Z3 get_decl_name: ctx _: self) asString

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
Z3FuncDecl >> value [
	^ self valueWithArguments: {}

]

{ #category : #applying }
Z3FuncDecl >> value: arg [
	^ self valueWithArguments: { arg }

]

{ #category : #'function definition' }
Z3FuncDecl >> value: x is: fx [
	^self valueWithArguments: {x} is: fx
]

{ #category : #applying }
Z3FuncDecl >> value: arg1 value: arg2 [
	^ self valueWithArguments: { arg1. arg2 }

]

{ #category : #'function definition' }
Z3FuncDecl >> value: x value: y is: fxy [
	^self valueWithArguments: {x.y.} is: fxy
]

{ #category : #applying }
Z3FuncDecl >> value: arg1 value: arg2 value: arg3 [
	^ self valueWithArguments: { arg1. arg2. arg3 }

]

{ #category : #'function definition' }
Z3FuncDecl >> value: x value: y value: z is: fxyz [
	^self valueWithArguments: {x.y.z.} is: fxyz
]

{ #category : #applying }
Z3FuncDecl >> value: arg1 value: arg2 value: arg3 value: arg4 [
	^ self valueWithArguments: { arg1. arg2. arg3. arg4 }

]

{ #category : #'function definition' }
Z3FuncDecl >> valueIs: f_ [
	^self valueWithArguments: #() is: f_
]

{ #category : #applying }
Z3FuncDecl >> valueWithArguments: anArray [
	| zip coercedArgs |
	zip := anArray zip: self domain.
	coercedArgs := zip collectAssociations: [ :eachArg :itsSort | eachArg toZ3Sort: itsSort ].
	^ Z3 mk_app: ctx _: self _: anArray size _: coercedArgs

]

{ #category : #'function definition' }
Z3FuncDecl >> valueWithArguments: args is: fargs [
	Z3 add_rec_def: self ctx _: self _: args size _: args _: fargs

]

{ #category : #copying }
Z3FuncDecl >> withName: aString [
	^aString functionFrom: self domain to: self range
]
