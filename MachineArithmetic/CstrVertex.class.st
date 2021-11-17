Class {
	#name : #CstrVertex,
	#superclass : #CVertex,
	#instVars : [
		'id'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #accessing }
CstrVertex class >> id: anInteger [
	^self basicNew id: anInteger; yourself
]

{ #category : #accessing }
CstrVertex >> id [
	^ id
]

{ #category : #accessing }
CstrVertex >> id: anObject [
	id := anObject
]

{ #category : #printing }
CstrVertex >> printOn: aStream [
	aStream nextPutAll: 'id_'.
	id printOn: aStream 
]
