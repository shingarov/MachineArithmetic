Class {
	#name : #A,
	#superclass : #AorB,
	#instVars : [
		's'
	],
	#category : #'MathNotation-Tests'
}

{ #category : #accessing }
A class >> instVarTyping [
	^{
	#s  -> String.
	}
]

{ #category : #accessing }
A >> s [
	^ s
]

{ #category : #accessing }
A >> s: anObject [
	s := anObject
]
