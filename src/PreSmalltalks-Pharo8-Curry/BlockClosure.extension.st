Extension { #name : #BlockClosure }

{ #category : #'*PreSmalltalks-Pharo8-Curry' }
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

{ #category : #'*PreSmalltalks-Pharo8-Curry' }
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

{ #category : #'*PreSmalltalks-Pharo8-Curry' }
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

{ #category : #'*PreSmalltalks-Pharo8-Curry' }
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

{ #category : #'*PreSmalltalks-Pharo8-Curry' }
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
