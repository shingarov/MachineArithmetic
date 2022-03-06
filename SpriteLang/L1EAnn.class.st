Class {
	#name : #L1EAnn,
	#superclass : #L1Expression,
	#instVars : [
		'expr',
		'rtype'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
L1EAnn class >> expr: e rtype: t [ 
	^ self basicNew
		expr: e;
		rtype: t;
		yourself
]

{ #category : #accessing }
L1EAnn >> expr [
	^ expr
]

{ #category : #accessing }
L1EAnn >> expr: anObject [
	expr := anObject
]

{ #category : #accessing }
L1EAnn >> rtype [
	^ rtype
]

{ #category : #accessing }
L1EAnn >> rtype: anObject [
	rtype := anObject
]
