Class {
	#name : #FAbs,
	#superclass : #PreSort,
	#instVars : [
		'int',
		'sort'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
FAbs class >> int: i sort: s [ 
	^self basicNew
		int: i;
		sort: s;
		yourself 
		
]

{ #category : #accessing }
FAbs >> int [
	^ int
]

{ #category : #accessing }
FAbs >> int: anObject [
	int := anObject
]

{ #category : #printing }
FAbs >> printOn: aStream [
	aStream nextPutAll: 'FAbs '.
	self int printOn: aStream.
	aStream space.
	self sort printOn: aStream
]

{ #category : #accessing }
FAbs >> sort [
	^ sort
]

{ #category : #accessing }
FAbs >> sort: anObject [
	sort := anObject
]
