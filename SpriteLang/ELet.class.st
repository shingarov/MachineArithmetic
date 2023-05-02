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
	| x eAnn e s m e′ t Γ′ c c′ s′_m′ s′ m′ bs_tb_eb bs tb eb tlim |
	x := decl bind id.
	eAnn := decl expr.
	(eAnn isKindOf: EAnn) ifFalse: [ self error: 'should this be allowed???' ].
	e := eAnn expr. s := eAnn ann rtype. m := eAnn ann metric. e′ := expr.
	m isNil ifTrue: [ self error: 'Missing termination metric!' ].
	s′_m′ := e renameTy: s metric: m.  s′ := s′_m′ key. m′ := s′_m′ value.
	t := Γ fresh: s′.
	bs_tb_eb := t introEnv: e.  bs := bs_tb_eb first. tb := bs_tb_eb second. eb := bs_tb_eb third.
	Γ′ := bs inject: Γ into: [ :soFar :thisTime | soFar extEnv: thisTime key rtype: thisTime value ].
	tlim := t limit: m′ in: Γ.
	self halt.
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
	| x e1 s1 e2 Γ′ as___t1 as t1 e1′ e2′ |
	x := decl bind id.
	e1 := decl expr expr.
	s1 := decl expr ann rtype.
	e2 := expr.
	Γ′ := Γ extEnv: x rtype: s1.
	as___t1 := s1 bkAlls. as := as___t1 first.  t1 := as___t1 last.
	e1′ := e1 elabC: (Γ′ extEnvTVs: as) rtype: t1.
	e2′ := e2 elabC: Γ′ rtype: t2.
	^ELet
		decl: (SpriteRDecl
				bind: (SpriteBind identifier: x)
				expr: (EAnn expr: (e1′ mkTLam: as) ann: decl expr ann))
		expr: e2′
] ifFalse: [ "non-recursive Let"
	| x e1 e2 e1′ s e1__s e2′ |
	x := decl bind id.
	e1 := decl expr.
	e2 := expr.
	e1__s := e1 elabS: Γ.
	e1′ := e1__s first.  s := e1__s last.
	e2′ := e2 elabC: (Γ extEnv: x rtype: s) rtype: t2.
	^ELet decl: (SpriteDecl bind: (SpriteBind identifier: x) expr: e1′) expr: e2′
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
