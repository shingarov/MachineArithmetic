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
		'__solverState',
		'compiler',
		'ctContext'
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

{ #category : #'instance creation' }
Solution class >> initialSolution: sInfo kVars: ks [
	"Initial Solution (from Qualifiers and WF constraints).
	init :: (F.Fixpoint a) => Config -> F.SInfo a -> S.HashSet F.KVar -> Sol.Solution
	cf Solution.hs"
	| senv genv qcs ws keqs ebs xEnv qs_ |
	xEnv := sInfo bs sxEnv.
	genv := sInfo instConstants.
	senv := sInfo symbolEnv.
	ebs := sInfo ebindInfo.
	qs_ := sInfo quals.
	ws := sInfo wsWithin: ks.
	qcs := QCluster of: sInfo quals.
	keqs := ws collect: [ :w | sInfo refine: qcs sorts: genv wfc: w ].
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
	| newInstance |
	newInstance := self class basicNew.
	self class instanceVariableNamesDo: [ :iv |
		"Please factor this out to a general structure -- this is not specific to Sol.
		A Cartesian product forms a semigroup if projections each form a semigroup."
		(#(__solverState compiler ctContext) includes: iv) ifFalse: "BOGUS, please please refactor this whole shape of dispatching asap"
		[newInstance
			perform: iv,':'
			with: (self perform: iv), (y perform: iv)] ].
	^newInstance
]

{ #category : #bogus }
Solution >> __solverState: anObject [
	__solverState := anObject
]

{ #category : #'as yet unclassified' }
Solution >> cnd: k _: su [
	| qBind |
	qBind := self lookupQBind: k.
	^self qbPreds: su qBind: qBind
]

{ #category : #'as yet unclassified' }
Solution >> createCompiler [
"FIXME: code duplication with BindEnv>>createCompiler"
	| compiler |
	compiler := self class compiler class new.
	compiler context: self ctContext.
	^compiler
]

{ #category : #'as yet unclassified' }
Solution >> ctContext [
	ctContext isNil ifTrue: [ ctContext := CardanoTartagliaContext ofSortedVariables: self sortDict ].
	^ctContext
]

{ #category : #'as yet unclassified' }
Solution >> evaluate: smalltalkSource [ 
	^compiler evaluate: smalltalkSource
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
	| lp rp solver valid |
	lp := self lhsPred: aSimpC in: bindingsInSmt.
	rp := aSimpC rhs evaluateIn: __solverState binds.
	^(Z3Solver isValid: lp ==> rp) not
]

{ #category : #bogus }
Solution >> lhsPred: aSimpC in: bindingsInSmt [
	"Create an actual Z3 predicate expression corresponding to LHS of constraint in current solution."
	| be cEnv |
	be := __solverState binds.
	cEnv := CombinedEnv new 
		ci: aSimpC id;
		bEnv: be;
		iEnv: aSimpC env;
		bindingsInSmt: bindingsInSmt;
		yourself.
	^cEnv apply: self bs: aSimpC env
]

{ #category : #'as yet unclassified' }
Solution >> lookup: kvarName [
"lookup :: Sol a QBind -> KVar -> Either Hyp QBind
cf. Solutions.hs"
	| cs |
	cs := Dictionary new "sHyp" "BOGUS, sHyp should be a Dictionary" at: kvarName ifAbsent: [ ^Either right: (self lookupElab: kvarName) ].
	^Either left: cs
]

{ #category : #'as yet unclassified' }
Solution >> lookupElab: kvarName [ 
	^sMap at: kvarName
]

{ #category : #'as yet unclassified' }
Solution >> lookupQBind: kvarName [
"lookupQBind :: Sol a QBind -> KVar -> QBind"
	| dict |
	dict := Dictionary newFromAssociations: sMap values.
	^dict at: kvarName ifAbsent: [ QBind fromEQuals: #() ]
]

{ #category : #'as yet unclassified' }
Solution >> qbPreds: aSubst qBind: aQBind [
	compiler := self createCompiler.
	^aQBind eQuals collect: [ :eq |
		| eqPred |
		eqPred := eq pred.
		{ eqPred evaluateIn: self . eq } ]
]

{ #category : #'as yet unclassified' }
Solution >> refine: bindingsInSmt worklist: w [
"refine
    :: (F.Loc a)
    => F.IBindEnv
    -> Sol.Solution
    -> W.Worklist a
    -> SolveM Sol.Solution
cf. Solve.hs"
	| c_w1_newScc_rnk c b_s1 |
	c_w1_newScc_rnk := w pop.
	c_w1_newScc_rnk isNil ifTrue: [ ^self ].
	c := c_w1_newScc_rnk first.
	
	b_s1 := self halt refineC: bindingsInSmt _: #i _: c.
	self shouldBeImplemented 
]

{ #category : #'as yet unclassified' }
Solution >> refineC: bindingsInSmt _: _i _: c [
	| ks_rhs |
	ks_rhs := self rhsCands: c.
	
	self shouldBeImplemented.
]

{ #category : #bogus }
Solution >> result: aWorklist in: anIBindEnv [
	^self result_: aWorklist in: anIBindEnv
]

{ #category : #bogus }
Solution >> result_: aWorklist in: anIBindEnv [ 
	| filtered |
	filtered := aWorklist unsatCandidates select: [ :aSimpC | self isUnsat: aSimpC in: anIBindEnv ].
	^filtered size = 0
		ifTrue: [ #Safe ] ifFalse: [ #Unsafe ]
]

{ #category : #'as yet unclassified' }
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
	^{ ks collect: #key . kqs }
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
