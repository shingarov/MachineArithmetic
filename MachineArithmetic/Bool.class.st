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
Bool >> <=> rhs [
	^self iff: rhs
]

{ #category : #'logical operations' }
Bool >> ==> rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_implies: ctx _: self _: rhs.
	].
	^self retry: #'==>' coercing: rhs
	


]

{ #category : #'logical operations' }
Bool >> and: rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_and: ctx _: 2 _: { self . rhs }.
	].
	^self retry: #and: coercing: rhs
	

]

{ #category : #'logical operations' }
Bool >> ifThen: trueAST else: falseAST [
	trueAST sort == falseAST sort ifFalse: [ self error: 'Branches must have same sort' ].
	^ Z3 mk_ite: ctx _: self _: trueAST _: falseAST

]

{ #category : #'logical operations' }
Bool >> ifTrue: trueAlternativeBlock ifFalse: falseAlternativeBlock [
	^self ifThen: trueAlternativeBlock value else: falseAlternativeBlock value
]

{ #category : #'logical operations' }
Bool >> iff: rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_iff: ctx _: self _: rhs.
	].
	^self retry: #iff: coercing: rhs
	


]

{ #category : #testing }
Bool >> isBool [
	^ true

]

{ #category : #testing }
Bool >> isShortExpr [
	^ self == Bool true
]

{ #category : #testing }
Bool >> isSymbolic [
	| variables |
	variables := self simplify variables.
	variables remove: Bool true ifAbsent: [].
	variables remove: Bool false ifAbsent: [].
	^variables notEmpty
	
]

{ #category : #'universal validity' }
Bool >> isValid [
	"Quick-and-dirty shortcut to prove the receiver is universally valid."
	^Z3Solver isValid: self
]

{ #category : #'logical operations' }
Bool >> not [
	^ Z3 mk_not: ctx _: self

]

{ #category : #'logical operations' }
Bool >> or: rhs [
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_or: ctx _: 2 _: { self . rhs }.
	].
	^self retry: #or: coercing: rhs
	

]

{ #category : #printing }
Bool >> printString [
	^ self astToString
]

{ #category : #adapting }
Bool >> retry: selector coercing: rhs [
	^rhs adaptToBool: self andSend: selector
]

{ #category : #'refinement typing' }
Bool >> singletonExpr: varName [
	"Consider whether the receiver, taken as a predicate over variable varName,
	 is the set-builder for a singleton set.
	 If so, answer that singleton's element.
	 If not, or if we are unsure, answer nil.
	 For example,
		x === 42 singletonExpr: 'x'  >>> 42.
	 Note that of the many singleton-builders, we recognize only one simple form,
	 namely equality to an expression.  For example,
		x + 1 === 43 singletonExpr: 'x'  >>> nil
	 even though this Bool builds the same set {42}.
	 This is ok (and even unavoidable) because we are interested in
	 'solvable cases' of Ackermann."
	self isApp ifFalse: [ ^nil ].
	self functorName = '=' ifTrue: [
		| args |
		args := self args.
		(args first isConstantNamed: varName) ifTrue: [ ^args second ].
		(args second isConstantNamed: varName) ifTrue: [ ^args first ].
		^nil ].
	^nil
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
	(self isLikeMe: rhs) ifTrue:[
		^ Z3 mk_xor: ctx _: self _: rhs.
	].
	^self retry: #xor: coercing: rhs
	


]

{ #category : #'logical operations' }
Bool >> | rhs [
	^ self or: rhs

]
