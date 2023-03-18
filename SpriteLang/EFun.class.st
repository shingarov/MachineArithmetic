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
      Γ, x:s[y:=x] ⊦ e <== t[y:=x]
      ---------------------------- [Chk-Lam]
      Γ ⊦ λx.e <== y:s -> t
"
	| bx x e  y s t  s1 t1  Γ1  c |
	bx := bind. x := bx id. e := expr.
	(f isKindOf: TFun) ifFalse: [ ^super check: Γ rtype: f ].
	y := f x. s := f s. t := f t.

	s1 := s subst: y with: x.
	t1 := t subst: y with: x.
	
	Γ1 := Γ extEnv: x rtype: s1.
	c := e check: Γ1 rtype: t1.
	^s cAll: x cstr: c
]

{ #category : #polymorphism }
EFun >> elabC: Γ rtype: st [
	| b e s t e_ |
	(st isKindOf: TFun) ifFalse: [ self shouldBeImplemented. "what what?" ].
	b := bind. e := expr. s := st s. t := st t.
	e_ := e elabC: (Γ extEnv: b id rtype: s) rtype: t.
	^EFun bind: b expr: e_
]

{ #category : #accessing }
EFun >> expr [
	^ expr
]

{ #category : #accessing }
EFun >> expr: anObject [
	expr := anObject
]

{ #category : #'as yet unclassified' }
EFun >> goSubsTyExpr: su [ 
	^EFun bind: bind expr: (expr goSubsTyExpr: su)
]
