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
	| bx x x′ e e′ y s t  s1 t1  Γ′  c |
	bx := bind. x := bx id. e := expr.
	(f isKindOf: TFun) ifFalse: [ ^super check: Γ rtype: f ].
	
	y := f x. s := f s. t := f t.
	x′ := x spriteλuniquify.
	e′ := e rename: x to: x′.
	s1 := s subst: y with: x′.
	t1 := t subst: y with: x′.
	
	Γ′ := Γ extEnv: x′ rtype: s1.
	c := e′ check: Γ′ rtype: t1.
	^s cAll: x′ cstr: c
]

{ #category : #polymorphism }
EFun >> elabC: Γ rtype: st [
	| b e s t e′ |
	(st isKindOf: TFun) ifFalse: [ self shouldBeImplemented. "what what?" ].
	b := bind. e := expr. s := st s. t := st t.
	e′ := e elabC: (Γ extEnv: b id rtype: s) rtype: t.
	^EFun bind: b expr: e′
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

{ #category : #GT }
EFun >> gtChildren [
	^expr gtChildren
]

{ #category : #'α-renaming' }
EFun >> rename: a to: b [
	^self class
		bind: (bind rename: a to: b)
		expr: (expr rename: a to: b)
]

{ #category : #'as yet unclassified' }
EFun >> renameTy: ty metric: m [
	| x y s′ t′ t′′_m′ t′′ m′ |
	(ty isKindOf: TFun) ifFalse: [ ^super renameTy: ty metric: m ].
	x := bind id. y:= ty x.
	s′ := ty s subst: y _: x.
	t′ := ty t subst: y _: x.
	t′′_m′ := expr renameTy: t′ metric: m.  t′′ := t′′_m′ key. m′ := t′′_m′ value.
	^(TFun x: x s: s′ t: t′′) -> m′
]
