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
ELet >> check: Γ rtype: t_ [
(decl isKindOf: SpriteRDecl) "TODO: properly dispatch"
ifFalse: [
" 
      Γ ⊦ e ==> s        Γ, x:s ⊦ e' <== t'
      ------------------------------------------- [Chk-Let]
          Γ ⊦ let x = e in e' <== t'
"
	| x e   e_   c_s c s Γ1 c1 |
	x := decl bind id. e := decl expr. e_ := expr.
	c_s := e synth: Γ. c := c_s first. s := c_s last.
	Γ1 := Γ extEnv: x rtype: s.
	c1 := e_ check: Γ1 rtype: t_.
	^c & (s cAll: x cstr: c1)
] ifTrue: [
"
   t := fresh(s)    Γ; f:t ⊦ e <== t    Γ; f:t ⊦ e' <== t'
   -------------------------------------------------------[Chk-Rec]
   Γ ⊦ letrec f = (e:s) in e' <== t'
"
	| x eAnn e s e_ t Γ1 c c_ |
	x := decl bind id.
	eAnn := decl expr.
	(eAnn isKindOf: EAnn) ifFalse: [ self error: 'should this be allowed???' ].
	e := eAnn expr. s := eAnn rtype. e_ := expr.
	t := Γ fresh: s.
	Γ1 := Γ extEnv: x rtype: t.
	c  := e  check: Γ1 rtype: t.
	c_ := e_ check: Γ1 rtype: t_.
	^c & c_
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
	| x e1 s1 e2 g_ as_t1 as t1 e1_ e2_ |
	x := decl bind id.
	e1 := decl expr expr.
	s1 := decl expr rtype.
	e2 := expr.
	g_ := Γ extEnv: x rtype: s1.
	as_t1 := s1 splitTAll.
	as := as_t1 first.  t1 := as_t1 last.
	e1_ := e1 elabC: (g_ extEnvTVs: as) rtype: t1.
	e2_ := e2 elabC: g_ rtype: t2.
	^ELet
		decl: (SpriteRDecl
				bind: (SpriteBind identifier: x)
				expr: (EAnn expr: (e1_ mkTLam: as) rtype: s1))
		expr: e2_
] ifFalse: [
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
