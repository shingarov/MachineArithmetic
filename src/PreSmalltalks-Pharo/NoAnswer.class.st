Class {
	#name : #NoAnswer,
	#superclass : #Error,
	#instVars : [
		'query'
	],
	#category : #'PreSmalltalks-Pharo'
}

{ #category : #signalling }
NoAnswer class >> signalFor: aQuery [
	^self new
		query: aQuery;
		signal
		
]

{ #category : #accessing }
NoAnswer >> messageText [
	^'No suitable default answer!'
]

{ #category : #accessing }
NoAnswer >> query [
	^ query
]

{ #category : #accessing }
NoAnswer >> query: anObject [
	query := anObject
]
