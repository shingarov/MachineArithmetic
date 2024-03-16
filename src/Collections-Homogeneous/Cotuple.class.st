Class {
	#name : #Cotuple,
	#superclass : #Object,
	#instVars : [
		'name',
		'injections'
	],
	#category : #'Collections-Homogeneous'
}

{ #category : #'instance creation' }
Cotuple class >> named: aName [
	^self basicNew
		name: aName;
		yourself
]

{ #category : #testing }
Cotuple >> includes: e [
	^injections anySatisfy: [ :inj | e isKindOf: inj ]
]

{ #category : #accessing }
Cotuple >> injections [
	^ injections
]

{ #category : #accessing }
Cotuple >> injections: anObject [
	injections := anObject
]

{ #category : #accessing }
Cotuple >> name [
	^ name
]

{ #category : #accessing }
Cotuple >> name: anObject [
	name := anObject
]

{ #category : #printing }
Cotuple >> printOn: aStream [
	aStream nextPutAll: self name.
	aStream nextPutAll: ' = '.
	self injections isNil   ifTrue: [ ^aStream nextPut: (Character codePoint: 16r22A5) ].
	self injections isEmpty ifTrue: [ ^aStream nextPut: (Character codePoint: 16r22A5) ].
	self injections do: [ :each | each printOn: aStream ] separatedBy: [ aStream nextPutAll: ' | ' ]
]
