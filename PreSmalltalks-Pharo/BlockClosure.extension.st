Extension { #name : #BlockClosure }

{ #category : #'*PreSmalltalks-Pharo' }
BlockClosure >> * thenBlock [
	"Answer the block that is the composition of self, then thenBlock.
	 I.e. f*g means f, then g."
	^[ :x | thenBlock value: (self value: x) ]
]

{ #category : #'*PreSmalltalks-Pharo' }
BlockClosure >> S [
	^[ :y :z | (self value: z) value: (y value: z) ]
]

{ #category : #'*PreSmalltalks-Pharo' }
BlockClosure >> argumentName [
	self argumentCount = 1 ifFalse: [ self error ].
	^self argumentNames first
]

{ #category : #'*PreSmalltalks-Pharo' }
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

{ #category : #'*PreSmalltalks-Pharo' }
BlockClosure >> curryLazy: argArray [
	"Like #curry: but non-strict in argArray."
	| n |
	n := self argumentCount - argArray size.
	^{ 
		[ :x | self valueWithArguments: (argArray collect: #value), {x} ].
		[ :x :y | self valueWithArguments: (argArray collect: #value), {x.y} ].
		[ :x :y :z | self valueWithArguments: (argArray collect: #value), {x.y.z} ]
	} at: n
]

{ #category : #'*PreSmalltalks-Pharo' }
BlockClosure >> fix [
	"Answer the least fixed point of the receiver,
	 i.e. the least defined x such that (self value: x) = x.
	
	 Modeled after Haskell's Data.Function.fix:
	 fix :: (a -> a) -> a
	
	 This method is useful in modeling Scott-Strachey
	 semantics of loops and recursion.
	"
	| x |
	x := [ self curryLazy: {[x value]} ].
	^x value
]

{ #category : #'*PreSmalltalks-Pharo' }
BlockClosure class >> id [
	"The I combinator."
	^[ :x | x ]
]

{ #category : #'*PreSmalltalks-Pharo' }
BlockClosure >> uncurry: argArray [
	"Apply the receiver to as many arguments from the beginning of argArray
	 as the receiver expects.  The result is assumed to be a block expecting
	 the rest of the arguments; apply that."
	| n rest |
	n := argArray size - self argumentCount.
	rest := argArray copyFrom: n+1 to: argArray size.
	^(self valueWithEnoughArguments: argArray) valueWithArguments: rest
]

{ #category : #'*PreSmalltalks-Pharo' }
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

{ #category : #'*PreSmalltalks-Pharo' }
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

{ #category : #'*PreSmalltalks-Pharo' }
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

{ #category : #'*PreSmalltalks-Pharo' }
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

{ #category : #'*PreSmalltalks-Pharo' }
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
