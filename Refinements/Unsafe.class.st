Class {
	#name : #Unsafe,
	#superclass : #FixResult,
	#instVars : [
		'bads'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Unsafe class >> bads: aCollection [
	^self basicNew
		bads: aCollection;
		yourself
]

{ #category : #'instance creation' }
Unsafe class >> new [
	self shouldNotImplement
]

{ #category : #accessing }
Unsafe >> bads [
	^ bads
]

{ #category : #accessing }
Unsafe >> bads: anObject [
	bads := anObject
]

{ #category : #testing }
Unsafe >> isSafe [
	^false
]
