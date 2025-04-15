"
SortCheck.hs:type Env      = Symbol -> SESearch Sort

Cf. SortCheck.hs
"
Class {
	#name : #Env,
	#superclass : #BlockClosure,
	#type : #variable,
	#category : #'Refinements-SortCheck'
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
	ge := EApp fun: g imm: e.
	su := self unifyMany: ge tvSubst: isu sorts: {it} sorts: {et}.
	t := su applyTo: ot.
	^to
		ifNil: [ { su . t } ]
		ifNotNil: [ :t′ | self shouldBeImplemented ]
]

{ #category : #'sort-checking' }
Env >> checkBvConcat: lhs rhs: rhs [
	| tL tR |
	tL := lhs checkExpr: self.
	tR := rhs checkExpr: self.
	^(EBvConcat lhs: lhs rhs: rhs) checkBvConcatTy_in: self t₁: tL t₂: tR
]

{ #category : #'sort-checking' }
Env >> checkBvExtend: bitvector i: i signed: isSigned [
	| t length |
	t := bitvector checkExpr: self.
	^(EBvExtend bitvector: bitvector i: i signed: isSigned) checkBvExtendTy_in: self t: t
]

{ #category : #'sort-checking' }
Env >> checkBvExtract: bitvector m: m n: n [
	| t |
	t := bitvector checkExpr: self.
	^(EBvExtract bitvector: bitvector m: m n: n) checkBvExtractTy_in: self t: t
]

{ #category : #'sort-checking' }
Env >> checkBvRepeat: bitvector times: times [
	| t |
	t := bitvector checkExpr: self.
	^(EBvRepeat bitvector: bitvector times: times) checkBvRepeatTy_in: self t: t
]

{ #category : #'sort-checking' }
Env >> checkIndexedUop: aSelector arg: e [
	| t |
	t := e checkExpr: self.
	^(EIndexedUnary uop: aSelector arg: e) checkUopTy_in: self t: t
]

{ #category : #'sort-checking' }
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

{ #category : #'sort-checking' }
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

{ #category : #'sort-checking' }
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

{ #category : #'sort-checking' }
Env >> checkUop: aSelector arg: e [
	| t |
	t := e checkExpr: self.
	^(EUnary uop: aSelector arg: e) checkUopTy_in: self t: t
]

{ #category : #elaboration }
Env >> getIte_e1: e1 e2: e2 [
	| t1 t2 |
	t1 := e1 checkExpr: self.
	t2 := e2 checkExpr: self.
	^(self unifys: nil ts: {t1} ts′: {t2}) applyTo: t1
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

	t1 = t2 ifTrue: [ ^θ ].
	
	t1 isBitVectorSort ifTrue: [
		t2 isBitVectorSort ifFalse: [ ^Incompatible signal ].
		^self unify1: e tvSubst: θ sort: t1 sizeSort sort: t2 sizeSort ].
	
	(t1 isKindOf: FApp) ifTrue: [
		(t2 isKindOf: FApp) ifTrue: [ ^self unifyMany: e tvSubst: θ sorts: { t1 s . t1 t } sorts: { t2 s . t2 t } ].
		(t2 isKindOf: Z3IntSort) ifTrue: [ ^Incompatible signal ].
		(t2 isKindOf: Z3BoolSort) ifTrue: [ ^Incompatible signal ].
		(t2 isKindOf: Z3UninterpretedSort) ifTrue: [ ^Incompatible signal ].
		^self unify1: e tvSubst: θ sort: t1 sort: t2 guest
	].
	((t1 isKindOf: FTC) and: [t2 isKindOf: FTC]) ifTrue: [ ^self unifyTC: t1 typeConstructor with: t2 typeConstructor tvSubst: θ	].
	(t1 isKindOf: FAbs) ifTrue: [ | t1′ |
		t1′ := t1 instantiate.
		^self unifyMany: e tvSubst: θ sorts: {t1′} sorts: {t2} ].
	(t2 isKindOf: FAbs) ifTrue: [ | t2′ |
		t2′ := t2 instantiate.
		^self unifyMany: e tvSubst: θ sorts: {t1} sorts: {t2′} ].
	"TODO: insert ℝ ≅ ℤ here"
	"ℤ on either side:"
	(t1 isKindOf: Z3IntSort) ifTrue: [ t2 checkNumeric: self tvSubst: θ. ^θ ].
	(t2 isKindOf: Z3IntSort) ifTrue: [ t1 checkNumeric: self tvSubst: θ. ^θ ].

	((t1 isKindOf: FFunc) and: [t2 isKindOf: FFunc]) ifTrue: [ ^self unifyMany: e tvSubst: θ sorts: { t1 from . t1 to } sorts: { t2 from . t2 to } ].
	(t1 isKindOf: FObj) ifTrue: [ ^t2 checkEqConstr: self maybeExpr: e tvSubst: θ symbol: t1 symbol ].
	(t2 isKindOf: FObj) ifTrue: [ ^t1 checkEqConstr: self maybeExpr: e tvSubst: θ symbol: t2 symbol ].
	Incompatible signal
]

{ #category : #unification }
Env >> unify: e sort: t1 sort: t2 [
	[^self unify1: e tvSubst: (Context readState: #tvSubst) sort: t1 sort: t2 ] runReader: #tvSubst initialState: TVSubst new
]

{ #category : #unification }
Env >> unifyBvLength: m with: n tvSubst: θ [
	| bvLengthInference |
	m = n ifTrue: [ ^θ ].  "the easy case doesn't require a BvLengthInference in progress"
	bvLengthInference := [ BvLengthInference current ] on: NoAnswer do: [ ^Incompatible signal ].
	bvLengthInference addConstraint: m toInt === n toInt.
	^θ
		
]

{ #category : #unification }
Env >> unifyMany: e tvSubst: θ sorts: ts sorts: ts′ [
"
unifyMany :: HasCallStack => Env -> Maybe Expr -> TVSubst -> [Sort] -> [Sort] -> CheckM TVSubst
"
	| zip |
	ts size = ts′ size ifFalse: [ self error ].
	zip := ts zip: ts′.
	^zip inject: θ into: [ :thisΘ :t_t′ |
			| t t′ |
			t := t_t′ key. t′ := t_t′ value.
			self unify1: e tvSubst: θ sort: t sort: t′ ]
]

{ #category : #unification }
Env >> unifyTC: tc₁ with: tc₂ tvSubst: θ [ 
	(tc₁ isListTC and: [ tc₂ isListTC ]) ifTrue: [ ^θ ]. "LF #739"
	(tc₁ isBitVecSizeTC and: [ tc₂ isBitVecSizeTC ]) ifTrue: [ ^self unifyBvLength: tc₁ length with: tc₂ length tvSubst: θ ].
	Incompatible signal.


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
