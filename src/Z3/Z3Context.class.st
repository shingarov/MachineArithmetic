Class {
	#name : #Z3Context,
	#superclass : #Z3Object,
	#instVars : [
		'asts'
	],
	#classVars : [
		'Global'
	],
	#pools : [
		'Z3ErrorCode'
	],
	#category : #'Z3-Core'
}

{ #category : #private }
Z3Context class >> createGlobalContext [
	"OBSOLETE, DO NOT USE. Kept temporarily for compatibility with tests. Will be removed."

	Global := nil
]

{ #category : #accessing }
Z3Context class >> current [
	"Answer the current Z3 context to use. By default, this
	 is the 'global' context, but users may specify their own
	 for particular computation using `Z3ContextQuery`:

		 customContext := Z3Context from: ...
		 Z3ContextQuery answer: customContext do: [
			...some computation with custom context...
		 ].
	"

	^ Z3ContextQuery query
]

{ #category : #'instance creation' }
Z3Context class >> from: aZ3Config [
	"Create and return new Z3Context"

	"And now something horrible. We need to update (some or)
	 Z3FuncDeclKind values, depending on a version. Rather than
	 doing it at class initialization time, we do it lazily,
	 just before first context is created and/or when image
	 is restarted. This makes it easier to debug when something
	 goes wrong. Sigh."

	(Global isNil or:[ Global isNull ]) ifTrue:[
		Z3FuncDeclKind update.
	].
	^Z3 mk_context: aZ3Config
]

{ #category : #'instance creation' }
Z3Context class >> fromDefault [
	^self from: Z3Config default
]

{ #category : #private }
Z3Context class >> global [
	"Return the global context. Do not use this directly,
	 always ask for context using `Z3Context current`"

	(Global isNil "Global context has not yet been created"
		or: [ Global isNull ]) "Or it is invalid (null) such as after an image restart"
			ifTrue:[ Global := self fromDefault ].
	^Global
]

{ #category : #'instance creation' }
Z3Context class >> new [
	^ self shouldNotImplement. "Use #from: or #fromDefault"
]

{ #category : #'system info' }
Z3Context class >> z3fullVersion [
	^LibZ3 getFullVersion 
]

{ #category : #'initialization & release' }
Z3Context >> delete [
	Z3 del_context: self.
]

{ #category : #'error handling' }
Z3Context >> errorCheck [
	| error |

	error := Z3 get_error_code: self.
	error ~~ OK ifTrue: [ 
		| message |

		message := Z3 get_error_msg: self _: error.
		Z3Error signal: 'Z3 error ' , error printString , ': ' , message
	].

]

{ #category : #'initialization & release' }
Z3Context >> initializeWithAddress: anExternalAddress [
	super initializeWithAddress: anExternalAddress.
	asts := WeakValueDictionary new.

	"Here we disable the use of error handler just to avoid calling
	 exit() - the default Z3 behavior. Errors are checked AFTER
	 making a call to Z3.

	 This is to abstract away different callback implementations
	 and to avoid 'unwinding across the black hole'. Also, this
	 is how Python bindings do it.
	"
	Z3 set_error_handler: self _: ExternalAddress new.

]

{ #category : #'private - AST management' }
Z3Context >> internAST: class address: address [
	| ast |

	ast := asts at: address asInteger 
				ifAbsentPut: [ class basicNew initializeWithAddress: address context: self ].

	self assert: ast class == class.
	self assert: ast ctx == self.

	^ ast

]

{ #category : #'private - AST management' }
Z3Context >> internAST: class address: address kind: kind sort: sort [
	| ast |

	ast := asts at: address asInteger 
				ifAbsentPut: [ class basicNew initializeWithAddress: address context: self kind: kind sort: sort ].

	self assert: ast class == class.
	self assert: ast ctx == self.
	self assert: ast kind == kind.
	self assert: ast sort == sort.

	^ ast

]

{ #category : #'as yet unclassified' }
Z3Context >> mkBoolSort [
	^Z3 mk_bool_sort: self
]

{ #category : #'as yet unclassified' }
Z3Context >> mkBoolVar: name [
	| ty |
	ty := self mkBoolSort.
	^self mkVar: name ofSort: ty
]

{ #category : #'as yet unclassified' }
Z3Context >> mkBvSort: length [
	^ Z3 mk_bv_sort: self _: length
]

{ #category : #'as yet unclassified' }
Z3Context >> mkDistinct: astArray [
	^ Z3 mk_distinct: self _: astArray size _: astArray

]

{ #category : #'as yet unclassified' }
Z3Context >> mkEnumerationSort: name elements: elements consts: consts testers: testers [
	"Create an enumeration sort.
	An enumeration sort with n elements.
	This function will also declare the functions corresponding to the enumerations.
	Arguments:
		name  - name of the enumeration sort.
		elements - names of the enumerated elements.
		consts - constants corresponding to the enumerated elements.
		testers - predicates testing if terms of the enumeration sort correspond to an enumeration.
	
	For example, if this function is called with three symbols A, B, C and the name S,
	then s is a sort whose name is S, and the function returns three terms corresponding
	to A, B, C in consts.  The array testers has three predicates of type (s -> Bool).
	The first predicate (corresponding to A) is true when applied to A, and false otherwise.
	Similarly for the other predicates."
	^Z3 mk_enumeration_sort: self
		_: name toZ3Symbol
		_: elements size
		_: (elements collect: #toZ3Symbol)
		_: consts
		_: testers
]

{ #category : #'as yet unclassified' }
Z3Context >> mkFalse [
	"Create an AST node representing false."
	^Z3 mk_false: self

]

{ #category : #'as yet unclassified' }
Z3Context >> mkForAll: terms [
	^Z3 mk_pattern: self _: terms size _: terms
]

{ #category : #'as yet unclassified' }
Z3Context >> mkForAll: patterns weight: w numQuantifiedVars: nVars types: types names: names prop: p [
	^Z3 mk_forall: self
		_: w
		_: patterns size
		_: patterns
		_: nVars
		_: types
		_: names
		_: p
]

{ #category : #'as yet unclassified' }
Z3Context >> mkInt: anInteger [
	"Create a Z3 integer node using a C int."
	| ty |
	ty := self mkIntSort.
	^ty mkInt: anInteger
]

{ #category : #'as yet unclassified' }
Z3Context >> mkIntSort [
	^Z3 mk_int_sort: self
]

{ #category : #'as yet unclassified' }
Z3Context >> mkIntVar: name [
	| ty |
	ty := self mkIntSort.
	^self mkVar: name ofSort: ty
]

{ #category : #'as yet unclassified' }
Z3Context >> mkPattern: terms [
	^Z3 mk_pattern: self _: terms size _: terms
]

{ #category : #'as yet unclassified' }
Z3Context >> mkRealSort [
	^Z3 mk_real_sort: self
]

{ #category : #'as yet unclassified' }
Z3Context >> mkSolver [
	^ Z3 mk_solver: self
]

{ #category : #'as yet unclassified' }
Z3Context >> mkSolverForLogic: logic [
	^ Z3 mk_solver_for_logic: self _: (self mkSymbol: logic)
]

{ #category : #'as yet unclassified' }
Z3Context >> mkSymbol [
	"The empty symbol (a special symbol in Z3).
	 By analogy with other monoids such as String, Array etc,
	 we use the selector #new for 'the monoidal unit',
	 even though Z3Symbol is not a monoid."
	^ self mkSymbol: String new
]

{ #category : #'as yet unclassified' }
Z3Context >> mkSymbol: stringOrInteger [
	stringOrInteger isInteger ifTrue: [
		^ Z3 mk_int_symbol: self _: stringOrInteger
	].
	stringOrInteger isString ifTrue: [
		^ Z3 mk_string_symbol: self _: stringOrInteger
	].
	^ self error: 'Unsupported value type'
]

{ #category : #'as yet unclassified' }
Z3Context >> mkTrue [
	"Create an AST node representing true."
	^Z3 mk_true: self

]

{ #category : #'as yet unclassified' }
Z3Context >> mkVar: name ofSort: ty [
	| sym |
	sym := self mkSymbol: name.
	^Z3AST mkConst: sym ofSort: ty

]

{ #category : #'as yet unclassified' }
Z3Context >> parseSmtlib2String: aString [
	^ Z3 parse_smtlib2_string: self _: aString _: 0 _: #() _: #() _: 0 _: #() _: #()

]

{ #category : #'initialization & release' }
Z3Context >> release [
	"In case #release sent to current global context, we have to flush it first
	 before releasing it to make sure no subsequent code will use it."

	Global == self ifTrue:[Global := nil].
	super release.
]
