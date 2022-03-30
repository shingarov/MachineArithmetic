Class {
	#name : #TInt,
	#superclass : #'ΛBase',
	#classVars : [
		'instance'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
TInt class >> instance [ 
	instance isNil ifTrue: [ instance := self basicNew ].
	^instance
]

{ #category : #'instance creation' }
TInt class >> new [
	self shouldNotImplement
]

{ #category : #'as yet unclassified' }
TInt >> baseSort [
	^Int sort
]

{ #category : #printing }
TInt >> printOn: aStream [
	aStream nextPutAll: 'TInt'
]
