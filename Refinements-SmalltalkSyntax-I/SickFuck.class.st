Class {
	#name : #SickFuck,
	#superclass : #Object,
	#instVars : [
		'x',
		's',
		'r',
		'b'
	],
	#category : #'Refinements-SmalltalkSyntax-I'
}

{ #category : #'instance creation' }
SickFuck class >> x: x s: s r: r b: b [
	^self basicNew 
		x: x asString; s: s; r: r; b: b;
		yourself
]

{ #category : #accessing }
SickFuck >> b [
	^ b
]

{ #category : #accessing }
SickFuck >> b: anObject [
	b := anObject
]

{ #category : #accessing }
SickFuck >> r [
	^ r
]

{ #category : #accessing }
SickFuck >> r: anObject [
	r := anObject
]

{ #category : #accessing }
SickFuck >> s [
	^ s
]

{ #category : #accessing }
SickFuck >> s: anObject [
	s := anObject
]

{ #category : #accessing }
SickFuck >> x [
	^ x
]

{ #category : #accessing }
SickFuck >> x: anObject [
	x := anObject
]
