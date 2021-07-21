Class {
	#name : #Z3Solver,
	#superclass : #Z3ReferenceCountedObject,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3Solver class >> for: logic [ 
	^self on: Z3Context current for: logic
]

{ #category : #'instance creation' }
Z3Solver class >> new [
	^self on: Z3Context current
]

{ #category : #'instance creation' }
Z3Solver class >> on: aZ3Context [
	^Z3 mk_solver: aZ3Context

]

{ #category : #'instance creation' }
Z3Solver class >> on: aZ3Context for: logic [
	| logicSymbol |
	logicSymbol := Z3Symbol from: logic .
	^Z3 mk_solver_for_logic: aZ3Context _: logicSymbol

]

{ #category : #asserting }
Z3Solver >> assert: aBool [
	Z3 solver_assert: ctx _: self _: aBool

]

{ #category : #asserting }
Z3Solver >> assertFunction: f isInjectiveInArg: i [
	"Assert the axiom: function f is injective in the i-th argument.

   The following axiom is asserted into the logical context:
	   forall (x_0, ..., x_n) finv(f(x_0, ..., x_i, ..., x_{n-1})) = x_i
   Where, finv is a fresh function declaration."
]

{ #category : #access }
Z3Solver >> assertions [
	^Z3 solver_get_assertions: ctx _: self
]

{ #category : #asserting }
Z3Solver >> check [
	| resultCode |
	resultCode := Z3  solver_check: ctx _: self.
	^Lbool decode: resultCode 

]

{ #category : #'ref-counting' }
Z3Solver >> decRef [
	Z3 solver_dec_ref: ctx _: self.  

]

{ #category : #asserting }
Z3Solver >> del [
	self release.

]

{ #category : #printing }
Z3Solver >> dimacs [
	"Answer a textual representation of the receiver in DIMACS format."
	^Z3 solver_to_dimacs_string: ctx _: self _: true
]

{ #category : #asserting }
Z3Solver >> findCounterexample: f [
	"This is taken from test_capi.c:
	Prove that the constraints already asserted into the logical
   context implies the given formula.

   Z3 is a satisfiability checker. So, one can prove f by showing
   that (not f) is unsatisfiable.

   The receiver context is not modified by this function.

	Answer nil if vailidity has been proven, i.e. check() returned #FALSE (i.e. UNSAT),
	or the counterexample if check() found one and returned #TRUE."

	| result |
	self assert: f not.
	result := self check.
	result isNil ifTrue: [ UnknownValidity signalWithModel: self getModel ].
	result ifTrue: [ ^self getModel ] ifFalse: [ ^nil ]
]

{ #category : #access }
Z3Solver >> getHelp [
	"Answer a string describing all solver available parameters."
	^Z3 solver_get_help: ctx _: self
]

{ #category : #asserting }
Z3Solver >> getModel [
	^Z3 solver_get_model: ctx _: self

]

{ #category : #access }
Z3Solver >> getParamDescrs [
	"Answer the parameter description set for the receiver."
	^Z3 solver_get_param_descrs: ctx _: self
]

{ #category : #GT }
Z3Solver >> gtInspectorAssertionsIn: composite [
	<gtInspectorPresentationOrder: 0>
	^ composite fastTable
		title: 'Assertions';
		display: [ self assertions contents ];
		wantsAutomaticRefresh: true;
		column: 'Item' evaluated: [ :value | GTObjectPrinter asTruncatedTextFrom: value ] width: 500
]

{ #category : #GT }
Z3Solver >> gtInspectorDimacsIn: composite [
	<gtInspectorPresentationOrder: 10>
	composite text
		title: 'DIMACS';
		display: [ self dimacs truncateWithElipsisTo: 100000 ]
]

{ #category : #GT }
Z3Solver >> gtInspectorHelpIn: composite [
	<gtInspectorPresentationOrder: 200>
	^ composite fastTable
		title: 'Help';
		display: [ self getHelp lines ];
		beMultiple;
		enableElementIndex;
		wantsAutomaticRefresh: true;
		column: 'Index' evaluated: [ :value :idex | idex asString ] width: 50;
		column: 'Item' evaluated: [ :value | GTObjectPrinter asTruncatedTextFrom: value ];
		send: [ :result | 
			"withSmalltalkSearch;
		showOnly: 50;
		helpMessage: 'Quick selection field. Given your INPUT, it executes: self select: [:each | INPUT ]'."
			result
				ifNil: [ nil ]
				ifNotNil: [ result size = 1
						ifTrue: [ result anyOne ]
						ifFalse: [ self species withAll: result ]
					]
			]
]

{ #category : #'ref-counting' }
Z3Solver >> incRef [
	Z3 solver_inc_ref: ctx _: self.  

]

{ #category : #'state stack' }
Z3Solver >> numScopes [
	"Return the number of backtracking points."
	^Z3 solver_get_num_scopes: ctx _: self

]

{ #category : #'state stack' }
Z3Solver >> pop [ 
	^self pop: 1
]

{ #category : #'state stack' }
Z3Solver >> pop: n [
	^Z3 solver_pop: ctx _: self _: n

]

{ #category : #asserting }
Z3Solver >> prove: f isValid: isValid [
	"This is an example taken from test_capi.c:
	Prove that the constraints already asserted into the logical
   context implies the given formula.
	The result of the proof is displayed on Transcript.

   Z3 is a satisfiability checker. So, one can prove \c f by showing
   that <tt>(not f)</tt> is unsatisfiable.

   The context \c ctx is not modified by this function."

	| result |
	"save the current state of the context"
	self push.
	self assert: f not.
	result := self check.

	result == #UNDEF ifTrue: [
		| model |
		model := self getModel.
		self pop.
		UnknownValidity signalWithModel: model ].
	
	result == #FALSE ifTrue: [
		"proved"
		Transcript show: 'valid'; cr.
		isValid ifFalse: [ self error ] ].

	result == #TRUE  ifTrue: [ | m |
		Transcript show: 'invalid'; cr.  self halt.
		m := self getModel.
		m constants.
		isValid ifTrue: [ self error ] ].
	self pop.
]

{ #category : #asserting }
Z3Solver >> proveNotValid: f [
	"Disrove that the constraints already asserted into the logical
   context implies the given formula, by finding a counterexample."

	| counterexample |
	counterexample := self findCounterexample: f.
	counterexample isNil ifTrue: [ ^NotInvalid signal ].
	^counterexample 
]

{ #category : #asserting }
Z3Solver >> proveValid: f [
	"Prove that the constraints already asserted into the logical
   context implies the given formula f, by showing that (not f) is unsatisfiable.

   The receiver context is not modified by this function.

	Raise an NotValid exception if f is not valid, i.e. if a counterexample was found;
	the counterexample is wrapped in the exception."

	| counterexample |
	counterexample := self findCounterexample: f.
	counterexample isNil ifFalse: [ NotValid signalWithCounterexample: counterexample ]
]

{ #category : #'state stack' }
Z3Solver >> push [
	^Z3 solver_push: ctx _: self

]

{ #category : #asserting }
Z3Solver >> solve: aZ3ASTVector [
	(aZ3ASTVector isKindOf: Z3ASTVector) ifFalse: [ self shouldBeImplemented ].
	aZ3ASTVector contents do: [ :th | self assert: th ].
	self check ifFalse: [^nil].
	^self getModel 
]
