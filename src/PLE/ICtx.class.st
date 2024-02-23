"
---------------------------------------------------------------------------------------------- 
-- | @ICtx@ is the local information -- at each trie node -- obtained by incremental PLE
---------------------------------------------------------------------------------------------- 
  
data ICtx    = ICtx 
  { icAssms    :: S.HashSet Pred            -- ^ Equalities converted to SMT format
  , icCands    :: S.HashSet Expr            -- ^ ""Candidates"" for unfolding
  , icEquals   :: EvAccum                   -- ^ Accumulated equalities
  , icSolved   :: S.HashSet Expr            -- ^ Terms that we have already expanded
  , icSimpl    :: !ConstMap                 -- ^ Map of expressions to constants
  , icSubcId   :: Maybe SubcId              -- ^ Current subconstraint ID
  , icFuel     :: !FuelCount                -- ^ Current fuel-count
  }
"
Class {
	#name : #ICtx,
	#superclass : #Object,
	#instVars : [
		'icAssms',
		'icCands',
		'icEquals',
		'icSolved',
		'icSimpl',
		'icSubcId',
		'icFuel'
	],
	#category : #PLE
}

{ #category : #'instance creation' }
ICtx class >> new [
	"The only way to instantiate ICtx is by initCtx:"
	self shouldNotImplement
]

{ #category : #'as yet unclassified' }
ICtx >> evalCandsLoop: ctx knowledge: γ env: env [
"
evalCandsLoop :: Config -> ICtx -> SMT.Context -> Knowledge -> EvalEnv -> IO ICtx
                        ictx0=self     ctx            γ          env
"
	| cands env′ ictx′_evalResults ictx′ evalResults us |
	icCands isEmpty ifTrue: [ ^self "return ictx" ].
	
	cands := icCands.
	env′ := env. "BOGUS"
	ictx′_evalResults := ctx bracket: [
		"SMT.smtAssert ctx (pAnd (S.toList $ icAssms ictx))"
		cands inject: self->#() into: [ :soFar :thisCand | γ evalOneCandStep: env′ ictx_acc: soFar expr: thisCand ]
	].
	ictx′ := ictx′_evalResults key.  evalResults := ictx′_evalResults value.
	us := evalResults concat.
	false
		ifTrue: ["BOGUS: if S.null (us `S.difference` icEquals ictx) then return ictx"]
		ifFalse: [ 
			| oks us′ eqsSMT ictx′′ newcands ictx′′′ |
			oks := us collect: #key.
			us′ := us "withRewrites".
			eqsSMT := us′ collect: [ :each | ctx evalToSMT: each ].
			"eqsSMT := eqsSMT reject isTautoPred"
			ictx′′ := ictx′ copy.
			ictx′′ icSolved: self icSolved, oks.
			ictx′′ icEquals: self icEquals, us′.
			ictx′′ icAssms:  self icAssms, eqsSMT.
			newcands := ((cands, (us collect: #value)) asArray collect: [ :each |
				γ makeCandidates: each in: ictx′′ ]) concat.
			ictx′′′ := ictx′′ copy.
			ictx′′′ icCands: newcands asSet.
			self halt.
			^ictx′′′ evalCandsLoop: ctx knowledge: γ env: env
		]
	
]

{ #category : #accessing }
ICtx >> icAssms [
	^ icAssms
]

{ #category : #accessing }
ICtx >> icAssms: anObject [
	icAssms := anObject
]

{ #category : #accessing }
ICtx >> icCands [
	^ icCands
]

{ #category : #accessing }
ICtx >> icCands: anObject [
	icCands := anObject
]

{ #category : #accessing }
ICtx >> icEquals [
	^ icEquals
]

{ #category : #accessing }
ICtx >> icEquals: anObject [
	icEquals := anObject
]

{ #category : #accessing }
ICtx >> icFuel [
	^ icFuel
]

{ #category : #accessing }
ICtx >> icFuel: anObject [
	icFuel := anObject
]

{ #category : #accessing }
ICtx >> icSimpl [
	^ icSimpl
]

{ #category : #accessing }
ICtx >> icSimpl: anObject [
	icSimpl := anObject
]

{ #category : #accessing }
ICtx >> icSolved [
	^ icSolved
]

{ #category : #accessing }
ICtx >> icSolved: anObject [
	icSolved := anObject
]

{ #category : #accessing }
ICtx >> icSubcId [
	^ icSubcId
]

{ #category : #accessing }
ICtx >> icSubcId: anObject [
	icSubcId := anObject
]

{ #category : #solving }
ICtx >> updCtx: ienv diff: Δ cidMb: cidMb [
"
Add the assumptions and candidates from Δ and cidMb to the context.
Cf. PLE.hs
"
	| binds bs ctxEqs |
	binds := Δ collect: [ :i | ienv ieBEnv lookup: i ].
	bs := "second unElabSortedReft <$>" binds. "OK because in ST this is already Z3"
	"ctxEqs := bs collect: [ :eachBind | eachBind value sr_reft expr ]. BOGUS, toSMT ieCfg ieSMT [ ]..."
	
	^self copy
		icAssms: Set new "S.fromList (filter (not . isTautoPred) ctxEqs)";
		icCands: {EApp expr: (EVar of: 'adder') imm: (EVar of: 'xºº1')} asSet;
		icSubcId: cidMb;
		yourself
	
"
EXAMPLE.  testPLE0:

icAssms = fromList [],
->      = fromList [PAtom Eq (ECst (EVar 'y##1') FInt) (ECst (ECon (I 6)) FInt),
                    PAtom Eq (ECst (EVar 'x') FInt) (ECst (ECon (I 5)) FInt),
                    PAtom Eq (ECst (EVar 'y') FInt) (ECst (ECon (I 6)) FInt)],


icCands = fromList [], 
icCands = fromList [EApp (EApp (EVar 'adder') (EVar 'x')) (EVar 'y##1')],


icSimpl = fromList [],
icSimpl = fromList [(EVar 'y##1',ECon (I 6)),
                    (EVar 'x',ECon (I 5)),
                    (EVar 'y',ECon (I 6))],

icSubcId = Nothing,
->         Just 1

fuel: SAME
icEquals: SAME fromList [], 
icSolved: SAME fromList [],
"
]
