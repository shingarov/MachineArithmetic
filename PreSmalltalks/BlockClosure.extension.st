Extension { #name : #BlockClosure }

{ #category : #'*PreSmalltalks' }
BlockClosure >> * thenBlock [
	"Answer the block that is the composition of self, then thenBlock.
	 I.e. f*g means f, then g."
	^[ :x | thenBlock value: (self value: x) ]
]

{ #category : #'*PreSmalltalks' }
BlockClosure >> S [
	^[ :y :z | (self value: z) value: (y value: z) ]
]

{ #category : #'*PreSmalltalks' }
BlockClosure >> argumentName [
	self argumentCount = 1 ifFalse: [ self error ].
	^self argumentNames first
]

{ #category : #'*PreSmalltalks' }
BlockClosure >> curry: argArray [
	"The number of arguments supplied is not enough
	 to evaluate the receiver.
	 Answer a block that expects the missing arguments	and
	 performs the full evaluation once they have been supplied."

	"NB: This is a temporary implementation to illustrate the concept.
	I am too lazy to create a block with arbitrary number of arguments
	right now but it should be doable."
	| n |
	n := self argumentCount - argArray size.
	^{ 
		[ :x | self valueWithArguments: argArray, {x} ].
		[ :x :y | self valueWithArguments: argArray, {x.y} ].
		[ :x :y :z | self valueWithArguments: argArray, {x.y.z} ]
	} at: n
]

{ #category : #'*PreSmalltalks' }
BlockClosure class >> id [
	"The I combinator."
	^[ :x | x ]
]

{ #category : #'*PreSmalltalks' }
BlockClosure >> uncurry: argArray [
	"Apply the receiver to as many arguments from the beginning of argArray
	 as the receiver expects.  The result is assumed to be a block expecting
	 the rest of the arguments; apply that."
	| n rest |
	n := argArray size - self argumentCount.
	rest := argArray copyFrom: n+1 to: argArray size.
	^(self valueWithEnoughArguments: argArray) valueWithArguments: rest
]

{ #category : #'*PreSmalltalks' }
BlockClosure >> value: anArg [
	"Activate the receiver, creating a closure activation (MethodContext)
	 whose closure is the receiver and whose caller is the sender of this message.
	 Supply the argument and copied values to the activation as its arguments and copied temps.
	 Primitive. Optional (but you're going to want this for performance)."	 
	<primitive: 202>
	numArgs > 1 ifTrue:
		[^self curry: {anArg}].
	numArgs < 1 ifTrue:
		[^self uncurry: {anArg}].
	self primitiveFailed
]

{ #category : #'*PreSmalltalks' }
BlockClosure >> value: firstArg value: secondArg [
	"Activate the receiver, creating a closure activation (MethodContext)
	 whose closure is the receiver and whose caller is the sender of this message.
	 Supply the arguments and copied values to the activation as its arguments and copied temps.
	 Primitive. Optional (but you're going to want this for performance)."
	<primitive: 203>
	numArgs > 2 ifTrue:
		[^self curry: {firstArg.secondArg}].
	numArgs < 2 ifTrue:
		[^self uncurry: {firstArg.secondArg}].
	^self primitiveFailed
]

{ #category : #'*PreSmalltalks' }
BlockClosure >> value: firstArg value: secondArg value: thirdArg [
	"Activate the receiver, creating a closure activation (MethodContext)
	 whose closure is the receiver and whose caller is the sender of this message.
	 Supply the arguments and copied values to the activation as its arguments and copied temps.
	 Primitive. Optional (but you're going to want this for performance)."
	<primitive: 204>
	numArgs > 3 ifTrue:
		[^self curry: {firstArg.secondArg.thirdArg}].
	numArgs < 3 ifTrue:
		[^self uncurry: {firstArg.secondArg.thirdArg}].
	^self primitiveFailed
]

{ #category : #'*PreSmalltalks' }
BlockClosure >> value: firstArg value: secondArg value: thirdArg value: fourthArg [
	"Activate the receiver, creating a closure activation (MethodContext)
	 whose closure is the receiver and whose caller is the sender of this message.
	 Supply the arguments and copied values to the activation as its arguments and copied temps.
	 Primitive. Optional (but you're going to want this for performance)."
	<primitive: 205>
	numArgs > 4 ifTrue:
		[^self curry: {firstArg.secondArg.thirdArg.fourthArg}].
	numArgs < 4 ifTrue:
		[^self uncurry: {firstArg.secondArg.thirdArg.fourthArg}].
	^self primitiveFailed
]

{ #category : #'*PreSmalltalks' }
BlockClosure >> valueWithArguments: anArray [
	"Activate the receiver, creating a closure activation (MethodContext)
	 whose closure is the receiver and whose caller is the sender of this message.
	 Supply the arguments in an anArray and copied values to the activation as its arguments and copied temps.
	 Primitive. Optional (but you're going to want this for performance)."
	| newContext ncv |
	<primitive: 206>
	numArgs > anArray size ifTrue:
		[^self curry: anArray].
	numArgs < anArray size ifTrue:
		[^self uncurry: anArray].
	newContext := self asContextWithSender: thisContext sender.
	ncv := self numCopiedValues.
	newContext stackp: ncv + numArgs.
	1 to: numArgs do:
		[:i| newContext at: i put: (anArray at: i)].
	1 to: ncv do:
		[:i| newContext at: i + numArgs put: (self at: i)].
	thisContext privSender: newContext
]
