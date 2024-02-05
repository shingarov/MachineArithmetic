Class {
	#name : #Cosa,
	#superclass : #PureFormula,
	#instVars : [
		'varName'
	],
	#category : #CardanoTartaglia
}

{ #category : #printing }
Cosa class >> description [
	"Subclasses are encouraged to override this."
	^''
]

{ #category : #'instance creation' }
Cosa class >> named: x [
	^self basicNew
		varName: x;
		yourself
]

{ #category : #comparing }
Cosa >> isConstantNamed: aString [
	^varName = aString
]

{ #category : #printing }
Cosa >> printOn: aStream [
	aStream nextPutAll: 'dummy ', self class description, ' ', varName
]

{ #category : #accessing }
Cosa >> varName [
	^ varName
]

{ #category : #accessing }
Cosa >> varName: anObject [
	varName := anObject
]
