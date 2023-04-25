Class {
	#name : #SpriteDecl,
	#superclass : #Object,
	#instVars : [
		'bind',
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
SpriteDecl class >> bind: b expr: e [
	^self basicNew 
		bind: b;
		expr: e;
		yourself
]

{ #category : #'instance creation' }
SpriteDecl class >> mkDecl: decl ann: ann [
	ann isNil ifTrue: [ ^decl ].
	ann symbol = decl bind id ifFalse: [ self error: 'bad annotation' ].
	^ self bind: decl bind expr: (EAnn expr: decl expr rtype: ann rtype generalize)
]

{ #category : #accessing }
SpriteDecl >> bind [
	^ bind
]

{ #category : #accessing }
SpriteDecl >> bind: anObject [
	bind := anObject
]

{ #category : #accessing }
SpriteDecl >> expr [
	^ expr
]

{ #category : #accessing }
SpriteDecl >> expr: anObject [
	expr := anObject
]

{ #category : #GT }
SpriteDecl >> gtChildren [ 
	^{expr}
]

{ #category : #printing }
SpriteDecl >> printOn: aStream [
	self printStructOn: aStream
]

{ #category : #'as yet unclassified' }
SpriteDecl >> subsTy: su [ 
	^self class bind: bind expr: (expr subsTy: su)
]
