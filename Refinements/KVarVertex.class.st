"
real kvar vertex
"
Class {
	#name : #KVarVertex,
	#superclass : #CVertex,
	#instVars : [
		'kvar'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
KVarVertex class >> kvar: kvar [
	^self basicNew kvar: kvar; yourself
]

{ #category : #testing }
KVarVertex >> isKVar [
	^true
]

{ #category : #accessing }
KVarVertex >> kvar [
	^ kvar
]

{ #category : #accessing }
KVarVertex >> kvar: anObject [
	kvar := anObject
]

{ #category : #printing }
KVarVertex >> printOn: aStream [
	aStream nextPutAll: 'KVar $"'; nextPutAll: kvar; nextPutAll: '"'
]
