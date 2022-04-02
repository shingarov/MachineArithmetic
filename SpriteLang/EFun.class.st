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
      Γ, x:s[y:=x] ⊦ e <== t
      -------------------------- [Chk-Lam]
      Γ ⊦ λx.e <== x:s -> t
"
	| bx x e  y s t  s1 t1  Γ1  c |
	bx := bind. x := bx id. e := expr.
	(f isKindOf: TFun) ifFalse: [ super shouldBeImplemented "what what?" ].
	y := f x. s := f s. t := f t.
	s1 := s subst1: (FxEVar of: y) for: x.
	t1 := t subst1: (FxEVar of: y) for: x.
	
	Γ1 := Γ extEnv: x rtype: s1.
	c := e check: Γ1 rtype: t1.
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
