Class {
	#name : #Cube,
	#superclass : #Object,
	#instVars : [
		'binds',
		'subst',
		'id'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Cube class >> binds: binds subst: subst id: id [
	^self basicNew
		binds: binds;
		subst: subst;
		id: id;
		yourself 

]

{ #category : #accessing }
Cube >> binds [
	^ binds
]

{ #category : #accessing }
Cube >> binds: anObject [
	binds := anObject
]

{ #category : #accessing }
Cube >> id [
	^ id
]

{ #category : #accessing }
Cube >> id: anObject [
	id := anObject
]

{ #category : #accessing }
Cube >> subst [
	^ subst
]

{ #category : #accessing }
Cube >> subst: anObject [
	subst := anObject
]
