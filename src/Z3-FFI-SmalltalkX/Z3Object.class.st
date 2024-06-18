Class {
	#name : #Z3Object,
	#superclass : #ExternalAddress,
	#category : #'Z3-FFI-SmalltalkX'
}

{ #category : #utilities }
Z3Object class >> externalArray: externalArray pointerAt: index [
	"Given an `externalArray` return a pointer (as ExternalAddress) 
	 at given `index`. Index is 1-based like in smalltalk. "

	^ externalArray pointerAt: ((index - 1) * ExternalAddress sizeOfPointer) + 1
]

{ #category : #utilities }
Z3Object class >> externalArray: externalArray u32At: index [
	"Given an `externalArray` return an unsigned 32bit integer
	 at given `index`. Index is 1-based like in smalltalk. "

	^ externalArray unsignedInt32At: ((index - 1) * 32) + 1

]

{ #category : #utilities }
Z3Object class >> externalArrayFrom: anArray [
	"Given (smalltalk) `anArray` of Z3 objects, create external (C) array
	 with corresponding (C) pointers to libz3 objects.

	 CAVEAT: the returned (C) memory is NOT automatically freed. The caller
	 is responsible to `#free` it when no longer needed.
	"

	| extArray |

	anArray isEmpty ifTrue: [ ^ nil ].
	extArray := ExternalBytes new: ExternalBytes sizeofPointer * anArray size.
	anArray withIndexDo: [:object :index | 
		extArray pointerAt: ((index - 1) * ExternalBytes sizeofPointer) + 1
			put: object
	].
	^ extArray
]

{ #category : #utilities }
Z3Object class >> externalU32ArrayFrom: anArray [
	"Given (smalltalk) `anArray` of integers, create an external array
	 of unsigned 32-bit integers (in C: `uint32_t array[]`)

	 CAVEAT: the returned (C) memory is NOT automatically freed. The caller
	 is responsible to `#free` it when no longer needed.
	"

	| extArray |

	anArray isEmpty ifTrue: [ ^ nil ].
	extArray := ExternalBytes new: 32 * anArray size.
	anArray withIndexDo: [:object :index | 
		extArray unsignedInt32At: ((index - 1) * 32) + 1 put: object
	].
	^ extArray

]

{ #category : #'instance creation' }
Z3Object class >> fromExternalAddress: anExternalAddress [
	"Creates a new instance referring to the same
	 memory as parameter `anExternalAddress`.

	 This method is called by FFI (ExternalLibraryFunction)
	 to create a return value of this type.
	"
	^ self basicNew 
		initializeWithAddress: anExternalAddress; 
		yourself

	"Modified: / 12-08-2020 / 12:04:48 / Jan Vrany <jan.vrany@labware.com>"

]

{ #category : #initialization }
Z3Object class >> initialize [
	self withAllSubclassesDo:[:cls|
		cls flags: (cls flags bitOr:Behavior flagNonObjectInst)  
	].
	"
	Z3Object initialize
	"     

]

{ #category : #'initialization & release' }
Z3Object >> delete [
	"Delete (deallocate) underlaying Z3 resource.

	 Private, do not call directly, use #release
	 instead."

	self subclassResponsibility
]

{ #category : #utilities }
Z3Object >> ensureValidZ3AST [
	"This method is no-op if the object appears to be valid
	 (based on the pointer value) and if it's an AST (based
	 on receiver's class)."

	self error:'Invalid Z3 AST (not an Z3AST instance)!'
]

{ #category : #utilities }
Z3Object >> ensureValidZ3ASTOfKind: kind [
	"This method is no-op if the object appears to be valid
	 (based on the pointer value) and if it's an AST of given
	 kind (based on receiver's kind)."

	self error:'Invalid Z3 AST (not an Z3AST instance)!'
]

{ #category : #utilities }
Z3Object >> ensureValidZ3Object [
	"This method is no-op if the object appears to be valid
	 (based on the pointer value). Othwewise, thrown and
	 error."

	self isNull ifTrue: [ self error:'Invalid Z3 object (null)!' ].
	self isPoisoned ifTrue: [ self error:'Invalid Z3 object (poisoned)!' ].
]

{ #category : #initialization }
Z3Object >> initialize [
	self error: 'Should not be sent nor overriden. Use / override `#initializeWithAddress:` instead'

]

{ #category : #initialization }
Z3Object >> initializeWithAddress: anExternalAddress [
	self setAddress: anExternalAddress

]

{ #category : #testing }
Z3Object >> isPoisoned [
	"Return true, if this value has been 'poisoned', false otherwise.
	 See #poison."
	
	"Note, that below value is hard-coded for performance, see
	 ExternalAddress class >> #newPoison. Keep in sync!"    
	^ self address == 16rBAD00BAD.
	
	"
	Z3Object new poison; isPoisoned.
	Z3Object new isPoisoned.
	"
]

{ #category : #utilities }
Z3Object >> poison [
	"'Poison' the object, i.e., set the handle to 'poison' value. 
	 To be called when the object is destroyed in Smalltalk and should
	 no longer be used. This is to help debugging use-after-free bugs."
	
	self setAddress: ExternalAddress newPoison 
]

{ #category : #'initialization & release' }
Z3Object >> release [
	"Release underlaying Z3 resource.

	 Subclasses normally do not need to override this method (except in
	 special cases). However, receiver must override #delete (unless it
	 overrides #release, of course).

	 This method must be idempotent.
	"
	(self isNull or: [ self isPoisoned ]) ifTrue: [
		"Invalid or already released."
		^ self
	].
	self delete.
	self poison.
]
