Class {
	#name : #Z3Model,
	#superclass : #Z3ContextedObject,
	#category : #'MachineArithmetic-Core'
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
Z3Model >> constDecl: j [
	^(LibZ3 uniqueInstance modelGetConstDecl: ctx model: self index: j) ctx: self ctx
]

{ #category : #'as yet unclassified' }
Z3Model >> constants [
	| n resultDictionary |
	n := self numConstants.
	resultDictionary := Dictionary new.
	(0 to: n - 1) do: [ :j |
		| cnst name a v |
		cnst := self constDecl: j.
		name := cnst name getString.
		a := cnst app.
		v := self eval: a completion: true.
		resultDictionary at: name put: v astToString
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
		name := cnst name getString.
		a := cnst app.
		v := self eval: a completion: true.
		resultDictionary at: name put: v
	 ].
	^resultDictionary 
]

{ #category : #'ref-counting' }
Z3Model >> decRef [
	self class unwrapAround: self.
	LibZ3 uniqueInstance decRef: ctx solver: self.
	self poison.
]

{ #category : #'as yet unclassified' }
Z3Model >> displayFunctionInterpretations [
	self shouldBeImplemented 
]

{ #category : #'as yet unclassified' }
Z3Model >> eval: anAST completion: aBool [
	| v success h |
	v := ExternalAddress newPointer.
	success := LibZ3 uniqueInstance modelEval: ctx model: self ast: anAST completion: aBool dest: v.
	success ifFalse: [ self error ].
	h := ExternalAddress fromAddress: (v unsignedLongLongAt: 1).
	^AST wrap: h in: ctx
]

{ #category : #'as yet unclassified' }
Z3Model >> getConstInterp: aFuncDecl [
	^AST
		wrap: (LibZ3 uniqueInstance modelGetConstInterp: ctx model: self funcDecl: aFuncDecl)
		in: self ctx
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

{ #category : #'ref-counting' }
Z3Model >> incRef [
	^LibZ3 uniqueInstance modelIncRef: ctx model: self
]

{ #category : #'as yet unclassified' }
Z3Model >> numConstants [
	^LibZ3 uniqueInstance modelGetNumConsts: ctx model: self
]

{ #category : #'as yet unclassified' }
Z3Model >> toString [
	^LibZ3 uniqueInstance modelToString: ctx model: self
]
