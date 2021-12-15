Class {
	#name : #Elims,
	#superclass : #Object,
	#instVars : [
		'depCuts',
		'depNonCuts'
	],
	#category : #Refinements
}

{ #category : #accessing }
Elims >> depCuts [
	^ depCuts
]

{ #category : #accessing }
Elims >> depCuts: anObject [
	depCuts := anObject
]

{ #category : #accessing }
Elims >> depNonCuts [
	^ depNonCuts
]

{ #category : #accessing }
Elims >> depNonCuts: anObject [
	depNonCuts := anObject
]
