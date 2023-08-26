"
I represent a contract annotation.

In SpriteLang, the shape differs between L₆ and L₈.

In L₆ where contract annotations come in one form, 'val', Ann is
	type Ann = Maybe (F.Symbol, RType)

In L₈ an annotation can be either 'val' or 'reflect';
so Ann is just a marker to differentiate, and the actual data is in Sig:
	type Sig = (F.Symbol, RType, Maybe Metric)
	data Ann = Val | Refl deriving (Show)

In Smalltalk we use subclasses as the differentiator.
"
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
