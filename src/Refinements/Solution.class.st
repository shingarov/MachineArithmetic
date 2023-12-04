"
I contain the various indices needed to compute a solution,
in particular, to compute `lhsPred` for any given constraint.

sEnv :: !SymEnv                      -- ^ Environment used to elaborate solutions
sMap :: !(M.HashMap KVar a)          -- ^ Actual solution (for cut kvar)
gMap :: !(M.HashMap KVar b)          -- ^ Solution for gradual variables
sHyp :: !(M.HashMap KVar Hyp)        -- ^ Defining cubes  (for non-cut kvar)
sScp :: !(M.HashMap KVar IBindEnv)   -- ^ Set of allowed binders for kvar
sEbd :: !(M.HashMap BindId EbindSol) -- ^ EbindSol for each existential binder
sxEnv :: !(SEnv (BindId, Sort))      --   TODO: merge with sEnv? used for sorts of ebinds to solve ebinds in lhsPred

(cf. Solutions.hs)
"
Class {
	#name : #Solution,
	#superclass : #Object,
	#instVars : [
		'sEnv',
		'sMap',
		'gMap',
		'sHyp',
		'sScp',
		'sEbd',
		'sxEnv',
		'__binds'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Solution class >> env:env kGs:kGs kXs:kXs kYs:kYs z:z ebs:ebs xbs:xbs [
"cf. Solutions.hs
fromList :: SymEnv
           -> [(KVar, a)]
           -> [(KVar, b)]
           -> [(KVar, Hyp)]
           -> M.HashMap KVar IBindEnv
           -> [(BindId, EbindSol)]
           -> SEnv (BindId, Sort)
           -> Sol a b
"
	^Solution basicNew
		sEnv: env;
		sMap: kXs;
		gMap: kGs;
		sHyp: kYs;
		sScp: z;
		sEbd: ebs;
		sxEnv: xbs;
		yourself
]

{ #category : #'as yet unclassified' }
Solution class >> groupKs: ks _: kqs [
"groupKs :: [KVar] -> [(KVar, EQual)] -> [(KVar, QBind)]
cf. Types/Solutions.hs"
	| m0 |
	m0 := Dictionary newFromAssociations: (ks collect: [ :k | k->Set new ]).
	^(m0 groupBase: kqs) associations collect: [ :k_eqs |
		| k eqs |
		k := k_eqs key.
		eqs := k_eqs value.
		k-> (QBind fromEQuals: eqs) ]
]

{ #category : #'instance creation' }
Solution class >> initialSolution: sInfo kVars: ks [
	"Initial Solution (from Qualifiers and WF constraints).
	init :: (F.Fixpoint a) => Config -> F.SInfo a -> S.HashSet F.KVar -> Sol.Solution
	cf Solution.hs"
	| senv genv qcs ws keqs ebs xEnv |
	xEnv := sInfo bs sxEnv.
	genv := sInfo instConstants.
	senv := sInfo symbolEnv.
	senv naturalTransformations: sInfo gLits.
	ebs := sInfo ebindInfo.
	ws := sInfo wsWithin: ks.
	qcs := QCluster mkQCluster: sInfo quals.
	keqs := ws collect: [ :w | sInfo refine: qcs sorts: genv wfc: w ].
	keqs := Dictionary newFromAssociations: keqs.
	^Solution env: senv kGs: Dictionary new kXs: keqs kYs: #() z: Dictionary new ebs: ebs xbs: xEnv
]

{ #category : #'instance creation' }
Solution class >> new [
	"Answer the unit element of the monoid of solutions."
	^Solution basicNew
		sEnv: SymEnv new;
		sMap: Dictionary new;
		gMap: Dictionary new;
		sHyp: #();
		sScp: Dictionary new;
		sEbd: Dictionary new;
		sxEnv: Dictionary new;
		yourself
]

{ #category : #'as yet unclassified' }
Solution class >> refine: qcs sorts: genv wfc: w [

w env  .


	self shouldBeImplemented.
]

{ #category : #copying }
Solution >> , y [
	^self class basicNew
		sEnv: (sEnv, y sEnv);
		sMap: (sMap, y sMap);
		gMap: (gMap, y gMap);
		sHyp: (sHyp, y sHyp);
		sScp: (sScp, y sScp);
		sEbd: (sEbd, y sEbd);
		sxEnv: (sxEnv, y sxEnv);
		__binds: __binds;
		yourself
]

{ #category : #bogus }
Solution >> __binds: aBindEnv [
	__binds := aBindEnv
]

{ #category : #'smalltalk compilation' }
Solution >> cnd: k _: su [
	| qBind |
	qBind := self lookupQBind: k.
	^self qbPreds: su qBind: qBind
]

{ #category : #'smalltalk compilation' }
Solution >> compileIn: γ [
	sMap := sMap collect: [ :aQBind | aQBind evaluateIn: (EvalEnv ofSorts: γ sort) ]
]

{ #category : #'as yet unclassified' }
Solution >> delCEnv: k _: bs [
	| _kbs |
	_kbs := sScp at: k.
	^bs diff: _kbs
]

{ #category : #'as yet unclassified' }
Solution >> ebReft: i c: c [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
Solution >> ebReft: i c: c combEnv: g [
	^c senv exElim: self sxEnv xi: i p: (g ebindReft: self simpC: c)
]

{ #category : #'as yet unclassified' }
Solution >> elabExist: xts p: p [
	^p exists: xts asArray
]

{ #category : #accessing }
Solution >> gMap [
	^ gMap
]

{ #category : #accessing }
Solution >> gMap: anObject [
	gMap := anObject
]

{ #category : #bogus }
Solution >> isUnsat: aSimpC in: bindingsInSmt [
	| lp rp |
	lp := self lhsPred: aSimpC in: bindingsInSmt.
	rp := aSimpC rhs.
	^(Z3Solver isValid: lp ==> rp) not
]

{ #category : #bogus }
Solution >> lhsPred: aSimpC in: bindingsInSmt [
	"Create an actual Z3 predicate expression corresponding to LHS of constraint in current solution.
	cf. Solution.hs"
	| be cEnv |
	be := __binds.
	cEnv := CombinedEnv new 
		ci: aSimpC id;
		bEnv: be;
		iEnv: aSimpC env;
		bindingsInSmt: bindingsInSmt;
		yourself.
	^(cEnv apply: self bs: aSimpC env) expr
]

{ #category : #'as yet unclassified' }
Solution >> lookup: kvarName [
"lookup :: Sol a QBind -> KVar -> Either Hyp QBind
cf. Solutions.hs"
	| cs |
	cs := sHyp at: kvarName ifAbsent: [ ^Either right: (self lookupElab: kvarName) ].
	^Either left: cs "non-cut variable, return its cubes"
]

{ #category : #'as yet unclassified' }
Solution >> lookupElab: kvarName [
"lookupElab :: Sol b QBind -> KVar -> Maybe QBind
cf. Solutions.hs
"
	^sMap at: kvarName
]

{ #category : #'as yet unclassified' }
Solution >> lookupQBind: kvarName [
"lookupQBind :: Sol a QBind -> KVar -> QBind"
	^sMap at: kvarName ifAbsent: [ QBind fromEQuals: #() ]
]

{ #category : #'as yet unclassified' }
Solution >> qbPreds: aSubst qBind: aQBind [
"
qbPreds :: String -> Sol a QBind -> Subst -> QBind -> [(Pred, EQual)]
Cf. Types/Solutions.hs
"
	| elabPred |
	elabPred := [ :eq | ((eq pred subst: aSubst) elaborate: sEnv) smt2: sEnv ].
	^aQBind eQuals collect: [ :eq | { elabPred value: eq . eq } ]
]

{ #category : #'as yet unclassified' }
Solution >> refine: bindingsInSmt worklist: w [
"refine
    :: (F.Loc a)
    => F.IBindEnv
    -> Sol.Solution
    -> W.Worklist a
    -> SolveM Sol.Solution
cf. Solver/Solve.hs"
	| c_w1_newScc_rnk c b_s1 w1 b s1 w2 |
	c_w1_newScc_rnk := w pop.
	c_w1_newScc_rnk isNil ifTrue: [ ^self ].
	c := c_w1_newScc_rnk first.
	w1 := c_w1_newScc_rnk second.
	
	b_s1 := self refineC: bindingsInSmt _: c.
	b := b_s1 first.
	s1 := b_s1 last.
	w2 := b
		ifTrue: [ w1 push: c ]
		ifFalse: [ w1 ].
	^s1 refine: bindingsInSmt worklist: w2
]

{ #category : #'as yet unclassified' }
Solution >> refineC: bindingsInSmt _: c [
	| ks_rhs ks rhs lhs kqs |
	ks_rhs := self rhsCands: c.
	ks := ks_rhs first.
	rhs := ks_rhs last.
	rhs isNil ifTrue: [ ^false->self ].
	lhs := self lhsPred: c in: bindingsInSmt.
	kqs := "kqs    <- filterValid (cstrSpan c) lhs rhs"
		rhs filterValid: lhs.
	^self update: ks _: kqs
]

{ #category : #bogus }
Solution >> result: aWorklist in: anIBindEnv [
	^self result_: aWorklist in: anIBindEnv
]

{ #category : #bogus }
Solution >> result_: aWorklist in: anIBindEnv [
"
result_
  :: (F.Loc a, NFData a, Fixpoint a)
  => F.IBindEnv
  -> Config
  -> W.Worklist a
  -> Sol.Solution
  -> SolveM (F.FixResult (F.SimpC a))
Cf. Solve.hs
" 
	| cs filtered |
	cs := aWorklist unsatCandidates select: #isChecked.
	filtered := cs select: [ :aSimpC | self isUnsat: aSimpC in: anIBindEnv ].
	^filtered size = 0
		ifTrue:  [ Safe new ]
		ifFalse: [ Unsafe bads: (filtered collect: [ :eachSimpC | eachSimpC subcId -> eachSimpC sinfo "TODO 'ci c' cf. Solve.result_" ]) ]
]

{ #category : #'smalltalk compilation' }
Solution >> rhsCands: c [
"Sol.Solution -> F.SimpC a -> ([F.KVar], Sol.Cand (F.KVar, Sol.EQual))"
	| ks kqs |
	ks := c crhs predKs.
	kqs := ks asArray collectAndCat: [ :k_su |
		| k su |
		k := k_su key.
		su := k_su value.
		(self cnd: k _: su) asArray collect: [ :p_q |
			| p q |
			p := p_q first.
			q := p_q last.
			p -> (k->q) ] ].
	^{ ks collect: #key . Cand list: kqs }
]

{ #category : #accessing }
Solution >> sEbd [
	^ sEbd
]

{ #category : #accessing }
Solution >> sEbd: anObject [
	sEbd := anObject
]

{ #category : #accessing }
Solution >> sEnv [
	^ sEnv
]

{ #category : #accessing }
Solution >> sEnv: anObject [
	sEnv := anObject
]

{ #category : #accessing }
Solution >> sHyp [
	^ sHyp
]

{ #category : #accessing }
Solution >> sHyp: anObject [
	sHyp := anObject
]

{ #category : #accessing }
Solution >> sMap [
	^ sMap
]

{ #category : #accessing }
Solution >> sMap: anObject [
	sMap := anObject
]

{ #category : #accessing }
Solution >> sScp [
	^ sScp
]

{ #category : #accessing }
Solution >> sScp: anObject [
	sScp := anObject
]

{ #category : #'as yet unclassified' }
Solution >> solve_: fi ks: ks wkl: w [
"cf. Solver/Solve.hs."
	| s1 s2 s3 s4 res₀ s3_res0 bindingsInSmt |
	fi smt2.
	s1 := fi initialSolution: ks. "cf. Solve.hs"
	s2 := self, s1.
	bindingsInSmt := __binds concretePreds.
	s3 := s2 refine: bindingsInSmt worklist: w.self halt.
	s3_res0 := s3 -> (s3 result: w in: bindingsInSmt).
	res₀ := s3_res0 value.
	res₀ isSafe ifTrue: [ ^res₀ ].
	
	"Lazy PLE"
	fi rewriteAxioms isNil ifTrue: [ ^res₀ ].
	fi doPLE: (res₀ bads collect: #key).
	bindingsInSmt := __binds concretePreds.
	s4 := s3 refine: bindingsInSmt worklist: w.
	^s4 result: w in: bindingsInSmt
]

{ #category : #'as yet unclassified' }
Solution >> sortDict [
	^sxEnv collect: #value
]

{ #category : #accessing }
Solution >> sxEnv [
	^ sxEnv
]

{ #category : #accessing }
Solution >> sxEnv: anObject [
	sxEnv := anObject
]

{ #category : #updating }
Solution >> update: ks _: kqs [
"update :: Sol a QBind -> [KVar] -> [(KVar, EQual)] -> (Bool, Sol a QBind)
cf. Types/Solutions.hs"
	| kqss update1 bs_s1 bs s1 |
	kqss := self class groupKs: ks _: kqs.
	update1 := [ :s :k_qs |
		| k qs oldQs change |
		k := k_qs key.
		qs := k_qs value.
		oldQs := self lookupQBind: k.
		change := oldQs qbSize ~= qs qbSize.
		{ change . self updateK: k _: qs } ].
	bs_s1 := kqss folds: update1 base: self.
	bs := bs_s1 first.
	s1 := bs_s1 last.
	^{ Boolean or: bs . s1 }
]

{ #category : #'as yet unclassified' }
Solution >> updateK: kvarName _: aQBind [ 
	^self copy
		sMap: (sMap copy at: kvarName put: aQBind; yourself);
		yourself
]
