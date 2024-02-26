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
	| binds bs subMb eRhs rhs es econsts cands initEqs ctxEqs |
	binds := Δ collect: [ :i | ienv ieBEnv lookup: i ]. ":: [ (Symbol->SortedReft) ]"
	bs := "second unElabSortedReft <$>" binds. "OK because in ST this is already Z3"
	subMb := cidMb ifNil: [nil] ifNotNil: [(Dictionary newFromAssociations: ienv ieCstrs) at: cidMb].
	eRhs := subMb maybe: Bool true f: #crhs.
	rhs := eRhs" unElab??".
	es  := binds collect: #expr" unElab??".
	econsts := Dictionary newFromAssociations: (ienv ieKnowl findConstants: es).
	cands := {rhs},es collectAndCat: [ :eachExpr | ienv ieKnowl makeCandidates: eachExpr in: self ].
	initEqs := #(). "BOGUS but still ok today"
	ctxEqs := "... initEqs, sims, icEquals ctx, ..."
		bs "select: [ :eachBind |
			| r |
			r := eachBind value.
			r halt sr_reft expr ← must be free of kvars ]."
			collect: [ :eachBind | eachBind value sr_reft expr ].
		
	
	^self copy
		icAssms: "S.fromList (filter (not . isTautoPred) ctxEqs)" ctxEqs asSet;
		icCands: cands asSet, icCands;
		icSimpl: "sims,' " econsts, icSimpl;
		icSubcId: cidMb;
		yourself
]
