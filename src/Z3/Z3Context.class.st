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

{ #category : #'initialization & release' }
Z3Context >> delete [
	Z3 del_context: self.
]

{ #category : #'error handling' }
Z3Context >> errorCheck [
	| code |

	code := Z3 get_error_code: self.
	code ~~ OK ifTrue: [
		"Here we have to clear the error code. Some APIs don't do it
		 (like some dec_refs and possibly others). If we do not do it,
		 it could happen that, after encounting error (and reporting it)
		 we call another Z3 functions which does not clear it and
		 subsequent #errorCheck would report an error (see [1]).

		 An obvious solution not to call errorCheck for those API is
		 bit fragile - Z3 API is not explicit about which do and which
		 don't and this is known to change version to version. So instead,
		 we took the approach of clearing the error - this way each (detected)
		 error is reported only once.

		 Note, that at this point we have already extracted the error code
		 (in `code` local variable) so we can safely clear it in the context.

		 [1]: https://github.com/shingarov/MachineArithmetic/issues/348
		"
		Z3 set_error: self _: OK.

		"Report an error."
		Z3Error new
			code: code;
			messageText: (Z3 get_error_msg: self _: code);
			signal
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

{ #category : #'API wrappers' }
Z3Context >> mkBoolSort [
	^Z3 mk_bool_sort: self
]

{ #category : #'API wrappers' }
Z3Context >> mkBoolVar: name [
	| ty |
	ty := self mkBoolSort.
	^self mkVar: name ofSort: ty
]

{ #category : #'API wrappers' }
Z3Context >> mkBvSort: length [
	^ Z3 mk_bv_sort: self _: length
]

{ #category : #'API wrappers' }
Z3Context >> mkConstructor: constructorName recognizer: recognizerName fields: fields referencing: sortRefs [
	self assert: fields size == sortRefs size.
	^Z3
		mk_constructor: self
		_: constructorName toZ3Symbol
		_: recognizerName toZ3Symbol
		_: fields size
		_: ((fields collect: #key) collect: #toZ3Symbol)
		_: (fields collect: #value)
		_: sortRefs
]

{ #category : #'API wrappers' }
Z3Context >> mkConstructorList: constructors [ 
	^Z3 mk_constructor_list: self _: constructors size _: constructors
]

{ #category : #'API wrappers' }
Z3Context >> mkDatatype: name constructors: constructors [
	^Z3
		mk_datatype: self
		_: name toZ3Symbol
		_: constructors size
		_: constructors
]

{ #category : #'API wrappers' }
Z3Context >> mkDistinct: astArray [
	^ Z3 mk_distinct: self _: astArray size _: astArray

]

{ #category : #'API wrappers' }
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
	| enumSort |
	consts  set: (Array new: elements size).
	testers set: (Array new: elements size).
	enumSort := Z3 mk_enumeration_sort: self
		_: name toZ3Symbol
		_: elements size
		_: (elements collect: #toZ3Symbol)
		_: consts get
		_: testers get.
	^enumSort
]

{ #category : #'API wrappers' }
Z3Context >> mkFalse [
	"Create an AST node representing false."
	^Z3 mk_false: self

]

{ #category : #'API wrappers' }
Z3Context >> mkForAll: terms [
	^Z3 mk_pattern: self _: terms size _: terms
]

{ #category : #'API wrappers' }
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

{ #category : #'API wrappers' }
Z3Context >> mkInt: anInteger [
	"Create a Z3 integer node using a C int."
	| ty |
	ty := self mkIntSort.
	^ty mkInt: anInteger
]

{ #category : #'API wrappers' }
Z3Context >> mkIntSort [
	^Z3 mk_int_sort: self
]

{ #category : #'API wrappers' }
Z3Context >> mkIntVar: name [
	| ty |
	ty := self mkIntSort.
	^self mkVar: name ofSort: ty
]

{ #category : #'API wrappers' }
Z3Context >> mkListSort: listName elementSort: elementSort nilDecl: nilDecl isNilDecl: isNilDecl consDecl: consDecl isConsDecl: isConsDecl headDecl: headDecl tailDecl: tailDecl [
	| listSort nilDeclArray isNilDeclArray consDeclArray isConsDeclArray headDeclArray tailDeclArray |
	nilDeclArray := Array new: 1.
	isNilDeclArray := Array new: 1.
 consDeclArray := Array new: 1.
 isConsDeclArray := Array new: 1.
 headDeclArray := Array new: 1.
 tailDeclArray := Array new: 1.
	listSort := Z3
		mk_list_sort: self
		_: listName toZ3Symbol
		_: elementSort
		_: nilDeclArray
		_: isNilDeclArray
		_: consDeclArray
		_: isConsDeclArray
		_: headDeclArray
		_: tailDeclArray.
	nilDecl set: nilDeclArray anyOne.
	isNilDecl set: isNilDeclArray anyOne.
	consDecl set: consDeclArray anyOne.
	isConsDecl set: isConsDeclArray anyOne.
	headDecl set: headDeclArray anyOne.
	tailDecl set: tailDeclArray anyOne.
	^listSort
]

{ #category : #'API wrappers' }
Z3Context >> mkPattern: terms [
	^Z3 mk_pattern: self _: terms size _: terms
]

{ #category : #'API wrappers' }
Z3Context >> mkRealSort [
	^Z3 mk_real_sort: self
]

{ #category : #'API wrappers' }
Z3Context >> mkSolver [
	^ Z3 mk_solver: self
]

{ #category : #'API wrappers' }
Z3Context >> mkSolverForLogic: logic [
	^ Z3 mk_solver_for_logic: self _: (self mkSymbol: logic)
]

{ #category : #'API wrappers' }
Z3Context >> mkSymbol [
	"The empty symbol (a special symbol in Z3).
	 By analogy with other monoids such as String, Array etc,
	 we use the selector #new for 'the monoidal unit',
	 even though Z3Symbol is not a monoid."
	^ self mkSymbol: String new
]

{ #category : #'API wrappers' }
Z3Context >> mkSymbol: stringOrInteger [
	stringOrInteger isInteger ifTrue: [
		^ Z3 mk_int_symbol: self _: stringOrInteger
	].
	stringOrInteger isString ifTrue: [
		^ Z3 mk_string_symbol: self _: stringOrInteger
	].
	^ self error: 'Unsupported value type'
]

{ #category : #'API wrappers' }
Z3Context >> mkTrue [
	"Create an AST node representing true."
	^Z3 mk_true: self

]

{ #category : #'API wrappers' }
Z3Context >> mkTupleSort: constructorName projections: projAssocs mkTupleDecl: tupleDeclCell projDecls: projDeclCell [
	| projNames projSorts mkTupleDeclArray tupleSort |
	projNames := projAssocs collect: #key.
	projSorts := projAssocs collect: #value.
	mkTupleDeclArray := Array new: 1.
	projDeclCell set: (Array new: projAssocs size).
	tupleSort := Z3
		mk_tuple_sort: self
		_: constructorName toZ3Symbol
		_: projAssocs size
		_: (projNames collect: #toZ3Symbol)
		_: projSorts
		_: mkTupleDeclArray
		_: projDeclCell get.
	tupleDeclCell set: mkTupleDeclArray anyOne.
	^tupleSort
]

{ #category : #'API wrappers' }
Z3Context >> mkVar: name ofSort: ty [
	| sym |
	sym := self mkSymbol: name.
	^Z3AST mkConst: sym ofSort: ty

]

{ #category : #'API wrappers' }
Z3Context >> parseSmtlib2String: aString [
	^ Z3 parse_smtlib2_string: self _: aString _: 0 _: #() _: #() _: 0 _: #() _: #()

]

{ #category : #'API wrappers' }
Z3Context >> queryConstructor: aZ3Constructor [
	| constructorDeclArray testerDeclArray accessorsArray |
	constructorDeclArray := Array new: 1.
	testerDeclArray := Array new: 1.
	accessorsArray := Array new: aZ3Constructor numFields.
	Z3
		query_constructor: self
		_: aZ3Constructor
		_: aZ3Constructor numFields
		_: constructorDeclArray
		_: testerDeclArray
		_: accessorsArray.
	^{ constructorDeclArray anyOne. testerDeclArray anyOne. accessorsArray }
]

{ #category : #'initialization & release' }
Z3Context >> release [
	"In case #release sent to current global context, we have to flush it first
	 before releasing it to make sure no subsequent code will use it."

	Global == self ifTrue:[Global := nil].
	super release.
]
