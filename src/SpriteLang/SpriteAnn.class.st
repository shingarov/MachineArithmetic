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
		'rtype',
		'metric'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
SpriteAnn class >> new [
	self shouldNotImplement 
		
]

{ #category : #'instance creation' }
SpriteAnn class >> symbol: s rtype: r metric: m [
	^self basicNew 
		symbol: s;
		rtype: r;
		metric: m;
		yourself
		
]

{ #category : #'as yet unclassified' }
SpriteAnn >> genSig [
	^self class
		symbol: symbol
		rtype: rtype generalize
		metric: metric
]

{ #category : #'as yet unclassified' }
SpriteAnn >> goSubsTyExprS: su [
	^self class
		symbol: symbol
		rtype: (rtype subsTy: su)
		metric: metric
]

{ #category : #GT }
SpriteAnn >> gtBind [
	^''
]

{ #category : #GT }
SpriteAnn >> gtChildren [
	^ metric isNil ifTrue:[{ rtype }] ifFalse:[{rtype . metric }]
]

{ #category : #GT }
SpriteAnn >> gtExpr [
	^self
]

{ #category : #testing }
SpriteAnn >> isLet [
	^false
]

{ #category : #accessing }
SpriteAnn >> metric [
	^ metric
]

{ #category : #accessing }
SpriteAnn >> metric: anObject [
	metric := anObject
]

{ #category : #printing }
SpriteAnn >> printOn: aStream [
	aStream nextPutAll: self class name; space.
	symbol printOn: aStream.
	aStream nextPutAll: ' ...'
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
