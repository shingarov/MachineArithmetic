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
	ctxEqs := bs collect: [ :eachBind | eachBind value sr_reft expr ]. "BOGUS, toSMT ieCfg ieSMT [ ]..."
	self shouldBeImplemented.
	
	^self copy
		icAssms: ctxEqs "S.fromList (filter (not . isTautoPred) ctxEqs)";
		icCands: '[EApp (EApp (EVar "adder") (EVar "x")) (EVar "y##1")]';
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
