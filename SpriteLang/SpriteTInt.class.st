Class {
	#name : #SpriteTInt,
	#superclass : #SpriteBase,
	#classVars : [
		'instance'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
SpriteTInt class >> instance [ 
	instance isNil ifTrue: [ instance := self basicNew ].
	^instance
]

{ #category : #'instance creation' }
SpriteTInt class >> new [
	self shouldNotImplement
]

{ #category : #printing }
SpriteTInt >> printOn: aStream [
	aStream nextPutAll: 'int'
]
