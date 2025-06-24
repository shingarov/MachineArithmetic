Extension { #name : #Object }

{ #category : #'*PreSmalltalks-Pharo' }
Object >> assume: aBlock [
	"Throw an assumption error if aBlock does not evaluates to true.
	
	 This is much like `Object >> #assert:`, see comment in `Object >> #assume:description:` for
	 further explanation of the difference.
	"
	<debuggerCompleteToSender>
	self assume: aBlock description: 'Assumption failed'.
]

{ #category : #'*PreSmalltalks-Pharo' }
Object >> assume: aBlock description: aStringOrBlock [
	"Throw an assumption error if aBlock does not evaluates to true.
	
	This is much like `Object >> #assume:description:` - both will throw an exception
	at runtime if check fails. The difference is that assume is meant express and
	check method's preconditions whereas assert is to check method's interrim state
	and postcondition.

	In another words - if assume fails then it means it is caller's fault: the caller
	has called the method with wrong arguments or when the receiver is in inappropriate
	state.
	If assert fails then it is method's fault: unexpected internal state or situation
	at some point if it's execution.

	In yet another words (from LH slack):

	> Just like
	>
	> ```
	> cAssert b
	> ```
	>
	> requires b as a precondition,
	>
	> ```
	> cAssume b
	> ```
	>
	> “Ensures” b as a postcondition!!
	> In a strict language you can write
	> ```
	> cAssume :: b:Bool -> {v:() | b}
	> cAssume b = if b then () else diverge()
	> ```
	"
	<debuggerCompleteToSender>
	aBlock value == true
		ifFalse: [ AssumptionFailure signal: aStringOrBlock value ]
]

{ #category : #'*PreSmalltalks-Pharo' }
Object >> perform: aSymbol [ 
	^ self perform: aSymbol withArguments: #()
]

{ #category : #'*PreSmalltalks-Pharo' }
Object >> perform: selector withArguments: argArray [ 
	^ self perform: selector withArguments: argArray inSuperclass: self class
]

{ #category : #'*PreSmalltalks-Pharo' }
Object >> perform: selector withArguments: argArray inSuperclass: lookupClass [
	"Caveat programmator:

	 The ad-hoc hackery you are looking at, is a workaround the stack corruption
	 described in
		http://lists.squeakfoundation.org/pipermail/vm-dev/2022-October/038462.html.
	 VMMaker.oscog-eem.3282 does fix one scenario but there still seem to be other cases
	 where the stack is corrupted if the prim is called with the wrong number of args.
	 The workaround is to never call the prim blindly; always check arity *first*.
	
	 Unfortunately, doing this for all fixed arities (i.e. #perform:with: etc)
	 results in an unusably slow system.  Therefore, in the present temporary
	 workaround we do something horrible: we only allow currying in #perform:
	 and #perform:withArguments: and rely on the programmer to never send
	 #perform:with: with the wrong number arguments.  In other words, now
		obj perform: #x:y: with: a
	 does something else than
		obj perform:#x:y: withArguments: { a }.
	 YOU HAVE BEEN WARNED.
	"
	| numArgs |
	numArgs := selector numArgs.
	numArgs = argArray size
		ifTrue: [ ^self primPerform: selector withArguments: argArray inSuperclass: lookupClass ].

	^numArgs < argArray size
		ifTrue: [ self error: 'cannot uncurry' ]
		ifFalse: [ "curry"
			| n |
			n := numArgs - argArray size.
			{
			[ :x       | self perform: selector withArguments: argArray, {x} inSuperclass: lookupClass ].
			[ :x :y    | self perform: selector withArguments: argArray, {x.y} inSuperclass: lookupClass ].
			[ :x :y :z | self perform: selector withArguments: argArray, {x.y.z} inSuperclass: lookupClass ].
			} at: n
		].
]

{ #category : #'*PreSmalltalks-Pharo' }
Object >> primPerform: selector withArguments: argArray inSuperclass: lookupClass [
	"NOTE:  This is just like perform:withArguments:, except that
	the message lookup process begins, not with the receivers's class,
	but with the supplied superclass instead.  It will fail if lookupClass
	cannot be found among the receiver's superclasses.
	Primitive. Essential. See Object documentation whatIsAPrimitive."

	<reflective: #object:performMessageInSuperclass:>
	<primitive: 100>
	selector isSymbol
		ifFalse: [ ^ self error: 'selector argument must be a Symbol' ].
	(self class includesBehavior: lookupClass)
		ifFalse: [ ^ self error: 'lookupClass is not in my inheritance chain' ].
	selector numArgs = argArray size
		ifFalse: [ ^ self error: 'Undefined behavior on wrong arity' ].	
	self primitiveFailed
]

{ #category : #'*PreSmalltalks-Pharo' }
Object >> value: arg [
	^self valueWithArguments: { arg }
]

{ #category : #'*PreSmalltalks-Pharo' }
Object >> value: arg1 value: arg2 [
	^self valueWithArguments: { arg1. arg2 }
]

{ #category : #'*PreSmalltalks-Pharo' }
Object >> value: arg1 value: arg2 value: arg3 [
	^self valueWithArguments: { arg1. arg2. arg3 }
]

{ #category : #'*PreSmalltalks-Pharo' }
Object >> value: arg1 value: arg2 value: arg3 value: arg4 [
	^self valueWithArguments: { arg1. arg2. arg3. arg4 }
]
