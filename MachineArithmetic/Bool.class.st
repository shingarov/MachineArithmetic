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
	| args ctx |
	self assert: aCollection size == 2.
	args := self externalArrayFrom: aCollection.
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
Bool >> & rhs [
	| args |
	args := self externalArrayFrom: { self. (self coerce: rhs) }.
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

{ #category : #adapting }
Bool >> beLikeMe: value [
	^value toBool
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

{ #category : #converting }
Bool >> toBool [
	^self
]

{ #category : #'logical operations' }
Bool >> value [
	self = Bool false ifTrue: [ ^false ].
	self = Bool true ifTrue: [ ^true ].
	UnknownValidity signal 
]

{ #category : #'logical operations' }
Bool >> | rhs [
	| args |
	args := self externalArrayFrom: { self. (self coerce: rhs) }.
	^(LibZ3 uniqueInstance mkOr: ctx numArgs: 2 args: args)
		ctx: ctx
]
