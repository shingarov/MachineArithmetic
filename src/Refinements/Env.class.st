Class {
	#name : #Env,
	#superclass : #BlockClosure,
	#type : #variable,
	#category : #Refinements
}

{ #category : #'sort-checking' }
Env >> checkApp: to g: g es: es [
"
checkApp :: Env -> Maybe Sort -> Expr -> Expr -> CheckM Sort
            self       to         g       es
checkApp f to g es 
  = snd <$> checkApp' f to g es
"
	^(self checkApp′: to g: g es: es) second
]

{ #category : #'sort-checking' }
Env >> checkApp′: to g: g es: e [
"
-- DUPLICATION with 'elabAppAs'
checkApp' :: Env -> Maybe Sort -> Expr -> Expr -> CheckM (TVSubst, Sort)
              f         to         g       e
"
	| gt et it_ot_isu it ot isu ge su t |
	gt := g checkExpr: self.
	et := e checkExpr: self.
	it_ot_isu := gt checkFunSort.
	it := it_ot_isu first.  ot := it_ot_isu second.  isu := it_ot_isu third.
	ge := EApp expr: g imm: e.
	su := self unifyMany: ge tvSubst: isu sorts: {it} sorts: {et}.
	t := su applyTo: ot.
	^to
		ifNil: [ { su . t } ]
		ifNotNil: [ :t′ | self shouldBeImplemented ]
]

{ #category : #'as yet unclassified' }
Env >> checkIte: p e₁: e₁ e₂: e₂ [
"
checkIte :: Env -> Expr -> Expr -> Expr -> CheckM Sort
            self    p       e₁      e₂
"
	| t₁ t₂ |
	self checkPred: p.
	t₁ := e₁ checkExpr: self.
	t₂ := e₂ checkExpr: self.
	^self checkIteTy: p e₁: e₁ e₂: e₂ t₁: t₁ t₂: t₂
]

{ #category : #'as yet unclassified' }
Env >> checkIteTy: p e₁: e₁ e₂: e₂ t₁: t₁ t₂: t₂ [
"
checkIteTy :: Env -> Expr -> Expr -> Expr -> Sort -> Sort -> CheckM Sort
"
	| e′ |
	e′ := EIte if: p then: e₁ else: e₂.
	^(self unifys: e′ ts: {t₁} ts′: {t₂}) applyTo: t₁
]

{ #category : #'sort-checking' }
Env >> checkOp: o e₁: e₁ e₂: e₂ [
	| t₁ t₂ |
	t₁ := e₁ checkExpr: self.
	t₂ := e₂ checkExpr: self.
	^(EBin bop: o left: e₁ right: e₂) checkOpTy_in: self t₁: t₁ t₂: t₂
]

{ #category : #'as yet unclassified' }
Env >> checkPred: p [
"
checkPred                  :: Env -> Expr -> CheckM ()
                              self    p
"
	(p checkExpr: self) checkBoolSort: self
	"in LF these are connected by >>= because effectful."
	
	
]

{ #category : #elaboration }
Env >> checkSym: x [
"
checkSym :: Env -> Symbol -> CheckM Sort
"
	^x⋅self
		ifFound: #instantiate
		alts: #error
]

{ #category : #unification }
Env >> unify1: e tvSubst: θ sort: t₁ sort: t₂ [
"
unify1 :: Env -> Maybe Expr -> TVSubst -> Sort -> Sort -> CheckM TVSubst
           f            e        θ         t1      t2
Cf. SortCheck.hs
"
	| t1 t2 |
	t1 := t₁ guest.
	t2 := t₂ guest.
	(t1 isKindOf: FVar) ifTrue: [ ^t2 unifyVar: self maybeExpr: e tvSubst: θ int: t1 i ].
	(t2 isKindOf: FVar) ifTrue: [ ^t1 unifyVar: self maybeExpr: e tvSubst: θ int: t2 i ].
	(t1 isKindOf: FApp) ifTrue: [
		(t2 isKindOf: FApp) ifTrue: [ ^self unifyMany: e tvSubst: θ sorts: { t1 s . t1 t } sorts: { t2 s . t2 t } ].
		(t2 isKindOf: Z3IntSort) ifTrue: [ ^nil ].
		(t2 isKindOf: Z3BoolSort) ifTrue: [ ^nil ].
		(t2 isKindOf: Z3UninterpretedSort) ifTrue: [ ^nil ].
		^self unify1: e tvSubst: θ sort: t1 sort: t2 guest
	].
	((t1 isKindOf: FTC) and: [t2 isKindOf: FTC]) ifTrue: [
		(t1 typeConstructor isListTC and: [ t2 typeConstructor isListTC ]) ifTrue: [ ^θ ] ].
	(t1 isKindOf: FAbs) ifTrue: [ self shouldBeImplemented ].
	(t2 isKindOf: FAbs) ifTrue: [ self shouldBeImplemented ].
	"TODO: insert ℝ ≅ ℤ here"
	"ℤ on either side:"
	(t1 isKindOf: Z3IntSort) ifTrue: [ ^t2 checkNumeric: self tvSubst: θ ].
	(t2 isKindOf: Z3IntSort) ifTrue: [ ^t1 checkNumeric: self tvSubst: θ ].

	((t1 isKindOf: FFunc) and: [t2 isKindOf: FFunc]) ifTrue: [ ^self unifyMany: e tvSubst: θ sorts: { t1 from . t1 to } sorts: { t2 from . t2 to } ].
	(t1 isKindOf: FObj) ifTrue: [ ^t2 checkEqConstr: self maybeExpr: e tvSubst: θ symbol: t1 symbol ].
	(t2 isKindOf: FObj) ifTrue: [ ^t1 checkEqConstr: self maybeExpr: e tvSubst: θ symbol: t2 symbol ].
	
	t1 = t2 ifTrue: [ ^θ ].
	Incompatible signal
]

{ #category : #unification }
Env >> unify: e sort: t1 sort: t2 [
	[^self unify1: e tvSubst: (Context readState: #tvSubst) sort: t1 sort: t2 ] runReader: #tvSubst initialState: TVSubst new
]

{ #category : #unification }
Env >> unifyMany: e tvSubst: θ sorts: ts sorts: ts′ [
"
unifyMany :: HasCallStack => Env -> Maybe Expr -> TVSubst -> [Sort] -> [Sort] -> CheckM TVSubst
"
	| zip |
	ts size = ts′ size ifFalse: [ self error ].
	zip := ts zip: ts′.
	zip collectAssociations: [ :t :t_ | self unify1: e tvSubst: θ sort: t sort: t_ ].
	"we destructively modify θ in place"
	^θ
]

{ #category : #'sort-checking' }
Env >> unifyTo1: ts [
"
--------------------------------------------------------------------------------
unifyTo1 :: Env -> [Sort] -> Maybe Sort
--------------------------------------------------------------------------------
"
	^[ (self unifyTo1M: ts) "what about right left???" ] runCM0.

]

{ #category : #'sort-checking' }
Env >> unifyTo1M: t0_ts [
"
--------------------------------------------------------------------------------
unifyTo1M :: Env -> [Sort] -> CheckM Sort
--------------------------------------------------------------------------------
"
	| t0 ts |
	t0_ts isEmpty ifTrue: [ self error: 'unifyTo1: empty list' ]. "unifyTo1M _ []"
	t0 := t0_ts first. ts := t0_ts allButFirst.
	^(ts
		inject: TVSubst empty -> t0
		into: [ :su_t :t′ |
			"step :: (TVSubst, Sort) -> Sort -> CheckM (TVSubst, Sort)"
			"           su      t        t′                           "
			| su t |
			self shouldBeImplemented
		]) value 
]

{ #category : #unification }
Env >> unifys: e ts: ts ts′: ts′ [
"
unifys :: HasCallStack => Env -> Maybe Expr -> [Sort] -> [Sort] -> CheckM TVSubst
                          self       e           ts        ts′
"
	^self unifyMany: e tvSubst: (TVSubst  new) sorts: ts sorts: ts′
]

{ #category : #unification }
Env >> unite: e t1: t1 t2: t2 [
"
unite :: Env -> Expr -> Sort -> Sort -> CheckM (Sort, Sort)
         self    e       t1      t2
"
	| su |
	su := self unifys: e ts: {t1} ts′: {t2}.
	^{ su applyTo: t1 . su applyTo: t2 }
]
