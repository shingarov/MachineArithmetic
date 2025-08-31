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

{ #category : #inlining }
SpriteRDecl >> inlineInto: e [
	^ELet decl: self expr: e
]

{ #category : #testing }
SpriteRDecl >> isRecursive [
	^ true
]
