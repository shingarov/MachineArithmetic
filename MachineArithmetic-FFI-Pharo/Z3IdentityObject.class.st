Class {
	#name : #Z3IdentityObject,
	#superclass : #FFIExternalObject,
	#classVars : [
		'EmptyExternalArray'
	],
	#classInstVars : [
		'instances'
	],
	#category : #'MachineArithmetic-FFI-Pharo'
}

{ #category : #'as yet unclassified' }
Z3IdentityObject class >> asExternalTypeOn: generator [
	^ Z3IdentityObjectType objectClass: self
]

{ #category : #utilities }
Z3IdentityObject class >> externalArrayFrom: anArray [
	"Given (smalltalk) `anArray` of Z3 objects, create external (C) array
	 with corresponding (C) pointers to libz3 objects."

	| extArray |
	
	anArray isEmpty ifTrue:[ ^ EmptyExternalArray ].
	
	extArray := FFIExternalArray externalNewType: 'void*' size: anArray size.
	anArray withIndexDo:[:o :i |
		extArray at: i put: (o isNil ifTrue:[ExternalAddress null] ifFalse:[o getHandle getHandle])
	].
	^extArray
		
]

{ #category : #initialization }
Z3IdentityObject class >> initialize [
	EmptyExternalArray := FFIExternalArray externalNewType: 'void*' size: 0.
	
	"
	Z3IdentityObject initialize
	"
]

{ #category : #'as yet unclassified' }
Z3IdentityObject class >> instances [
	instances isNil ifTrue: [ instances := WeakValueDictionary new ].
	^instances 
]

{ #category : #'as yet unclassified' }
Z3IdentityObject class >> new: anExternalData [ 
	| instance |
	instance := 	self basicNew.
	self instances at: anExternalData asInteger put: instance.
	^instance handle: anExternalData; yourself
]

{ #category : #'as yet unclassified' }
Z3IdentityObject class >> unwrapAround: anObject [
	self instances removeKey: anObject handle asInteger.	
	
]

{ #category : #'as yet unclassified' }
Z3IdentityObject class >> wrapAround: anExternalData [ 
	^self instances
		at: anExternalData asInteger
		ifAbsent: [ self new: anExternalData ]
]

{ #category : #utilities }
Z3IdentityObject >> externalArray: anFFIExternalArray  pointerAt: anInteger [
	^ anFFIExternalArray at: anInteger 
		
]

{ #category : #utilities }
Z3IdentityObject >> externalArrayFrom: anArray [
	^self class externalArrayFrom: anArray 
		
]

{ #category : #utilities }
Z3IdentityObject >> poison [
	"'Poison' the object, i.e., set the handle to 'poison' value. 
	 To be called when the object is destroyed in Smalltalk and should
	 no longer be used. This is to help debugging use-after-free bugs."
	
	self setHandle: ExternalAddress newPoison 
]
