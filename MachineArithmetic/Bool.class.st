Class {
	#name : #Bool,
	#superclass : #Z3Node,
	#category : #'MachineArithmetic-Core'
}

{ #category : #'multi-arity ops' }
Bool class >> and: aCollection [
	self assert: (aCollection allSatisfy: [ :e | e isBool ]).
	^ Z3 mk_and: Z3Context current _: aCollection size _: aCollection

]

{ #category : #'instance creation' }
Bool class >> false [
	^Z3Context current mkFalse 
]

{ #category : #'multi-arity ops' }
Bool class >> or: aCollection [
	self assert: (aCollection allSatisfy: [ :e | e isBool ]).
	^ Z3 mk_or: Z3Context current _: aCollection size _: aCollection

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
	^ self and: rhs

]

{ #category : #'logical operations' }
Bool >> + rhs [
	^ self xor: rhs

]

{ #category : #'logical operations' }
Bool >> ==> rhs [
	^ Z3 mk_implies: ctx _: self _: rhs

]

{ #category : #'logical operations' }
Bool >> and: rhs [
	^ Z3 mk_and: ctx _: 2 _: { self. (self coerce: rhs) }

]

{ #category : #adapting }
Bool >> beLikeMe: value [
	^value toBool
]

{ #category : #'logical operations' }
Bool >> ifThen: trueAST else: falseAST [
	trueAST sort == falseAST sort ifFalse: [ self error: 'Branches must have same sort' ].
	^ Z3 mk_ite: ctx _: self _: trueAST _: falseAST

]

{ #category : #'logical operations' }
Bool >> iff: rhs [
	^ Z3 mk_iff: ctx _: self _: rhs

]

{ #category : #testing }
Bool >> isBool [
	^ true

]

{ #category : #'logical operations' }
Bool >> not [
	^ Z3 mk_not: ctx _: self

]

{ #category : #'logical operations' }
Bool >> or: rhs [
	^ Z3 mk_or: ctx _: 2 _: { self. (self coerce: rhs) }

]

{ #category : #printing }
Bool >> printString [
	^ self astToString
]

{ #category : #converting }
Bool >> toBool [
	^self
]

{ #category : #'logical operations' }
Bool >> value [
	| x |
	x := self simplify.
	x == Bool false ifTrue: [ ^false ].
	x == Bool true  ifTrue: [ ^true ].
	UnknownValidity signal 

]

{ #category : #'logical operations' }
Bool >> xor: rhs [
	^ Z3 mk_xor: ctx _: self _: (self coerce: rhs)

]

{ #category : #'logical operations' }
Bool >> | rhs [
	^ self or: rhs

]
