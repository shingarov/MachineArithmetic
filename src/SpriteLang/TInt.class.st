Class {
	#name : #TInt,
	#superclass : #'ΛBase',
	#classInstVars : [
		'instance'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
TInt class >> instance [ 
	instance isNil ifTrue: [ instance := self basicNew ].
	^instance
]

{ #category : #'as yet unclassified' }
TInt >> baseSort [
	^Int sort
]

{ #category : #printing }
TInt >> printOn: aStream [
	aStream nextPutAll: 'TInt'
]
