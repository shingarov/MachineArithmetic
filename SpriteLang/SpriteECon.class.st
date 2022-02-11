Class {
	#name : #SpriteECon,
	#superclass : #SpriteImm,
	#instVars : [
		'prim'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
SpriteECon class >> prim: aPrim [
	^self basicNew prim: aPrim; yourself 
]

{ #category : #accessing }
SpriteECon >> prim [
	^ prim
]

{ #category : #accessing }
SpriteECon >> prim: anObject [
	prim := anObject
]
