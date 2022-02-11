Class {
	#name : #SpriteBind,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
SpriteBind class >> identifier: id [
	^self basicNew id: id; yourself
]

{ #category : #accessing }
SpriteBind >> id [
	^ id
]

{ #category : #accessing }
SpriteBind >> id: anObject [
	id := anObject
]

{ #category : #printing }
SpriteBind >> printOn: aStream [
	aStream
		nextPutAll: 'Bind[';
		nextPutAll: id;
		nextPutAll: ']'
]
