Class {
	#name : #L1EFun,
	#superclass : #L1Expression,
	#instVars : [
		'bind',
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
L1EFun class >> bind: b expr: e [
	^self basicNew 
		bind: b;
		expr: e;
		yourself 
]

{ #category : #'instance creation' }
L1EFun class >> mkEFun: binds expr: expr [
	^binds reversed inject: expr into: [ :e :b | self bind: b expr: e ]
]

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
