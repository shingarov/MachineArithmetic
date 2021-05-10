Class {
	#name : #Z3Object,
	#superclass : #ExternalAddress,
	#classVars : [
		'Instances'
	],
	#category : #'MachineArithmetic-FFI-SmalltalkX'
}

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
	Instances isNil ifTrue: [ Instances := WeakValueDictionary new ].
	self withAllSubclassesDo:[:cls|
		cls flags: (cls flags bitOr:Behavior flagNonObjectInst)  
	].
	"
	Z3IdentityObject initialize
	"     
]

{ #category : #'as yet unclassified' }
Z3Object class >> instances [
	<resource: #obsolete>
	self error: 'Should no longer be used' 

]

{ #category : #'as yet unclassified' }
Z3Object class >> new: anExternalAddress [
	<resource: #obsolete>
	self error: 'Should no longer be used' 

]

{ #category : #'as yet unclassified' }
Z3Object class >> unwrapAround: anObject [                                  
	<resource: #obsolete>
	self error: 'Should no longer be used' 

]

{ #category : #'as yet unclassified' }
Z3Object class >> wrapAround: anExternalData [ 
	<resource: #obsolete>
	self error: 'Should no longer be used' 

]

{ #category : #utilities }
Z3Object >> externalArray: externalArray pointerAt: index [
	"Given an `externalArray` return a pointer (as ExternalAddress) 
	 at given `index`. Index is 1-based like in smalltalk. "

	^ externalArray pointerAt: ((index - 1) * ExternalAddress sizeOfPointer) + 1
]

{ #category : #initialization }
Z3Object >> initialize [
	self error: 'Should not be sent nor overriden. Use / override `#initializeWithAddress:` instead'

]

{ #category : #initialization }
Z3Object >> initializeWithAddress: anExternalAddress [
	self setAddress: anExternalAddress

]

{ #category : #utilities }
Z3Object >> poison [
	"'Poison' the object, i.e., set the handle to 'poison' value. 
	 To be called when the object is destroyed in Smalltalk and should
	 no longer be used. This is to help debugging use-after-free bugs."
	
	self setAddress: ExternalAddress newPoison 
]
