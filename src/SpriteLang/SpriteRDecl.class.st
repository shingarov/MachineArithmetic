Class {
	#name : #SpriteRDecl,
	#superclass : #SpriteDecl,
	#category : #SpriteLang
}

{ #category : #verification }
SpriteRDecl >> check: Γ rtype: t′ e′: e′ [
	| x e s m t Γ′ c c′ tx |
	self assert: (expr isKindOf: EAnn).
	x := bind id. e := expr expr. s := expr ann rtype. m := expr ann metric.
	"Either --check-termination is on, then ALL recursive functions need
	 a termination metric; or --check-termination is of, then NO function
	 can have a termination metric."
	self assert: m notNil = (Context readState: #checkTermination).
	m notNil ifTrue: [
		| s′_m′ |
		s′_m′ := e renameTy: s metric: m.
		s := s′_m′ key. m := s′_m′ value.
	].
	t := Γ fresh: s.
	
	m notNil ifTrue: [
"
   t := fresh(Γ, s) == forall a*. (y:s)* -> tb      e == \a*.\y*. eb
   Γ′ = Γ,a*,(y:s)*, x:lim(Γ, m, t) ⊦ eb <== tb    Γ, x:t ⊦ e′ <= t′
   -------------------------------------------------------------------[Chk-Rec]
   Γ ⊦ let rec x = (e : s / m) in e′ <= t′
"
		| bs_tb_eb bs tb eb tlim |
		bs_tb_eb := t introEnv: e.  bs := bs_tb_eb first. tb := bs_tb_eb second. eb := bs_tb_eb third.
		Γ′ := bs inject: Γ into: [ :soFar :thisTime | soFar extEnv: thisTime key rtype: thisTime value ].
		tlim := t limit: m in: Γ.
		c  := eb check: (Γ′ extEnv: x rtype: tlim) rtype: tb.
		tx := expr ann class reflect: x type: t expr: e.
		c′ := e′ check: (Γ′ extEnv: x rtype: tx) rtype: t′.
		^(c cAlls: bs) & c′
	] ifFalse: [
"
   t := fresh(s)    Γ; f:t ⊦ e <== t    Γ; f:t ⊦ e' <== t'
   -------------------------------------------------------[Chk-Rec]
   Γ ⊦ letrec f = (e:s) in e' <== t'
"
		Γ′ := Γ extEnv: x rtype: t.
		c  := e  check: Γ′ rtype: t.
		tx := expr ann class reflect: x type: t expr: e.
		c′ := e′ check: (Γ′ extEnv: x rtype: tx) rtype: t′.
		^c & c′
	]

]

{ #category : #polymorphism }
SpriteRDecl >> elabELet: e₂ rtype: t₂ in: Γ [
	"
	-- let rec x:s = e1 in e2
	elabC Γ (ELet (RDecl (Bind x l) (EAnn e1 s1 l1) ld) e2 l2) t2 = do
	  let Γ′ = extEnv g x s1
	  let (as, t1) = splitTAll s1 
	  e1'   <- elabC (extEnvTVs g' as) e1 t1
	  e2'   <- elabC g' e2 t2
	  return $ ELet (RDecl (Bind x l) (EAnn (mkTLam e1' as) s1 l1) ld) e2' l2
	"
	| x e₁ s₁ Γ′ as_t₁ as t₁ e₁′ e₂′ |
	x := bind id.
	e₁ := expr expr.
	s₁ := expr ann rtype.
	Γ′ := Γ extEnv: x rtype: s₁.
	as_t₁ := s₁ bkAlls.  as := as_t₁ first.  t₁ := as_t₁ last.
	e₁′ := e₁ elabC: (Γ′ extEnvTVs: as) rtype: t₁.
	e₂′ := e₂ elabC:  Γ′                rtype: t₂.
	^ELet
		decl: (SpriteRDecl
				bind: (SpriteBind identifier: x)
				expr: (EAnn expr: (e₁′ mkTLam: as) ann: expr ann))
		expr: e₂′
]

{ #category : #inlining }
SpriteRDecl >> inlineInto: e [
	^ELet decl: self expr: e
]

{ #category : #testing }
SpriteRDecl >> isRecursive [
	^ true
]
