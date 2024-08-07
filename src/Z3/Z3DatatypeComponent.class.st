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

{ #category : #'instance creation' }
Z3DatatypeComponent >> new [
	^self withValues: #()
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

{ #category : #'instance creation' }
Z3DatatypeComponent >> with: a1 [ 
	^self withValues: { a1 }
]

{ #category : #'instance creation' }
Z3DatatypeComponent >> with: a1 with: a2 [
	^self withValues: { a1 . a2 }
]

{ #category : #'instance creation' }
Z3DatatypeComponent >> with: a1 with: a2 with: a3 [
	^self withValues: { a1 . a2 . a3}
]

{ #category : #'instance creation' }
Z3DatatypeComponent >> with: a1 with: a2 with: a3 with: a4 [
	^self withValues: { a1 . a2 . a3 . a4}
]

{ #category : #'instance creation' }
Z3DatatypeComponent >> with: a1 with: a2 with: a3 with: a4 with: a5 [
	^self withValues: { a1 . a2 . a3 . a4 . a5}
]

{ #category : #'instance creation' }
Z3DatatypeComponent >> with: a1 with: a2 with: a3 with: a4 with: a5 with: a6 [
	^self withValues: { a1 . a2 . a3 . a4 . a5 .a6 }
]

{ #category : #'instance creation' }
Z3DatatypeComponent >> with: a1 with: a2 with: a3 with: a4 with: a5 with: a6 with: a7 [
	^self withValues: { a1 . a2 . a3 . a4 . a5 . a6 . a7}
]

{ #category : #'instance creation' }
Z3DatatypeComponent >> with: a1 with: a2 with: a3 with: a4 with: a5 with: a6 with: a7 with: a8 [
	^self withValues: { a1 . a2 . a3 . a4 . a5 . a6 . a7 . a8 }
]

{ #category : #private }
Z3DatatypeComponent >> withValues: values [
	constructor arity ~~ values size ifTrue:[
		self error: 'Invalid number of arguments'
	].
	^constructor valueWithArguments: values
]
