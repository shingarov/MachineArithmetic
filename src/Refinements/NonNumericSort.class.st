Class {
	#name : #NonNumericSort,
	#superclass : #Error,
	#instVars : [
		'sort'
	],
	#category : #Refinements
}

{ #category : #signalling }
NonNumericSort class >> signalForSort: s [
	^self new 
		sort: s;
		signal
]

{ #category : #accessing }
NonNumericSort >> messageText [
	^'Sort is not numeric: ', sort printString
]

{ #category : #accessing }
NonNumericSort >> sort [
	^ sort
]

{ #category : #accessing }
NonNumericSort >> sort: anObject [
	sort := anObject
]
