"
I am the abstract superclass of any native Z3 struct which hangs off a Z3 context.
As such, I point to my parent Z3Context and to the native pointer:
the former is kept in my ctx instvar, and the latter in the 'handle' inherited from FFIExternalObject.
"
Class {
	#name : #Z3ContextedObject,
	#superclass : #Z3Object,
	#instVars : [
		'ctx'
	],
	#category : #'Z3-Core'
}

{ #category : #'instance creation' }
Z3ContextedObject class >> ctx: c handle: h [
	<resource: #obsolete>
	self error: 'Should no longer be used' 

]

{ #category : #'instance creation' }
Z3ContextedObject class >> fromExternalAddress: anExternalAddress [
	"For contexted objects are created by #fromExternalAddress:inContext:
	 Here we return a raw handle, that is then passed to 
	 #fromExternalAddress:inContext: which is responsible to instantiate
	 the correct class and set it up.

	 This serves two purposes: 
	   (i) we avoid creating an instance of contexted object without context.
	   (ii) it serves as a guard against misuse - when one forgets to pass it
	   through `#fromExternalAddress:inContext:`, she likely gets DNU soon
	   because she gets a raw handle.
	"
	^ anExternalAddress

]

{ #category : #'instance creation' }
Z3ContextedObject class >> fromExternalAddress: anExternalAddress inContext: aZ3Context [
	^ self basicNew
		initializeWithAddress: anExternalAddress context: aZ3Context;
		yourself

]

{ #category : #accessing }
Z3ContextedObject >> ctx [
	^ ctx
]

{ #category : #accessing }
Z3ContextedObject >> ctx: anObject [
	<resource: #obsolete>
	self error: 'Should no longer be used' 

]

{ #category : #initialization }
Z3ContextedObject >> initialize [
	self error: 'Should not be sent nor overriden. Use / override `#initializeWithAddress:context:` instead'

]

{ #category : #initialization }
Z3ContextedObject >> initializeWithAddress: anExternalAddress context: aZ3Context [
	super initializeWithAddress: anExternalAddress.
	ctx := aZ3Context

]

{ #category : #utilities }
Z3ContextedObject >> poison [
	super poison.
	ctx := nil.
]
