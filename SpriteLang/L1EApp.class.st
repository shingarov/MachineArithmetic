Class {
	#name : #L1EApp,
	#superclass : #L1Expression,
	#instVars : [
		'expr',
		'imm'
	],
	#category : #SpriteLang
}

{ #category : #'as yet unclassified' }
L1EApp class >> expr: e imm: i [ 
	^ self basicNew 
		expr: e;
		imm: i;
		yourself
]

{ #category : #'as yet unclassified' }
L1EApp class >> mkEApp: f args: imms [ 
	^imms inject: f into: [ :fSoFar :thisArg | self expr: fSoFar imm: thisArg ]
]

{ #category : #accessing }
L1EApp >> expr [
	^ expr
]

{ #category : #accessing }
L1EApp >> expr: anObject [
	expr := anObject
]

{ #category : #accessing }
L1EApp >> imm [
	^ imm
]

{ #category : #accessing }
L1EApp >> imm: anObject [
	imm := anObject
]
