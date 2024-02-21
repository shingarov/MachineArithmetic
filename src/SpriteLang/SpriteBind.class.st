Class {
	#name : #SpriteBind,
	#superclass : #Object,
	#instVars : [
		'id'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
SpriteBind class >> id: id [
	^self basicNew id: id; yourself
]

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
		nextPutAll: 'Bind "';
		nextPutAll: id;
		nextPutAll: '"'
]

{ #category : #'α-renaming' }
SpriteBind >> uniq2: α [
	^self class id: (α at: id ifAbsent:[id])
]
