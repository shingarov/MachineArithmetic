Class {
	#name : #InvalidZ3Object,
	#superclass : #Error,
	#instVars : [
		'object'
	],
	#category : #'MachineArithmetic-Core'
}

{ #category : #signaling }
InvalidZ3Object class >> object: anObject [
	^self new 
		object: anObject;
		signal
]

{ #category : #accessing }
InvalidZ3Object >> object [
	^ object
]

{ #category : #accessing }
InvalidZ3Object >> object: anObject [
	object := anObject
]
