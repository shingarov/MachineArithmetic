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
	^ SpriteDecl bind: decl bind expr: (L1EAnn expr: decl expr rtype: ann rtype)
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
