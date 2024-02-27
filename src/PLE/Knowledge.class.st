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

{ #category : #'as yet unclassified' }
Knowledge >> addConst: e_e′ to: ctx [ 
	"Inner function in fastEval."
	
	"BOGUS, what if knDCs is not empty?"
	
	^ctx
]

{ #category : #'as yet unclassified' }
Knowledge >> evalApp: ctx f: func args: es in: anEvalEnvPLE [
"
Unfold expressions in @eApps e es@ using rewrites and equations.
evalApp :: Knowledge -> ICtx -> Expr -> [Expr] -> EvalST Expr
cf. PLE.hs
"
	| eq nts component |
	nts := anEvalEnvPLE evEnv naturalTransformations.
	eq := knAms detect: [ :each | each hasComponent: func among: nts ]
		ifNone: [ self shouldBeImplemented ].
	component := (nts at: eq eqName)
		from: (es collect: #sort)
		to: eq eqSort.
	component name = func ifFalse: [ self error ].
	^(eq substEq: anEvalEnvPLE evEnv sort es: es)
]

{ #category : #'as yet unclassified' }
Knowledge >> evalOne: env ctx: ctx expr: e [
"
evalOne :: Knowledge -> EvalEnv -> ICtx -> Expr -> IO (EvAccum, FuelCount)
            γ=self       env
"
	"BOGUS: what about getAutoRws? for now do simple things..."
	
	| state e′ evAcc′ |
	state := env copy "fuel business...".
	e′ := state fastEval: self ctx: ctx expr: e.
	evAcc′ := e′=e
		ifTrue: [ state evAccum ]
		ifFalse: [ state evAccum insert: e->e′ ].
	^evAcc′ -> state evFuel
	
]

{ #category : #'as yet unclassified' }
Knowledge >> evalOneCandStep: env′ ictx_acc: ictx_acc expr: e [
"
evalOneCandStep :: Knowledge -> EvalEnv -> (ICtx, [EvAccum]) -> Expr -> IO (ICtx, [EvAccum])
                      γ           env′      ictx    acc          e
"
	| ictx acc res_fm res fm ictx′ |
	ictx := ictx_acc key. acc := ictx_acc value.
	res_fm := self evalOne: env′ ctx: ictx expr: e.
	res := res_fm key. fm := res_fm value.
	ictx′ := ictx copy
		icFuel: fm;
		yourself.
	^ictx′ -> ({res},acc)
]

{ #category : #'as yet unclassified' }
Knowledge >> fastEvalIte: ctx b: b₀ e₁: e₁ e₂: e₂ [ 
	self shouldBeImplemented.
]

{ #category : #'as yet unclassified' }
Knowledge >> findConstants: es [
"
findConstants :: Knowledge -> [Expr] -> [(Expr, Expr)]
                   self         es
"	
	| splits go makeSu |
	makeSu := [ :exprs |
		| xcs |
		xcs := es collectMaybe: #constEEqOrNil.
		"BOGUS: need to filter for constants, too..."
		xcs := xcs reject: [ :xc | xc key = xc value ].
	].
	go := [ :su :ess |
		| su′ ess′ |
		su′ := makeSu value: ess.
		ess′ := ess collect: [ :each | each substituteAll: (su′ collect: #key) with: (su′ collect: #value) ].
		ess′=ess
			ifTrue: [ su ]
			ifFalse: [ go value: su, su′ value: ess′ ]
	].
	
	splits := es. "BOGUS: splitPAnd"
	^(go value: #() value: splits)
		selectAssociations: [ :x :c | x isEVar ]
]

{ #category : #'as yet unclassified' }
Knowledge >> isRedex: e [
"

" 
	^true "BOGUS"
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

{ #category : #'as yet unclassified' }
Knowledge >> makeCandidates: expr in: ctx [
"
makeCandidates :: Knowledge -> ICtx -> Expr -> [Expr]
                   γ=self      ctx     expr
"

	^expr notGuardedApps select: [ :e | e ∉ ctx icSolved and: [ self isRedex: e ] ]
]

{ #category : #'as yet unclassified' }
Knowledge >> simplify: e in: ictx [ 
	^e "BOGUS"
]
