"
The μZ API is a Z3 extension for solving fixed-point constraints.
See:
https://www.microsoft.com/en-us/research/wp-content/uploads/2016/02/nbjorner-z3fix.pdf
and:
https://citeseerx.ist.psu.edu/viewdoc/download?doi=10.1.1.648.9876&rep=rep1&type=pdf
"
Class {
	#name : #Z3Fixedpoint,
	#superclass : #Z3ContextedObject,
	#instVars : [
		'vars'
	],
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3Fixedpoint class >> new [
	^Z3 mk_fixedpoint: Z3Context current
]

{ #category : #private }
Z3Fixedpoint >> abstract: fml [ 
	^self abstract: fml forAll: true
]

{ #category : #private }
Z3Fixedpoint >> abstract: fml forAll: aBoolean [
	vars isEmpty ifTrue: [ ^fml ].
	^aBoolean
		ifTrue: [ Z3QuantifierNode forAll: vars body: fml ]
		ifFalse: [ Z3QuantifierNode exists: vars body: fml ]
]

{ #category : #'ref-counting' }
Z3Fixedpoint >> decRef [
	Z3 fixedpoint_dec_ref: ctx _: self
]

{ #category : #'as yet unclassified' }
Z3Fixedpoint >> declareVar: x [ 
	vars addLast: x
]

{ #category : #API }
Z3Fixedpoint >> del [
	self decRef
]

{ #category : #API }
Z3Fixedpoint >> fact: head [ 
	self fact: head named: nil
]

{ #category : #API }
Z3Fixedpoint >> fact: head named: name [
	self rule: name head: head body: nil
]

{ #category : #API }
Z3Fixedpoint >> getAnswer [
	"Retrieve answer from last query call."
	^Z3 fixedpoint_get_answer: ctx _: self
]

{ #category : #GT }
Z3Fixedpoint >> gtInspectorAvailableOptionsIn: composite [
	<gtInspectorPresentationOrder: 1000>
	composite text
		title: 'Help';
		display: [ self help ]
]

{ #category : #API }
Z3Fixedpoint >> help [
	"Answer a string describing all available options."
	^Z3 fixedpoint_get_help: ctx _: self
]

{ #category : #'ref-counting' }
Z3Fixedpoint >> incRef [
	Z3 fixedpoint_inc_ref: ctx _: self
]

{ #category : #initialization }
Z3Fixedpoint >> initializeWithAddress: anExternalAddress context: aZ3Context [
	super initializeWithAddress: anExternalAddress context: aZ3Context.
	Z3 fixedpoint_inc_ref: ctx _: self.
	vars := OrderedCollection new.
]

{ #category : #API }
Z3Fixedpoint >> query: qs [
	"Query the fixedpoint engine whether formula is derivable."
	^ (qs first isKindOf: Z3FuncDecl)
		ifTrue: [ self queryRelations: qs ]
		ifFalse: [ self queryFormula: qs ]
]

{ #category : #private }
Z3Fixedpoint >> queryFormula: qs [
	| q qArg r |
	q := Bool and: qs.
	qArg := self abstract: q forAll: false.
	r := Z3 fixedpoint_query: ctx _: self _: qArg.
	^Lbool decode: r
]

{ #category : #private }
Z3Fixedpoint >> queryRelations: qs [
	| r |
	r := Z3 fixedpoint_query_relations: ctx _: self _: qs size _: qs.
	^Lbool decode: r
]

{ #category : #API }
Z3Fixedpoint >> registerRelation: ast [
	Z3 fixedpoint_register_relation: ctx _: self _: ast

]

{ #category : #API }
Z3Fixedpoint >> rule: name head: head body: body [
	| nameArg |
	nameArg := (name ifNil: ['']) toZ3Symbol.
	body isNil ifTrue: [ 
		| headArg |
		headArg := self abstract: head.
		Z3 fixedpoint_add_rule: ctx _: self
			_: headArg
			_: nameArg 
 ] ifFalse: [
		| f |
		f := self abstract: body ==> head.
		Z3 fixedpoint_add_rule: ctx _: self
			_: f
			_: nameArg 
	]
]

{ #category : #API }
Z3Fixedpoint >> setParams: aZ3ParameterSet [
	Z3 fixedpoint_set_params: ctx _: self _: aZ3ParameterSet toZ3ParameterSet
]
