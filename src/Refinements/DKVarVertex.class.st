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

{ #category : #comparing }
DKVarVertex >> = anObject [
	self class == anObject class ifFalse: [ ^false ].
	^kvar = anObject kvar
]

{ #category : #comparing }
DKVarVertex >> hash [
	^kvar hash
]

{ #category : #accessing }
DKVarVertex >> kvar [
	^ kvar
]

{ #category : #accessing }
DKVarVertex >> kvar: anObject [
	kvar := anObject
]

{ #category : #printing }
DKVarVertex >> printOn: aStream [
	aStream
		nextPutAll: 'DKVar $"';
		nextPutAll: kvar;
		nextPutAll: '"'
]
