"
data EvalEnv = EvalEnv
  { evEnv      :: !SymEnv
  , evAccum    :: EvAccum
  , evFuel     :: FuelCount
  } deriving Show
cf. PLE.hs
"
Class {
	#name : #EvalEnvPLE,
	#superclass : #Object,
	#instVars : [
		'evEnv',
		'evAccum',
		'evFuel'
	],
	#category : #PLE
}

{ #category : #'instance creation' }
EvalEnvPLE class >> fromSymEnv: aSymEnv [ 
	^self basicNew
		evEnv: aSymEnv;
		evAccum: EvAccum new;
		evFuel: #defaultFuel;
		yourself
]

{ #category : #accessing }
EvalEnvPLE >> evAccum [
	^ evAccum
]

{ #category : #accessing }
EvalEnvPLE >> evAccum: anObject [
	evAccum := anObject
]

{ #category : #accessing }
EvalEnvPLE >> evEnv [
	^ evEnv
]

{ #category : #accessing }
EvalEnvPLE >> evEnv: anObject [
	evEnv := anObject
]

{ #category : #accessing }
EvalEnvPLE >> evFuel [
	^ evFuel
]

{ #category : #accessing }
EvalEnvPLE >> evFuel: anObject [
	evFuel := anObject
]

{ #category : #unfolding }
EvalEnvPLE >> fastEval: γ ctx: ctx expr: e [
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

fastEval :: Knowledge -> ICtx -> Expr -> EvalST Expr
               γ         ctx      e
self = the state of EvalEnv (type EvalST = StateT EvalEnv IO)
"
	| acc |
	ctx icSimpl at: e ifPresent: [ :v | ^v ].
	
	acc := Dictionary newFromAssociations: evAccum asArray.
	acc at: e
		ifPresent: [ :e′ | ^self fastEval: γ ctx: ctx expr: e′ ]
		ifAbsent: [
			| e′ |
			e′ := (e goFastEval: γ ctx: ctx in: self) simplify: γ in: ctx.
			^e~=e′
				ifTrue: [
					evAccum add: e->e′.
					self fastEval: γ ctx: (γ addConst: e->e′ to: ctx) expr: e′
				] ifFalse: [
					e
				]
			]
]
