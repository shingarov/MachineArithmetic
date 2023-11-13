Class {
	#name : #SumDecoder,
	#superclass : #Object,
	#instVars : [
		'jsonReader'
	],
	#category : #MathNotation
}

{ #category : #accessing }
SumDecoder >> jsonReader [
	^ jsonReader
]

{ #category : #accessing }
SumDecoder >> jsonReader: anObject [
	jsonReader := anObject
]

{ #category : #API }
SumDecoder >> next [
	self subclassResponsibility
]
