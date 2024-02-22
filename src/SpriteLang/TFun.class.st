Class {
	#name : #TFun,
	#superclass : #RType,
	#instVars : [
		'x',
		's',
		't'
	],
	#category : #SpriteLang
}

{ #category : #'instance creation' }
TFun class >> x: x s: s t: t [
	^self basicNew
		x: x; s: s; t: t; yourself 
]

{ #category : #'refinement abstraction' }
TFun >> bkFun [
"
bkFun (TFun x s t) = ((x, s) : ins, out) where (ins, out) = bkFun t
"
	| ins_out ins out |
	ins_out := t bkFun. ins := ins_out key. out := ins_out value.
	^{x->s}, ins -> out
]

{ #category : #Functor }
TFun >> collect: f [
	^TFun
		x: x
		s: f ⊛ s
		t: f ⊛ t
]

{ #category : #'as yet unclassified' }
TFun >> freeTVarsGo [
	^s freeTVarsGo union: t freeTVarsGo
]

{ #category : #'as yet unclassified' }
TFun >> fresh: Γ [
	| s1 t1 Γ1 |
	s1 := s fresh: Γ.
	Γ1 := Γ extEnv: x rtype: s.
	t1 := t fresh: Γ1.
	^TFun x: x s: s1 t: t1
]

{ #category : #'as yet unclassified' }
TFun >> goRefresh [
"
go (TFun  b s t) = TFun  b (go s) (go t)
"
	self shouldBeImplemented 
]

{ #category : #GT }
TFun >> gtChildren [
	^{ s . t }
]

{ #category : #'as yet unclassified' }
TFun >> introEnvGo: bs expr: rhs [
	(rhs isKindOf: EFun) ifFalse: [ ^super introEnvGo: bs expr: rhs ].
	^t introEnvGo: {x->s}, bs expr: rhs expr
]

{ #category : #'as yet unclassified' }
TFun >> lim: mO _: m in: γ [
	| x′ m′ t′ s′ |
	x′ := x suffixSymbol: 'next'.
	m′ := m subst: x _: x′.
	t′ := t subst: x _: x′.
	
	^(s isBase and: [ mO wfMetric: (γ extEnv: x rtype: s) ]) ifTrue: [
		s′ := (s subst: x _: x′) strengthenTop: (KnownReft
				symbol: x′
				expr: (HReft expr: (mO wfr: m′))).
		TFun x: x′ s: s′ t: t′
	] ifFalse: [
		| t′′ |
		s′ := s subst: x _: x′.
		t′′ := t′ lim: mO _: m′ in: (γ extEnv: x rtype: s) .
		TFun x: x′ s: s′ t: t′′
	]
]

{ #category : #printing }
TFun >> printOn: aStream [
	aStream
			nextPutAll: 'TFun ';
			nextPutAll: x;
			nextPutAll: ': '.
	s printOn: aStream.
	aStream nextPutAll: '=>'.
	t printOn: aStream.
	

]

{ #category : #private }
TFun >> rTypeSortFun_go: ts [
"
  rTypeSortFun :: RType -> F.Sort
  rTypeSortFun = F.mkFFunc 0 . fmap rTypeSort . go []
    where
      go ts (TFun _ t1 t2) = go (t1:ts) t2   ← we are here
      go ts t              = reverse (t:ts)
"
	| t1 t2 |
	t1 := s.  t2 := t.
	^t2 rTypeSortFun_go: {t1}, ts
]

{ #category : #prelude }
TFun >> rebind [
	| x1 s1 t1 |
	x1 := 'specº', x.
	s1 := s rebind subst: x with: x1.
	t1 := t rebind subst: x with: x1.
	^TFun x: x1 s: s1 t: t1
]

{ #category : #'as yet unclassified' }
TFun >> refactorAppR: anEvalEnv [
	| amendedEnv |
	amendedEnv := anEvalEnv,
		(EvalEnv constants: {x -> (DummyArg named: x)} asDictionary).
	^TFun
		x: x
		s: (s refactorAppR: amendedEnv)
		t: (t refactorAppR: amendedEnv)
]

{ #category : #'α-renaming' }
TFun >> rename: a to: b [
	^self
]

{ #category : #'as yet unclassified' }
TFun >> rtypeSort [
	^self sort "TODO: figure out the difference?"
]

{ #category : #accessing }
TFun >> s [
	^ s
]

{ #category : #accessing }
TFun >> s: anObject [
	s := anObject
]

{ #category : #'as yet unclassified' }
TFun >> sort [
"
  rTypeSortFun :: RType -> F.Sort
  rTypeSortFun = F.mkFFunc 0 . fmap rTypeSort . go []
    where
      go ts (TFun _ t1 t2) = go (t1:ts) t2
      go ts t              = reverse (t:ts)
"
	| outsideGoResult sorts |
	outsideGoResult := self rTypeSortFun_go: #().
	sorts := outsideGoResult collect: #sort. "← fmap rTypeSort"
	^Z3Sort mkFFunc: 0 sorts: sorts
]

{ #category : #polymorphism }
TFun >> strengthenTop: _r [
	^self
]

{ #category : #SubARef }
TFun >> subsAR: p ar: ar [ 
	"bogus -- see Issue 62"
	^TFun
		x: x
		s: (s subsAR: p ar: ar)
		t: (t subsAR: p ar: ar)
]

{ #category : #'as yet unclassified' }
TFun >> subsTy: su [
	| s_ t_ |
	s_ := s subsTy: su.
	t_ := t subsTy: su. 
	^TFun x: x s: s_ t: t_
]

{ #category : #'F.Subable' }
TFun >> subst: f [
	"subst f (TFun x s t)  = TFun  x (F.subst f s) (F.subst f t)"
	^TFun x: x s: (s subst: f) t: (t subst: f)
]

{ #category : #'F.Subable' }
TFun >> substa: f [
	"substa f (TFun x s t)  = TFun x  (F.substa f s) (F.substa f t)"
	^TFun x: x s: (s substa: f) t: (t substa: f)
]

{ #category : #'F.Subable' }
TFun >> substf: f [
	"substf f (TFun x s t)  = TFun  x (F.substf f s) (F.substf f t)"
	^TFun x: x s: (s substf: f) t: (t substf: f)
]

{ #category : #'F.Subable' }
TFun >> syms [
	"syms (TFun _ s t)    = F.syms s ++ F.syms t"
	^s syms, t syms
]

{ #category : #accessing }
TFun >> t [
	^ t
]

{ #category : #accessing }
TFun >> t: anObject [
	t := anObject
]

{ #category : #polymorphism }
TFun >> tsubstGo: ty tVar: a [
	^TFun
		x: x
		s: (s tsubstGo: ty tVar: a)
		t: (t tsubstGo: ty tVar: a)
]

{ #category : #polymorphism }
TFun >> unifyLL: tfun2 [
	| x_ s_ t1_ t2_ t_ |
	x_ := x unifyX: tfun2 x.
	s_ := s unify: tfun2 s.
	t1_ := t subsTyM.
	t2_ := tfun2 t subsTyM.
	t_ := t1_ unify: t2_.
	^TFun x: x_ s: s_ t: t_
]

{ #category : #accessing }
TFun >> x [
	^ x
]

{ #category : #accessing }
TFun >> x: anObject [
	x := anObject
]

{ #category : #'as yet unclassified' }
TFun >> ≺ [ rhs
"
[Sub-Fun]  
       
       (v::t) => q[w := v]
       -------------------
       b{v:p} <: b{w:q}
  
      s2 <: s1    x2:s2 |- t1[x1:=x2] <: t2 
      -------------------------------------
      x1:s1 -> t1 <: x2:s2 -> t2
"
	| x2 s2 t2 t1_ cI cO |
	(rhs isKindOf: TFun) ifFalse: [ self error ].
	x2 := rhs x. s2 := rhs s. t2 := rhs t.
	
	t1_ := t subst: x with: x2.
	cI := s2 ≺ s.
	cO := s2 cAll: x2 cstr: t1_ ≺ t2.
	^cI & cO
]
