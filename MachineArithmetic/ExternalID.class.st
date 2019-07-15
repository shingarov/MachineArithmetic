Class {
	#name : #ExternalID,
	#superclass : #Object,
	#instVars : [
		'name'
	],
	#category : #'MachineArithmetic-PythonEngine'
}

{ #category : #'instance creation' }
ExternalID class >> named: varName [
	^super new
		name: varName;
		yourself 
]

{ #category : #'instance creation' }
ExternalID class >> new [
	^self named: self newName
]

{ #category : #'instance creation' }
ExternalID class >> newName [
	^'Var', (2000000 atRandom printStringBase: 16)
]

{ #category : #accessing }
ExternalID >> name [
	^ name
]

{ #category : #accessing }
ExternalID >> name: anObject [
	name := anObject
]

{ #category : #printing }
ExternalID >> printOn: aStream [
	aStream nextPutAll: self name
]

{ #category : #printing }
ExternalID >> printString [
	^self name
]

{ #category : #access }
ExternalID >> pythonClassName [
	^P eval: self ref, '.__class__.__name__'
]

{ #category : #access }
ExternalID >> pythonStr [
	^P eval: self ref, '.__str__()'
]

{ #category : #'python engine' }
ExternalID >> ref [
	^P env: self name
]

{ #category : #'python engine' }
ExternalID >> value [ 
	^P fetchVar: self
]
