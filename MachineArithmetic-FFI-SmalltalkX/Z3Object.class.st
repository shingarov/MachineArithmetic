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

{ #category : #'as yet unclassified' }
Z3Object class >> fromExternalAddress: anExternalAddress [
	^ self wrapAround: anExternalAddress
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
	Instances isNil ifTrue: [ Instances := WeakValueDictionary new ].
	^Instances 
]

{ #category : #'as yet unclassified' }
Z3Object class >> new: anExternalAddress [ 
	^ self basicNew 
		setAddress: anExternalAddress
		yourself.
]

{ #category : #'as yet unclassified' }
Z3Object class >> unwrapAround: anObject [                                  
	self instances 
		removeKey: (anObject handle asInteger -> anObject class) 
		ifAbsent: []
]

{ #category : #'as yet unclassified' }
Z3Object class >> wrapAround: anExternalData [ 
	^self instances
		at: (anExternalData asInteger -> self)
		ifAbsentPut: [ self new: anExternalData ]
]

{ #category : #utilities }
Z3Object >> externalArray: externalArray pointerAt: index [
	"Given an `externalArray` return a pointer (as ExternalAddress) 
	 at given `index`. Index is 1-based like in smalltalk. "

	^ externalArray pointerAt: ((index - 1) * ExternalAddress sizeOfPointer) + 1
]

{ #category : #utilities }
Z3Object >> externalArrayFrom: anArray [
	^self class externalArrayFrom: anArray 
]

{ #category : #utilities }
Z3Object >> poison [
	"'Poison' the object, i.e., set the handle to 'poison' value. 
	 To be called when the object is destroyed in Smalltalk and should
	 no longer be used. This is to help debugging use-after-free bugs."
	
	self setAddress: ExternalAddress newPoison 
]
