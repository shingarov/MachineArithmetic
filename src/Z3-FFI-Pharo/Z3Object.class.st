Class {
	#name : #Z3Object,
	#superclass : #FFIExternalObject,
	#classInstVars : [
		'instances'
	],
	#category : #'Z3-FFI-Pharo'
}

{ #category : #'as yet unclassified' }
Z3Object class >> asExternalTypeOn: generator [
	^ Z3ObjectType objectClass: self
]

{ #category : #utilities }
Z3Object class >> externalArray: anFFIExternalArray  pointerAt: anInteger [
	^ anFFIExternalArray at: anInteger 
		
]

{ #category : #utilities }
Z3Object class >> externalArray: anFFIExternalArray  u32At: anInteger [
	^ anFFIExternalArray at: anInteger 
		
]

{ #category : #utilities }
Z3Object class >> externalArrayFrom: anArray [
	"Given (smalltalk) `anArray` of Z3 objects, create external (C) array
	 with corresponding (C) pointers to libz3 objects."

	| extArray |
		
	extArray := FFIExternalArray externalNewType: 'void*' size: anArray size.
	anArray withIndexDo:[:o :i |
		extArray at: i put: (o isNil ifTrue:[ExternalAddress null] ifFalse:[o getHandle getHandle])
	].
	^extArray
		
]

{ #category : #utilities }
Z3Object class >> externalU32ArrayFrom: anArray [
	"Given (smalltalk) `anArray` of integers, create an external array
   of unsigned 32-bit integers (in C: `uint32_t array[]`)

   CAVEAT: the returned (C) memory is NOT automatically freed. The caller
   is responsible to `#free` it when no longer needed.
  "

	| extArray |
	extArray := FFIExternalArray newType: 'uint32' size: 10.
	anArray
		withIndexDo:
			[ :object :index | extArray at: index put: object ].
	^ extArray
]

{ #category : #'instance creation' }
Z3Object class >> fromExternalAddress: address [
	"Create an instance of receiver with given handle.
	 This is sent by the FFI machinery, see `Z3ObjectType >> emit...`"
	^ self basicNew 
			initializeWithAddress: address; 
   		yourself.
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
     (based on the pointer value). Othwewise, throw an error.

     If you encounter this during a test, maybe you want to do:
     Z3Context createGlobalContext
    "

    self isNull ifTrue: [ self error:'Invalid Z3 object (null)!' ].
    self isPoisoned ifTrue: [ self error:'Invalid Z3 object (poisoned)!' ].

]

{ #category : #utilities }
Z3Object >> externalArray: anFFIExternalArray  pointerAt: anInteger [
	^ anFFIExternalArray at: anInteger 
		
]

{ #category : #utilities }
Z3Object >> externalArrayFrom: anArray [
	^self class externalArrayFrom: anArray 
		
]

{ #category : #finalization }
Z3Object >> finalize [
	(self isNull or: [ self isPoisoned ]) ifTrue: [
        "Invalid or already released."
        ^ self
    ].
	self delete
]

{ #category : #'initialization & release' }
Z3Object >> initialize [
	self error:'Should not be sent nor overidden. Use `#initializeWithAddress:` instead'
]

{ #category : #'initialization & release' }
Z3Object >> initializeWithAddress: address [
	self setHandle: address
]

{ #category : #testing }
Z3Object >> isPoisoned [
	"Return true, if this value has been 'poisoned', false otherwise.
	 See #poison."
	
	"Note, that below value is hard-coded for performance, see
	 ExternalAddress class >> #newPoison. Keep in sync!"
	
	^ self getHandle asInteger == 16rBAD00BAD.
	
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
	
	self setHandle: ExternalAddress newPoison 
]

{ #category : #finalization }
Z3Object >> registerForFinalization [
	self finalizationRegistry add: self.
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
    self unregisterForFinalization.
    self delete.
    self poison.
]

{ #category : #finalization }
Z3Object >> unregisterForFinalization [
	self finalizationRegistry remove: self ifAbsent: []
]
