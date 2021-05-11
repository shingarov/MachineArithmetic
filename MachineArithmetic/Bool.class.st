Class {
	#name : #Bool,
	#superclass : #Z3Node,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Bool class >> false [
	^Z3Context current mkFalse 
]

{ #category : #'multi-arity ops' }
Bool class >> or: aCollection [
	| ctx args |
	ctx := aCollection anyOne ctx.
	self assert: (aCollection allSatisfy: [ :e | e ctx == ctx ]).
	args := self externalArrayFrom: aCollection.
	^(LibZ3 uniqueInstance mkOr: ctx numArgs: aCollection size args: args)
		ctx: ctx
]

{ #category : #printing }
Bool class >> printSort: ty on: aStream [
	aStream nextPutAll: 'bool'
]

{ #category : #sorting }
Bool class >> sort [
	^Z3Sort bool
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

{ #category : #'logical operations' }
Bool >> ifThen: trueAST else: falseAST [
	trueAST sort == falseAST sort ifFalse: [ self error: 'Branches must have same sort' ].
	^Z3AST wrap: (LibZ3 uniqueInstance mkITE: ctx t1: self t2: trueAST t3: falseAST) in: ctx

]

{ #category : #'logical operations' }
Bool >> iff: right [
	^ (LibZ3 uniqueInstance mkIff: ctx t1: self t2: right)
		ctx: ctx
]

{ #category : #testing }
Bool >> isBool [
	^ true

]

{ #category : #'logical operations' }
Bool >> not [
	^ (LibZ3 uniqueInstance mkNot: ctx ast: self)
		ctx: ctx
]

{ #category : #printing }
Bool >> printString [
	^ self value ifTrue: [ 'Bool true' ] ifFalse: [ 'Bool false' ]

]

{ #category : #converting }
Bool >> toBool [
	^self
]

{ #category : #'logical operations' }
Bool >> value [
	self == ctx mkFalse ifTrue: [ ^false ].
	self == ctx mkTrue ifTrue: [ ^true ].
	UnknownValidity signal 

]

{ #category : #'logical operations' }
Bool >> | rhs [
	| args |
	args := self externalArrayFrom: { self. (self coerce: rhs) }.
	^(LibZ3 uniqueInstance mkOr: ctx numArgs: 2 args: args)
		ctx: ctx
]
