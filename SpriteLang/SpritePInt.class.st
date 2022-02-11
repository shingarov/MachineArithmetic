Class {
	#name : #SpritePInt,
	#superclass : #SpritePrim,
	#instVars : [
		'integer'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
SpritePInt class >> integer: integer [
	^self basicNew integer: integer; yourself 
]

{ #category : #accessing }
SpritePInt >> integer [
	^ integer
]

{ #category : #accessing }
SpritePInt >> integer: anObject [
	integer := anObject
]
