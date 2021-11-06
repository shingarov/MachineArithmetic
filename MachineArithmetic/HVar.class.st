Class {
	#name : #HVar,
	#superclass : #HThing,
	#instVars : [
		'name',
		'argSorts'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #'instance creation' }
HVar class >> name: aString argSorts: sorts [
	^self basicNew
		name: aString;
		argSorts: sorts;
		yourself
]

{ #category : #adding }
HVar >> addToQuery: q [ 
	q vars add: self
]

{ #category : #accessing }
HVar >> argSorts [
	^ argSorts
]

{ #category : #accessing }
HVar >> argSorts: anObject [
	argSorts := anObject
]

{ #category : #accessing }
HVar >> name [
	^ name
]

{ #category : #accessing }
HVar >> name: anObject [
	name := anObject
]
