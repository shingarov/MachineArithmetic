Class {
	#name : #Z3DatatypeComponent,
	#superclass : #Object,
	#instVars : [
		'constructor',
		'recognizer',
		'accessors'
	],
	#category : #'Z3-Core'
}

{ #category : #private }
Z3DatatypeComponent >> accessors [
	^ accessors
]

{ #category : #private }
Z3DatatypeComponent >> accessors: aCollection [
	accessors := aCollection
]

{ #category : #private }
Z3DatatypeComponent >> constructor [
	^ constructor
]

{ #category : #private }
Z3DatatypeComponent >> constructor: anObject [
	constructor := anObject
]

{ #category : #private }
Z3DatatypeComponent >> name [
	^constructor name
]

{ #category : #private }
Z3DatatypeComponent >> recognizer [
	^ recognizer
]

{ #category : #private }
Z3DatatypeComponent >> recognizer: anObject [
	recognizer := anObject
]

{ #category : #private }
Z3DatatypeComponent >> sort [
	^constructor range
]

