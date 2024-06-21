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
	selector numArgs = argArray size
		ifTrue: [ ^self primPerform: selector withArguments: argArray inSuperclass: lookupClass ].

	^selector numArgs < argArray size
		ifTrue: [ self error: 'cannot uncurry' ]
		ifFalse: [ "curry"
			| n |
			n := selector numArgs - argArray size.
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
