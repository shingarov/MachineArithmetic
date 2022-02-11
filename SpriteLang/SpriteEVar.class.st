Class {
	#name : #SpriteEVar,
	#superclass : #SpriteImm,
	#instVars : [
		'symbol'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
SpriteEVar class >> symbol: s [
	^self basicNew symbol: s; yourself 
]

{ #category : #accessing }
SpriteEVar >> symbol [
	^ symbol
]

{ #category : #accessing }
SpriteEVar >> symbol: anObject [
	symbol := anObject
]
