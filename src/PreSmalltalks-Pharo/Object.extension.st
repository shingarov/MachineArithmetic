Extension { #name : #Object }

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
