Class {
	#name : #SortedQuantifier,
	#superclass : #Object,
	#instVars : [
		'sort',
		'quantifier'
	],
	#category : #Refinements
}

{ #category : #accessing }
SortedQuantifier >> quantifier [
	^ quantifier
]

{ #category : #accessing }
SortedQuantifier >> quantifier: anObject [
	quantifier := anObject
]

{ #category : #accessing }
SortedQuantifier >> sort [
	^ sort
]

{ #category : #accessing }
SortedQuantifier >> sort: anObject [
	sort := anObject
]
