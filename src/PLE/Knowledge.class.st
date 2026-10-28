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

{ #category : #'as yet unclassified' }
Knowledge class >> feChoose: x rhs: y [
	x ifTrue: [ ^true ].
	^y
]

{ #category : #'instance creation' }
Knowledge class >> new [
	"Please use SInfo>>knowledge:"
	self shouldNotImplement
]

{ #category : #'as yet unclassified' }
Knowledge >> addConst: e_e′ to: ctx [ 
	"Inner function in fastEval."
	
	"BOGUS, what if knDCs is not empty?"
	
	^ctx
]

{ #category : #'as yet unclassified' }
Knowledge >> eval: e ctx: ctx et: et [
"
  -- | Unfolds expressions using rewrites and equations.
  --
  -- Also reduces if-then-else when the boolean condition or the negation can be
  -- proved valid. This is the actual implementation of guard-validation-before-unfolding
  -- that is described in publications.
  --
  -- Also folds constants.
  --
  -- Also adds to the monad state all the subexpressions that have been rewritten
  -- as pairs @(original_subexpression, rewritten_subexpression)@.
cf. PLE.hs

eval :: Knowledge -> ICtx -> EvalType -> Expr -> EvalST (Expr, FinalExpand)
         self        ctx       et         e
"
	| acc ev e0′ fe e0′_fe e′ |
	ctx icSimpl at: e ifPresent: [ :v | ^v -> false ].
	ev := Context readState: #EvEnv.
	acc := Dictionary newFromAssociations: ev evAccum asArray.
	e0′_fe := e goEval: self ctx: ctx et: et.
	e0′ := e0′_fe key.  fe := e0′_fe value.
	e′ := e0′ simplify: self in: ctx.
	^e ~= e′
		ifTrue: [
				(et isKindOf: NoRW)
						ifTrue: [
							| e′′_fe′ e′′ fe′ |
							ev evAccum add: e->e′.
							ev evNewEqualities add: e->e′.
							e′′_fe′ := self eval: e′ ctx: (self addConst: e->e′ to: ctx) et: et.
							e′′ := e′′_fe′ key.  fe′ := e′′_fe′ value.
							e′′ -> (Knowledge feChoose: fe rhs: fe′).
						] ifFalse: [ e′ -> fe ]
		] ifFalse: [
					e -> fe
		]
		
]

{ #category : #'as yet unclassified' }
Knowledge >> evalBool: e [
"
evalBool :: Knowledge -> Expr -> EvalST (Maybe Expr)
"
	| bt bf |
	bt := self isValid: e.
	bt ifTrue: [ ^Bool true ].
	bf := self isValid: e not.
	bf ifTrue: [ ^Bool false ].
	^nil
]

{ #category : #'as yet unclassified' }
Knowledge >> evalIte: ctx b: b₀ e₁: e₁ e₂: e₂ et: et [
	| b_fe b fe b′ nb′ |
	b_fe := self eval: b₀ ctx: ctx et: et.
	b := b_fe key.   fe := b_fe value.
	b′  := self isValid: b.
	b′  ifTrue: [ ^e₁ -> false ].
	nb′ := self isValid: b not.
	nb′ ifTrue: [ ^e₂ -> false ].
	^(b ifThen: e₁ else: e₂) -> fe
]

{ #category : #'as yet unclassified' }
Knowledge >> evalOne: e ctx: ctx [
"
evalOne :: Knowledge -> EvalEnv -> ICtx -> Expr -> IO (EvAccum, FuelCount)
             self         env
"
	"BOGUS: what about getAutoRws? for now do simple things,
	 and definitely no evalREST..."
	
	| env e′ evAcc′ e′__ |
	env := Context readState: #EvEnv.
	e′__ := [self eval: e ctx: ctx et: NoRW new] runReader: #EvEnv initialState: env "TODO { evFuel = icFuel ctx }".
	e′ := e′__ key.
	evAcc′ := e′=e
		ifTrue:  [ env evAccum ]
		ifFalse: [ env evAccum copy insert: e->e′ ].
	^evAcc′ -> env evFuel
	
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
		xcs := xcs select: [ :xc | xc value isDataConstant: knDCs ].
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

{ #category : #GT }
Knowledge >> gtInspectorSummaryIn: composite [
	<gtInspectorPresentationOrder: 30>
	^ composite fastTable
		title: 'Summary';
		display: [ self knSummary ];
		column: 'Function' evaluated: #key;
		column: 'Arity' evaluated: #value
]

{ #category : #'as yet unclassified' }
Knowledge >> isValid: e [
"
isValid :: Knowledge -> Expr -> IO Bool
"
	| contra |
	contra := knPreds value: knContext value: knLams value: Bool false.
	contra ifTrue: [ ^false ].
	^knPreds value: knContext value: knLams value: e
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

	^expr notGuardedApps select: [ :e | e ∉ ctx icSolved and: [ e isRedex: self ] ]
]

{ #category : #'as yet unclassified' }
Knowledge >> shortcut: e ctx: ctx et: et expand: et′ [
	| i e₁ e₂ b b′ nb′ |
	e isEIte ifFalse: [ ^e -> false ].
	i  := e b.
	e₁ := e thenE.
	e₂ := e elseE.
	b := (self eval: i ctx: ctx et: et) key.
	b′  := self isValid: b.
	nb′ := self isValid: b not.
	b′  ifTrue: [ ^self shortcut: e₁ ctx: ctx et: et expand: false ].
	nb′ ifTrue: [ ^self shortcut: e₂ ctx: ctx et: et expand: false ].
	^(b ifThen: e₁ else: e₂) -> false
]

{ #category : #'as yet unclassified' }
Knowledge >> testForInconsistentEnvironment [
	^knPreds
		value: knContext
		value: knLams
		value: Bool false
]
