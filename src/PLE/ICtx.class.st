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
		'icSubcId'
	],
	#category : #PLE
}

{ #category : #'instance creation' }
ICtx class >> initCtx: es [
"
initCtx :: [(Expr,Expr)] -> ICtx
" 
	^ICtx basicNew
		icAssms: Set new;
		icCands: Set new;
		icEquals: es asSet;
		icSolved: Set new;
		icSimpl: ConstMap new;
		icSubcId: nil;
		yourself
]

{ #category : #'instance creation' }
ICtx class >> new [
	self shouldNotImplement
]

{ #category : #'as yet unclassified' }
ICtx >> evalCandsLoop: ctx knowledge: γ [
"
-- | Generate equalities for all function invocations in the candidates
-- in @ctx@ for which definitions are known. The function definitions are in
-- @ieKnowl@.
--
-- In pseudocode:
--
-- > do
-- >     for every candidate 
-- >         discover equalities,
-- >         unfold function invocations,
-- >         update candidates with the unfolded expressions
-- >     send newly discovered equalities to the SMT solver
-- > until no new equalities are discovered
-- >       or the environment becomes inconsistent
--
evalCandsLoop :: Config -> ICtx -> SMT.Context -> Knowledge -> IO ICtx
                        ictx0=self     ctx            γ
"
	| go |
	go := [ :ictx :i |
		| env env′ cands  ictx′ evalResults us |
		icCands isEmpty ifTrue: [^ictx].
		γ testForInconsistentEnvironment ifTrue: [^ictx].
	
	cands := icCands.
	env := Context readState: #EvEnv.
	env′ := env copy
		evAccum: icEquals, env evAccum;
		yourself.
	ctx smtAssert: (Bool and: icAssms asArray). "TODO: pAndNoDedup"
	ictx′ := ictx copy
		icAssms: #mempty;
		yourself.
	
	[ cands do: [ :cand | γ evalOne: cand ctx: ictx′ ] ] runReader: #EvEnv initialState: env′.
	us := env′ evNewEqualities.
	(us difference: icEquals) isEmpty
		ifTrue: [ ^self ]
		ifFalse: [ 
			| oks us′ eqsSMT ictx′′ newcands ictx′′′ |
			oks := us collect: #key.
			us′ := us "withRewrites".
			eqsSMT := us′ collect: [ :each | ctx evalToSMT: each ].
			
			ictx′′ := ictx′ copy.
			ictx′′ icSolved: self icSolved, oks.
			ictx′′ icEquals: self icEquals, us′.
			ictx′′ icAssms:  eqsSMT. "TODO: eqsSMT := eqsSMT reject isTautoPred"
			newcands := ((cands, (us collect: #value)) asArray collect: [ :each |
				γ makeCandidates: each in: ictx′′ ]) join.
			ictx′′′ := ictx′′ copy.
			ictx′′′ icCands: newcands asSet.
			^ictx′′′ evalCandsLoop: ctx knowledge: γ
		]
	].

	^go value: self value: 0	


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

{ #category : #'as yet unclassified' }
ICtx >> testForInconsistentEnvironment [
	self shouldBeImplemented.
]

{ #category : #solving }
ICtx >> updCtx: ienv diff: Δ cidMb: cidMb [
"
Add the assumptions and candidates from Δ and cidMb to the context.
Cf. PLE.hs
"
	| binds bs subMb eRhs rhs es econsts cands initEqs ctxEqs |
	binds := Δ collect: [ :i | ienv ieBEnv lookupBindEnv: i ]. ":: [ (Symbol->SortedReft) ]"
	bs := "second unElabSortedReft <$>" binds. "OK because in ST this is already Z3"
	subMb := cidMb ifNil: [nil] ifNotNil: [(Dictionary newFromAssociations: ienv ieCstrs) at: cidMb].
	eRhs := subMb maybe: Bool true f: #crhs.
	rhs := eRhs" unElab??".
	es  := binds collect: #expr" unElab??".
	econsts := Dictionary newFromAssociations: (ienv ieKnowl findConstants: es).
	cands := {rhs},es >>= [ :eachExpr | ienv ieKnowl makeCandidates: eachExpr in: self ].
	initEqs := #(). "BOGUS but still ok today"
	ctxEqs := "... initEqs, sims, icEquals ctx, ..."
		bs "select: [ :eachBind |
			| r |
			r := eachBind value.
			r halt sr_reft expr ← must be free of kvars ]."
			collect: [ :eachBind | eachBind value sr_reft expr ].
	ctxEqs := ctxEqs nubOrd.	"toSMT with empty bs does nothing"
	
	^self copy
		icAssms: "S.fromList (filter (not . isTautoPred) ctxEqs)" ctxEqs asSet;
		icCands: cands asSet, icCands;
		icSimpl: "sims,' " econsts, icSimpl;
		icSubcId: cidMb;
		yourself
]
