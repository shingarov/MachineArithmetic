"
constraint-id which creates a dependency
"
Class {
	#name : #CstrVertex,
	#superclass : #CVertex,
	#instVars : [
		'id'
	],
	#category : #Refinements
}

{ #category : #accessing }
CstrVertex class >> id: anInteger [
	^self basicNew id: anInteger; yourself
]

{ #category : #comparing }
CstrVertex >> = anObject [
	self class == anObject class ifFalse: [ ^false ].
	^id = anObject id

]

{ #category : #comparing }
CstrVertex >> hash [
	^id hash
]

{ #category : #accessing }
CstrVertex >> id [
	^ id
]

{ #category : #accessing }
CstrVertex >> id: anObject [
	id := anObject
]

{ #category : #testing }
CstrVertex >> isCstr [
	^true
]

{ #category : #printing }
CstrVertex >> printOn: aStream [
	aStream nextPutAll: 'Cstr '.
	id printOn: aStream 
]
