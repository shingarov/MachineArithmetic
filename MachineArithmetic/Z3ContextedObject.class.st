"
I am the abstract superclass of any native Z3 struct which hangs off a Z3 context.
As such, I point to my parent Z3Context and to the native pointer:
the former is kept in my ctx instvar, and the latter in the 'handle' inherited from FFIExternalObject.
"
Class {
	#name : #Z3ContextedObject,
	#superclass : #Z3IdentityObject,
	#instVars : [
		'ctx'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #'instance creation' }
Z3ContextedObject class >> ctx: c handle: h [
	^(self wrapAround: h) ctx: c
]

{ #category : #accessing }
Z3ContextedObject >> ctx [
	^ ctx
]

{ #category : #accessing }
Z3ContextedObject >> ctx: anObject [
	ctx := anObject.
	^self
]
