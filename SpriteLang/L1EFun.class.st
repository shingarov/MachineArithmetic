Class {
	#name : #L1EFun,
	#superclass : #L1Expression,
	#instVars : [
		'bind',
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #accessing }
L1EFun >> bind [
	^ bind
]

{ #category : #accessing }
L1EFun >> bind: anObject [
	bind := anObject
]

{ #category : #accessing }
L1EFun >> expr [
	^ expr
]

{ #category : #accessing }
L1EFun >> expr: anObject [
	expr := anObject
]
