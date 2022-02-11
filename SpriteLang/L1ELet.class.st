Class {
	#name : #L1ELet,
	#superclass : #L1Expression,
	#instVars : [
		'decl',
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
L1ELet class >> decl: d expr: e [
	^self basicNew decl: d; expr: e; yourself
]

{ #category : #accessing }
L1ELet >> decl [
	^ decl
]

{ #category : #accessing }
L1ELet >> decl: anObject [
	decl := anObject
]

{ #category : #accessing }
L1ELet >> expr [
	^ expr
]

{ #category : #accessing }
L1ELet >> expr: anObject [
	expr := anObject
]
