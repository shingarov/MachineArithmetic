Class {
	#name : #EFun,
	#superclass : #'ΛExpression',
	#instVars : [
		'bind',
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
EFun class >> bind: b expr: e [
	^self basicNew 
		bind: b;
		expr: e;
		yourself 
]

{ #category : #'instance creation' }
EFun class >> mkEFun: binds expr: expr [
	^binds reversed inject: expr into: [ :e :b | self bind: b expr: e ]
]

{ #category : #accessing }
EFun >> bind [
	^ bind
]

{ #category : #accessing }
EFun >> bind: anObject [
	bind := anObject
]

{ #category : #verification }
EFun >> check: Γ rtype: f [
" 
      Γ, x:s ⊦ e <== t
      -------------------------- [Chk-Lam]
      Γ ⊦ λx.e <== x:s -> t
"
	| bx x e  y s t  c Γ1 |
	bx := bind. x := bx id. e := expr.
	y := f x. s := f s. t := f t.
	y = x ifFalse: [ ^super check: Γ rtype: f ].
	Γ1 := Γ extEnv: bx rtype: s.
	c := e check: Γ1 rtype: t.
	^s cAll: x cstr: c
]

{ #category : #accessing }
EFun >> expr [
	^ expr
]

{ #category : #accessing }
EFun >> expr: anObject [
	expr := anObject
]
