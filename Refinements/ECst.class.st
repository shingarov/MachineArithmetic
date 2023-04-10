Class {
	#name : #ECst,
	#superclass : #Expr,
	#instVars : [
		'expr',
		'sort'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
ECst class >> eAppC: s e1: e1 e2: e2 [
"
eAppC :: Sort -> Expr -> Expr -> Expr
"
	^self expr: (EApp expr: e1 imm: e2) sort: s
]

{ #category : #'instance creation' }
ECst class >> expr: e sort: s [
	^self basicNew
		expr: e;
		sort: s;
		yourself
]

{ #category : #accessing }
ECst >> expr [
	^ expr
]

{ #category : #accessing }
ECst >> expr: anObject [
	expr := anObject
]

{ #category : #accessing }
ECst >> sort [
	^ sort
]

{ #category : #accessing }
ECst >> sort: anObject [
	sort := anObject
]
