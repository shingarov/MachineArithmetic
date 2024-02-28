Class {
	#name : #SpriteRDecl,
	#superclass : #SpriteDecl,
	#category : #SpriteLang
}

{ #category : #verification }
SpriteRDecl >> check: Γ rtype: t′ e′: e′ [
	| checkTermination |
	(expr isKindOf: EAnn) ifFalse: [ self error ].
	checkTermination := Context readState: #checkTermination.
	^checkTermination
		ifTrue:  [ self checkT:  Γ rtype: t′ e′: e′ ]
		ifFalse: [ self checkNT: Γ rtype: t′ e′: e′ ]

]

{ #category : #verification }
SpriteRDecl >> checkNT: Γ rtype: t′ e′: e′ [
"
   t := fresh(s)    Γ; f:t ⊦ e <== t    Γ; f:t ⊦ e' <== t'
   -------------------------------------------------------[Chk-Rec]
   Γ ⊦ letrec f = (e:s) in e' <== t'
"
	| x e s t Γ′ c c′ |
	expr ann metric isNil ifFalse: [ self error: 'Cant have termination metric without --check-termination' ].
	x := bind id.
	e := expr expr. s := expr ann rtype.
	t := Γ fresh: s.
	Γ′ := Γ extEnv: x rtype: t.
	c  := e  check: Γ′ rtype: t.
	c′ := e′ check: Γ′ rtype: t′.
	^c & c′
]

{ #category : #verification }
SpriteRDecl >> checkT: Γ rtype: t′ e′: e′ [
"
   t := fresh(G, s) == forall a*. (y:s)* -> tb      e == \a*.\y*. eb
   Γ′ = Γ,a*,(y:s)*, x:lim(Γ, m, t) ⊦ eb <== tb    Γ, x:t ⊦ e′ <= t′
   -------------------------------------------------------------------[Chk-Rec]
   Γ ⊦ let rec x = (e : s / m) in e′ <= t′
"
	| x e s m t Γ′ c c′ s′_m′ s′ m′ bs_tb_eb bs tb eb tlim tx |
	x := bind id.
	e := expr expr. s := expr ann rtype. m := expr ann metric.
	m isNil ifTrue: [ self error: 'Missing termination metric!' ].
	s′_m′ := e renameTy: s metric: m.  s′ := s′_m′ key. m′ := s′_m′ value.
	t := Γ fresh: s′.
	bs_tb_eb := t introEnv: e.  bs := bs_tb_eb first. tb := bs_tb_eb second. eb := bs_tb_eb third.
	Γ′ := bs inject: Γ into: [ :soFar :thisTime | soFar extEnv: thisTime key rtype: thisTime value ].
	tlim := t limit: m′ in: Γ.
	c  := eb check: (Γ′ extEnv: x rtype: tlim) rtype: tb.
	tx := expr ann class reflect: x type: t expr: e.
	c′ := e′ check: (Γ′ extEnv: x rtype: tx) rtype: t′.
	^(c cAlls: bs) & c′
]
