Class {
	#name : #Z3Model,
	#superclass : #Z3ReferenceCountedObject,
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3Model class >> new [
	"Construct empty model.
	See Z3CAPITest>>testMkModel for an example."
	self shouldBeImplemented 
]

{ #category : #'instance creation' }
Z3Model class >> on: ctx [
	"Construct empty model."
	| m |
	m := (LibZ3 uniqueInstance mkModel: ctx) ctx: ctx.
	m incRef.
	^m
]

{ #category : #'as yet unclassified' }
Z3Model >> at: idx [
	^idx elementOfModel: self
]

{ #category : #'as yet unclassified' }
Z3Model >> blockerContradictions [
	| constants contradictions |
	constants := self decls select: [ :decl | decl arity = 0 ].
	contradictions := constants collect: [ :f | f value ~== (self getConstInterp: f) ].
	^Bool or: contradictions
]

{ #category : #'as yet unclassified' }
Z3Model >> constDecl: j [
	^ Z3 model_get_const_decl: ctx _: self _: j

]

{ #category : #'as yet unclassified' }
Z3Model >> constants [
	| n resultDictionary |
	n := self numConstants.
	resultDictionary := Dictionary new.
	(0 to: n - 1) do: [ :j |
		| cnst name a v |
		cnst := self constDecl: j.
		name := cnst name.
		a := cnst value.
		v := self eval: a completion: true.
		resultDictionary at: name put: v
	 ].
	^resultDictionary
]

{ #category : #'as yet unclassified' }
Z3Model >> constantsASTs [
	| n resultDictionary |
	n := self numConstants.
	resultDictionary := Dictionary new.
	(0 to: n - 1) do: [ :j |
		| cnst name a v |
		cnst := self constDecl: j.
		name := cnst name.
		a := cnst value.
		v := self eval: a completion: true.
		resultDictionary at: name put: v
	 ].
	^resultDictionary 
]

{ #category : #'ref-counting' }
Z3Model >> decRef [
	Z3 model_dec_ref: ctx _: self.  

]

{ #category : #'as yet unclassified' }
Z3Model >> decls [
	^(1 to: self numConstants) collect: [ :j |
		self constDecl: j-1
	]
]

{ #category : #'as yet unclassified' }
Z3Model >> del [
	self release

]

{ #category : #'as yet unclassified' }
Z3Model >> displayFunctionInterpretations [
	self shouldBeImplemented 
]

{ #category : #'as yet unclassified' }
Z3Model >> eval: anAST completion: aBoolean [
	| outAST |
	outAST := Array new: 1.
	(Z3 model_eval: ctx _: self _: anAST _: aBoolean _: outAST) ifFalse: [
		^ self error: 'Evaluation failed'.    
	].
	^ outAST at: 1

]

{ #category : #'as yet unclassified' }
Z3Model >> getConstInterp: aFuncDecl [
	^ Z3 model_get_const_interp: ctx _: self _: aFuncDecl

]

{ #category : #'as yet unclassified' }
Z3Model >> getInterp: aFuncDecl [
	| r |
	r := self getInterpAST: aFuncDecl.
	r isNil ifTrue: [ ^nil ].
	r isAsArray ifFalse: [ ^r ].
	self getInterp: self shouldBeImplemented
]

{ #category : #'as yet unclassified' }
Z3Model >> getInterpAST: aFuncDecl [
	aFuncDecl arity = 0 ifFalse: [ self shouldBeImplemented ].
	^self getConstInterp: aFuncDecl
]

{ #category : #'as yet unclassified' }
Z3Model >> gtInspectorTextIn: composite [
	<gtInspectorPresentationOrder: -10>
	composite text
		title: 'String';
		display: [ self toString ]

]

{ #category : #'ref-counting' }
Z3Model >> incRef [
	Z3 model_inc_ref: ctx _: self.  

]

{ #category : #'as yet unclassified' }
Z3Model >> numConstants [
	^ Z3 model_get_num_consts: ctx _: self

]

{ #category : #'as yet unclassified' }
Z3Model >> toString [
	^Z3 model_to_string: ctx _: self

]
