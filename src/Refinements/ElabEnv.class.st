"
type ElabEnv  = (SymEnv, Env)

cf. SortCheck.hs
"
Class {
	#name : #ElabEnv,
	#superclass : #Object,
	#instVars : [
		'senv',
		'env'
	],
	#category : #'Refinements-SortCheck'
}

{ #category : #'instance creation' }
ElabEnv class >> new [
	self shouldNotImplement
	
]

{ #category : #'instance creation' }
ElabEnv class >> symEnv: se env: e [
	^self basicNew
		senv: se;
		env: e;
		yourself
	
]

{ #category : #elaboration }
ElabEnv >> elabApp: g to: e as: t [
"
-- DUPLICATION with `checkApp'`
elabAppAs :: ElabEnv -> Sort -> Expr -> Expr -> CheckM Expr
            env@(_,f)    t       g       e
"
	| f gT eT iT_oT_isu iT oT isu ge su tg g′ te e′ |
	f := self env.
	gT := g checkExpr: f.
	eT := e checkExpr: f.
	iT_oT_isu := gT checkFunSort.
	iT := iT_oT_isu first. oT := iT_oT_isu second. isu := iT_oT_isu third.
	ge := EApp fun: g imm: e.
	su := f unifyMany: ge tvSubst: isu sorts: {oT.iT} sorts: {t.eT}.
	tg := su applyTo: gT.
	g′ := g elabAs: tg inElabEnv: self.
	"Smalltalk: hotel" (g′ isKindOf: EVar) ifTrue: [ self note: g′ sym instantiatedTo: tg ].
	te := su applyTo: eT.
	e′ := e elabAs: te inElabEnv: self.
	^EApp
		fun: (ECst e: g′ sort: tg)
		imm: (ECst e: e′ sort: te)
]

{ #category : #elaboration }
ElabEnv >> elabAppSort: e₁ _: e₂ _: s₁ _: s₂ [
"
elabAppSort :: Env -> Expr -> Expr -> Sort -> Sort -> CheckM (Expr, Expr, Sort, Sort, Sort)
               self    e₁      e₂      s1      s2
"
	| sIn_sOut_su sIn sOut su su′
	  e₁′ e₂′ s₁′ s₂′ sOut′       |

	"e1 is the function we are applying"
	sIn_sOut_su := s₁ checkFunSort. sIn := sIn_sOut_su first. sOut := sIn_sOut_su second. su := sIn_sOut_su third.
	su′ := env unify1: (EApp fun: e₁ imm: e₂) tvSubst: su sort: sIn sort: s₂.
	e₁′   := e₁ applyExpr: su′.
	e₂′   := e₂ applyExpr: su′.
	s₁′   := su′ applyTo: s₁.
	s₂′   := su′ applyTo: s₂.
	sOut′ := su′ applyTo: sOut.
	^{ e₁′. e₂′. s₁′. s₂′. sOut′ }
	
]

{ #category : #elaboration }
ElabEnv >> elabEApp: e₁ _: e₂ [
"
elabEApp  :: ElabEnv -> Expr -> Expr -> CheckM (Expr, Sort, Expr, Sort, Sort)
               γ         e₁      e₂              e₁′′  s₁′   e₂′′  s₂′   s
"
	| e₁′_s₁ e₂′_s₂ e₁′ s₁ e₂′ s₂    e₁′′_e₂′′_s₁′_s₂′_s  e₁′′ e₂′′ s₁′ s₂′ s |
	e₁′_s₁ := e₁ elab: self. e₁′ := e₁′_s₁ first. s₁ := e₁′_s₁ last.
	e₂′_s₂ := e₂ elab: self. e₂′ := e₂′_s₂ first. s₂ := e₂′_s₂ last.
	
	e₁′′_e₂′′_s₁′_s₂′_s := self elabAppSort: e₁′ _: e₂′ _: s₁ _: s₂.
	e₁′′ := e₁′′_e₂′′_s₁′_s₂′_s first.
	e₂′′ := e₁′′_e₂′′_s₁′_s₂′_s second.
	s₁′  := e₁′′_e₂′′_s₁′_s₂′_s third.
	s₂′  := e₁′′_e₂′′_s₁′_s₂′_s fourth.
	s    := e₁′′_e₂′′_s₁′_s₂′_s fifth.
	^{e₁′′. s₁′. e₂′′. s₂′. s}
]

{ #category : #accessing }
ElabEnv >> env [
	^ env
]

{ #category : #accessing }
ElabEnv >> env: anObject [
	env := anObject
]

{ #category : #elaboration }
ElabEnv >> note: functionName instantiatedTo: aConcretePreSort [
	(senv naturalTransformationFor: functionName) addComponent: aConcretePreSort in: senv
]

{ #category : #accessing }
ElabEnv >> senv [
	^ senv
]

{ #category : #accessing }
ElabEnv >> senv: anObject [
	senv := anObject
]
