Class {
	#name : #FFIIdentityObject,
	#superclass : #FFIExternalObject,
	#classInstVars : [
		'instances'
	],
	#category : #'MachineArithmetic-FFI'
}

{ #category : #'as yet unclassified' }
FFIIdentityObject class >> asExternalTypeOn: generator [
	^ FFIIdentityObjectType objectClass: self
]

{ #category : #'as yet unclassified' }
FFIIdentityObject class >> instances [
	instances isNil ifTrue: [ instances := WeakValueDictionary new ].
	^instances 
]

{ #category : #'as yet unclassified' }
FFIIdentityObject class >> new: anExternalData [ 
	| instance |
	instance := 	self basicNew.
	self instances at: anExternalData asInteger put: instance.
	^instance handle: anExternalData; yourself
]

{ #category : #'as yet unclassified' }
FFIIdentityObject class >> wrapAround: anExternalData [ 
	^self instances
		at: anExternalData asInteger
		ifAbsent: [ self new: anExternalData ]
]
