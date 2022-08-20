Class {
	#name : #FVar,
	#superclass : #Object,
	#instVars : [
		'i'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FVar class >> new [
	^self shouldNotImplement
]

{ #category : #'instance creation' }
FVar class >> new: i [
	^self basicNew 
		i: i;
		yourself
]

{ #category : #accessing }
FVar >> i [
	^ i
]

{ #category : #accessing }
FVar >> i: anObject [
	i := anObject
]

{ #category : #printing }
FVar >> printOn: aStream [
	aStream nextPutAll: '@('.
	self i printOn: aStream.
	aStream nextPutAll: ')'
	
]
