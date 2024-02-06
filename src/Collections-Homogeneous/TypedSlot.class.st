Class {
	#name : #TypedSlot,
	#superclass : #InstanceVariableSlot,
	#instVars : [
		'type'
	],
	#category : #'Collections-Homogeneous'
}

{ #category : #'instance creation' }
TypedSlot class >> named: aString type: aClass [
	^self new
		name: aString;
		type: aClass;
		yourself.
]

{ #category : #comparing }
TypedSlot >> = other [
	^ super = other and: [type = other type]
]

{ #category : #comparing }
TypedSlot >> hash [
	^(super hash + type hash) hashMultiply 
]

{ #category : #initalize }
TypedSlot >> initialize: anObject [
	self write: type new to: anObject
]

{ #category : #printing }
TypedSlot >> printOn: aStream [
	"Every subclass that adds state must redefine either this method or #definitionString"

	aStream nextPutAll: self class name.
	aStream nextPutAll: ' named: '.
	self name storeOn: aStream.
	aStream nextPutAll: ' type: '.
	self type storeOn: aStream
]

{ #category : #accessing }
TypedSlot >> type [
	^ type
]

{ #category : #accessing }
TypedSlot >> type: t [
	type := t
]
