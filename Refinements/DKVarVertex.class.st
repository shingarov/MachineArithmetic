"
dummy to ensure each kvar has a successor
"
Class {
	#name : #DKVarVertex,
	#superclass : #CVertex,
	#instVars : [
		'kvar'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
DKVarVertex class >> kvar: kvar [
	^self basicNew kvar: kvar; yourself
]

{ #category : #accessing }
DKVarVertex >> kvar [
	^ kvar
]

{ #category : #accessing }
DKVarVertex >> kvar: anObject [
	kvar := anObject
]
