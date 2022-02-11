Class {
	#name : #SpriteTFun,
	#superclass : #SpriteRType,
	#instVars : [
		'x',
		's',
		't'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
SpriteTFun class >> x: x s: s t: t [
	^self basicNew
		x: x; s: s; t: t; yourself 
]

{ #category : #printing }
SpriteTFun >> printOn: aStream [
	aStream
			nextPutAll: 'TFun ';
			nextPutAll: x;
			nextPutAll: ': '.
	s printOn: aStream.
	aStream nextPutAll: '=>'.
	t printOn: aStream.
	

]

{ #category : #accessing }
SpriteTFun >> s [
	^ s
]

{ #category : #accessing }
SpriteTFun >> s: anObject [
	s := anObject
]

{ #category : #accessing }
SpriteTFun >> t [
	^ t
]

{ #category : #accessing }
SpriteTFun >> t: anObject [
	t := anObject
]

{ #category : #accessing }
SpriteTFun >> x [
	^ x
]

{ #category : #accessing }
SpriteTFun >> x: anObject [
	x := anObject
]
