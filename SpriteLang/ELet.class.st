Class {
	#name : #ELet,
	#superclass : #'ΛExpression',
	#instVars : [
		'decl',
		'expr'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
ELet class >> decl: d expr: e [
	^self basicNew decl: d; expr: e; yourself
]

{ #category : #verification }
ELet >> check: Γ rtype: t′ [
(decl isKindOf: SpriteRDecl) "TODO: properly dispatch"
ifFalse: [
" 
      Γ ⊦ e ==> s        Γ, x:s ⊦ e' <== t'
      ------------------------------------------- [Chk-Let]
          Γ ⊦ let x = e in e' <== t'
"
	| x e   e′   c_s c s Γ′ c′ |
	x := decl bind id. e := decl expr. e′ := expr.
	c_s := e synth: Γ. c := c_s first. s := c_s last.
	Γ′ := Γ extEnv: x rtype: s.
	c′ := e′ check: Γ′ rtype: t′.
	^c & (s cAll: x cstr: c′)
] ifTrue: [
"
   t := fresh(s)    Γ; f:t ⊦ e <== t    Γ; f:t ⊦ e' <== t'
   -------------------------------------------------------[Chk-Rec]
   Γ ⊦ letrec f = (e:s) in e' <== t'
"
	| x eAnn e s e′ t Γ′ c c′ |
	x := decl bind id.
	eAnn := decl expr.
	(eAnn isKindOf: EAnn) ifFalse: [ self error: 'should this be allowed???' ].
	e := eAnn expr. s := eAnn rtype. e′ := expr.
	t := Γ fresh: s.
	Γ′ := Γ extEnv: x rtype: t.
	c  := e  check: Γ′ rtype: t.
	c′ := e′ check: Γ′ rtype: t′.
	^c & c′
]
]

{ #category : #accessing }
ELet >> decl [
	^ decl
]

{ #category : #accessing }
ELet >> decl: anObject [
	decl := anObject
]

{ #category : #polymorphism }
ELet >> elabC: Γ rtype: t2 [
(decl isKindOf: SpriteRDecl) "TODO: proper dispatch"
ifTrue: [
	| x e1 s1 e2 g_ as___t1 as t1 e1_ e2_ |
	x := decl bind id.
	e1 := decl expr expr.
	s1 := decl expr rtype.
	e2 := expr.
	g_ := Γ extEnv: x rtype: s1.
	as___t1 := s1 bkAlls. as := as___t1 first.  t1 := as___t1 last.
	e1_ := e1 elabC: (g_ extEnvTVs: as) rtype: t1.
	e2_ := e2 elabC: g_ rtype: t2.
	^ELet
		decl: (SpriteRDecl
				bind: (SpriteBind identifier: x)
				expr: (EAnn expr: (e1_ mkTLam: as) rtype: s1))
		expr: e2_
] ifFalse: [ "non-recursive Let"
	| x e1 e2 e1_ s e1__s e2_ |
	x := decl bind id.
	e1 := decl expr.
	e2 := expr.
	e1__s := e1 elabS: Γ.
	e1_ := e1__s first.  s := e1__s last.
	e2_ := e2 elabC: (Γ extEnv: x rtype: s) rtype: t2.
	^ELet decl: (SpriteDecl bind: (SpriteBind identifier: x) expr: e1_) expr: e2_
]
]

{ #category : #accessing }
ELet >> expr [
	^ expr
]

{ #category : #accessing }
ELet >> expr: anObject [
	expr := anObject
]

{ #category : #'as yet unclassified' }
ELet >> goSubsTyExpr: su [
	| d_ |
	d_ := decl subsTy: su.
	^ELet decl: d_ expr: (expr goSubsTyExpr: su)
]

{ #category : #GT }
ELet >> gtChildren [
	^{decl . expr}
]
