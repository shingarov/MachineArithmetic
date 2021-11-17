Class {
	#name : #SortedQuantifier,
	#superclass : #Object,
	#instVars : [
		'sort',
		'quantifier'
	],
	#category : #'MachineArithmetic-Refinement'
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
