"
Knowledge (SMT Interaction)
  --------------------------------------------------------------------------------
  data Knowledge = KN
    { knSims              :: ![Rewrite]           -- ^ Rewrite rules came from match and data type definitions 
    , knAms               :: ![Equation]          -- ^ All function definitions
    , knContext           :: SMT.Context
    , knPreds             :: SMT.Context -> [(Symbol, Sort)] -> Expr -> IO Bool
    , knLams              :: ![(Symbol, Sort)]
    , knSummary           :: ![(Symbol, Int)]     -- ^ summary of functions to be evaluates (knSims and knAsms) with their arity
    , knDCs               :: !(S.HashSet Symbol)  -- ^ data constructors drawn from Rewrite 
    , knSels              :: !SelectorMap
    , knConsts            :: !ConstDCMap
    , knAutoRWs           :: M.HashMap SubcId [AutoRewrite]
    , knRWTerminationOpts :: RWTerminationOpts
    }
"
Class {
	#name : #Knowledge,
	#superclass : #Object,
	#instVars : [
		'knSims',
		'knAms',
		'knContext',
		'knPreds',
		'knLams',
		'knSummary',
		'knDCs',
		'knSels',
		'knConsts',
		'knAutoRWs',
		'knRWTerminationOpts'
	],
	#category : #PLE
}

{ #category : #'instance creation' }
Knowledge class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
Knowledge class >> of: si [
"
knowledge :: Config -> SMT.Context -> SInfo a -> Knowledge
              cfg        ctx            si
"
	| sims |
	sims := si ae aenvSimpl ", ...next line".
	#() "none in ple42 example" collectAndCat: #reWriteDDecl "BOGUS".
	"in the ple42 example, no sims anyway."
	
	^self basicNew
		knAms: si ae aenvEqs;
		yourself
]

{ #category : #accessing }
Knowledge >> knAms [
	^ knAms
]

{ #category : #accessing }
Knowledge >> knAms: anObject [
	knAms := anObject
]

{ #category : #accessing }
Knowledge >> knAutoRWs [
	^ knAutoRWs
]

{ #category : #accessing }
Knowledge >> knAutoRWs: anObject [
	knAutoRWs := anObject
]

{ #category : #accessing }
Knowledge >> knConsts [
	^ knConsts
]

{ #category : #accessing }
Knowledge >> knConsts: anObject [
	knConsts := anObject
]

{ #category : #accessing }
Knowledge >> knContext [
	^ knContext
]

{ #category : #accessing }
Knowledge >> knContext: anObject [
	knContext := anObject
]

{ #category : #accessing }
Knowledge >> knDCs [
	^ knDCs
]

{ #category : #accessing }
Knowledge >> knDCs: anObject [
	knDCs := anObject
]

{ #category : #accessing }
Knowledge >> knLams [
	^ knLams
]

{ #category : #accessing }
Knowledge >> knLams: anObject [
	knLams := anObject
]

{ #category : #accessing }
Knowledge >> knPreds [
	^ knPreds
]

{ #category : #accessing }
Knowledge >> knPreds: anObject [
	knPreds := anObject
]

{ #category : #accessing }
Knowledge >> knRWTerminationOpts [
	^ knRWTerminationOpts
]

{ #category : #accessing }
Knowledge >> knRWTerminationOpts: anObject [
	knRWTerminationOpts := anObject
]

{ #category : #accessing }
Knowledge >> knSels [
	^ knSels
]

{ #category : #accessing }
Knowledge >> knSels: anObject [
	knSels := anObject
]

{ #category : #accessing }
Knowledge >> knSims [
	^ knSims
]

{ #category : #accessing }
Knowledge >> knSims: anObject [
	knSims := anObject
]

{ #category : #accessing }
Knowledge >> knSummary [
	^ knSummary
]

{ #category : #accessing }
Knowledge >> knSummary: anObject [
	knSummary := anObject
]
