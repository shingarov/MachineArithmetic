Class {
	#name : #Z3IdentityObject,
	#superclass : #FFIExternalObject,
	#classInstVars : [
		'instances'
	],
	#category : #'MachineArithmetic-FFI-Pharo'
}

{ #category : #'as yet unclassified' }
Z3IdentityObject class >> asExternalTypeOn: generator [
	^ Z3IdentityObjectType objectClass: self
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
Z3IdentityObject class >> wrapAround: anExternalData [ 
	^self instances
		at: anExternalData asInteger
		ifAbsent: [ self new: anExternalData ]
]
