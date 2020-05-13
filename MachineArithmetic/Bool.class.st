Class {
	#name : #Bool,
	#superclass : #AST,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Bool class >> false [
	^Z3Context current mkFalse 
]

{ #category : #'multi-arity ops' }
Bool class >> or: aCollection [
	| n args ctx |
	n := aCollection size.
	args := FFIExternalArray externalNewType: 'void*' size: n.
	1 to: n do: [ :i |
		args at: i put: (aCollection at: i) getHandle getHandle
		].
	ctx := aCollection anyOne ctx.
	^(LibZ3 uniqueInstance mkOr: ctx numArgs: 2 args: args)
		ctx: ctx
	
]

{ #category : #printing }
Bool class >> printSort: ty on: aStream [
	aStream nextPutAll: 'bool'
]

{ #category : #'instance creation' }
Bool class >> true [
	^Z3Context current mkTrue
]

{ #category : #'instance creation' }
Bool class >> var: aName [
	"Create a bool variable named aName.
	Name can be a String or an Integer."
	^Z3Context current mkBoolVar: aName
]

{ #category : #'logical operations' }
Bool >> & right [
	| args |
	args := FFIExternalArray externalNewType: 'void *' size: 2.
	args at: 1 put: self getHandle getHandle.
	args at: 2 put: right getHandle getHandle.
	^(LibZ3 uniqueInstance mkAnd: ctx numArgs: 2 args: args)
		ctx: ctx
]

{ #category : #'logical operations' }
Bool >> + right [
	"XOR"
	^ (LibZ3 uniqueInstance mkXor: ctx t1: self t2: right)
		ctx: ctx
]

{ #category : #'logical operations' }
Bool >> ==> right [
	^ (LibZ3 uniqueInstance mkImplies: ctx t1: self t2: right)
		ctx: ctx
]

{ #category : #printing }
Bool >> displaySortOn: aStream [
	aStream nextPutAll: 'bool'
]

{ #category : #'logical operations' }
Bool >> ifThen: trueAST else: falseAST [
	trueAST sort == falseAST sort ifFalse: [ self error: 'Branches must have same sort' ].
	^AST wrap: (LibZ3 uniqueInstance mkITE: ctx t1: self t2: trueAST t3: falseAST) in: ctx
]

{ #category : #'logical operations' }
Bool >> iff: right [
	^ (LibZ3 uniqueInstance mkIff: ctx t1: self t2: right)
		ctx: ctx
]

{ #category : #'logical operations' }
Bool >> not [
	^ (LibZ3 uniqueInstance mkNot: ctx ast: self)
		ctx: ctx
]

{ #category : #'logical operations' }
Bool >> value [
	self = Bool false ifTrue: [ ^false ].
	self = Bool true ifTrue: [ ^true ].
	UnknownValidity signal 
]

{ #category : #'logical operations' }
Bool >> | right [
	| args |
	args := FFIExternalArray externalNewType: 'void *' size: 2.
	args at: 1 put: self getHandle getHandle.
	args at: 2 put: right getHandle getHandle.
	^(LibZ3 uniqueInstance mkOr: ctx numArgs: 2 args: args)
		ctx: ctx
]
