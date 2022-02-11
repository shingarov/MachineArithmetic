Class {
	#name : #SpriteTBase,
	#superclass : #SpriteRType,
	#instVars : [
		'b',
		'r'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
SpriteTBase class >> b: b r: r [
	^self basicNew
		b: b; r: r; yourself
]

{ #category : #accessing }
SpriteTBase >> b [
	^ b
]

{ #category : #accessing }
SpriteTBase >> b: anObject [
	b := anObject
]

{ #category : #printing }
SpriteTBase >> printOn: aStream [
	aStream nextPutAll: 'TBase '.
	b printOn: aStream.
	r isNil ifFalse: [ r printBracketedOn: aStream ]
]

{ #category : #accessing }
SpriteTBase >> r [
	^ r
]

{ #category : #accessing }
SpriteTBase >> r: anObject [
	r := anObject
]
