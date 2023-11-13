Class {
	#name : #B,
	#superclass : #AorB,
	#instVars : [
		'i'
	],
	#category : #'MathNotation-Tests'
}

{ #category : #accessing }
B class >> defaultMetavarTyping [
	^{
	#i  -> Integer.
	}
]

{ #category : #accessing }
B >> i [
	^ i
]

{ #category : #accessing }
B >> i: anObject [
	i := anObject
]
