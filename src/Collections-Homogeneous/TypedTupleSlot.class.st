Class {
	#name : #TypedTupleSlot,
	#superclass : #InstanceVariableSlot,
	#instVars : [
		'type'
	],
	#category : #'Collections-Homogeneous'
}

{ #category : #'instance creation' }
TypedTupleSlot class >> named: aString type: aClass [
	^self new
		name: aString;
		type: aClass;
		yourself.
]

{ #category : #comparing }
TypedTupleSlot >> = other [
	^ super = other and: [type = other type]
]

{ #category : #comparing }
TypedTupleSlot >> hash [
	^(super hash + type hash) hashMultiply 
]

{ #category : #initalize }
TypedTupleSlot >> initialize: anObject [
	self write: type new to: anObject
]

{ #category : #testing }
TypedTupleSlot >> isAnonymous [
	"Return true if this is 'anonymous' slot, false
	 otherwise"
	
	^name first == $_
]

{ #category : #printing }
TypedTupleSlot >> printOn: aStream [
	"Every subclass that adds state must redefine either this method or #definitionString"
	aStream 
		nextPutAll: self class name;
		nextPutAll: ' named: '.
	self name storeOn: aStream.
	aStream nextPutAll: ' type: '.
	self type storeOn: aStream
]

{ #category : #accessing }
TypedTupleSlot >> type [
	^ type
]

{ #category : #accessing }
TypedTupleSlot >> type: aClass [ 
	self assert: aClass isClass.
	type := aClass
]

{ #category : #'meta-object-protocol' }
TypedTupleSlot >> wantsInitialization [
	"we need to call the initialize to set the default value for the base slot"
	^"true"false"<-- We need more magic in initialize: to support for example Integer"
]
