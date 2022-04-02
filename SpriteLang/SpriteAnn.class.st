Class {
	#name : #SpriteAnn,
	#superclass : #Object,
	#instVars : [
		'symbol',
		'rtype'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
SpriteAnn class >> new [
	self shouldNotImplement 
		
]

{ #category : #'instance creation' }
SpriteAnn class >> symbol: s rtype: r [
	^self basicNew 
		symbol: s;
		rtype: r;
		yourself
		
]

{ #category : #accessing }
SpriteAnn >> rtype [
	^ rtype
]

{ #category : #accessing }
SpriteAnn >> rtype: anObject [
	rtype := anObject
]

{ #category : #accessing }
SpriteAnn >> symbol [
	^ symbol
]

{ #category : #accessing }
SpriteAnn >> symbol: anObject [
	symbol := anObject
]
