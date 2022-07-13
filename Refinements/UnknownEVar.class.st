Class {
	#name : #UnknownEVar,
	#superclass : #Object,
	#instVars : [
		'sym'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
UnknownEVar class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
UnknownEVar class >> new: sym [
	^self basicNew
		sym: sym;
		yourself 
]

{ #category : #printing }
UnknownEVar >> printOn: aStream [
	aStream nextPut: Character replacementCharacter; nextPutAll: sym

]

{ #category : #accessing }
UnknownEVar >> sym [
	^ sym
]

{ #category : #accessing }
UnknownEVar >> sym: anObject [
	sym := anObject
]
