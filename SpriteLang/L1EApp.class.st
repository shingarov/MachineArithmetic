Class {
	#name : #L1EApp,
	#superclass : #L1Expression,
	#instVars : [
		'expr',
		'imm'
	],
	#category : #SpriteLang
}

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
