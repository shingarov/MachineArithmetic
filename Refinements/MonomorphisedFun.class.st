"
I represent a choice of a component of a natural transformation;
for example, the c-component of natural transformation α is α(c).
I don't actually know anything neither about α nor about α(c), only
the name 'α' and the index (the object c at which the component is
taken).  In other words, I simply augment the name, like a version
number or something.
"
Class {
	#name : #MonomorphisedFun,
	#superclass : #Object,
	#instVars : [
		'name',
		'c'
	],
	#category : #Refinements
}

{ #category : #comparing }
MonomorphisedFun >> = rhs [
	rhs class = self class ifFalse: [ ^false ].
	^c = rhs c and: [ name = rhs name ]
]

{ #category : #accessing }
MonomorphisedFun >> c [
	^ c
]

{ #category : #accessing }
MonomorphisedFun >> c: anObject [
	c := anObject
]

{ #category : #comparing }
MonomorphisedFun >> hash [
	^name hash
]

{ #category : #accessing }
MonomorphisedFun >> name [
	^ name
]

{ #category : #accessing }
MonomorphisedFun >> name: anObject [
	name := anObject
]
