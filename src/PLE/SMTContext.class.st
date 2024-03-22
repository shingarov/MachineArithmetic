"
In Smalltalk, this is a weird hybrid of Z3 Solver and
-- | Information about the external SMT process
data Context = Ctx
  { ctxPid     :: !ProcessHandle
  , ctxCin     :: !Handle
  , ctxCout    :: !Handle
  , ctxLog     :: !(Maybe Handle)
  , ctxVerbose :: !Bool
  , ctxSymEnv  :: !SymEnv
    -- | The handle of the thread writing queries to the SMT solver
  , ctxAsync   :: Async ()
    -- | The next batch of queries to send to the SMT solver
  , ctxTVar    :: TVar Builder
  }
"
Class {
	#name : #SMTContext,
	#superclass : #Object,
	#instVars : [
		'ctxSymEnv',
		'z3'
	],
	#category : #PLE
}

{ #category : #'instance creation' }
SMTContext class >> new [
	self shouldNotImplement
]

{ #category : #'instance creation' }
SMTContext class >> with: aSymEnv [ 
	^self basicNew initializeFromSymEnv: aSymEnv
]

{ #category : #'as yet unclassified' }
SMTContext >> askSMT: e bs: bs [
	| e′ |
	e simplify = Bool true ifTrue: [ ^true ].
	"| null (Vis.kvarsExpr e) = SMT.checkValidWithContext ctx [] PTrue e'
	     can z3 ast contain kvars?? or too late???"
	e′ := self toSMT: e bs: bs.
	^self checkValidWithContext: #() p: Bool true q: e′
]

{ #category : #'as yet unclassified' }
SMTContext >> bracket: aBlockClosure [ 
	^z3 bracket: aBlockClosure
]

{ #category : #'as yet unclassified' }
SMTContext >> checkValidWithContext: xts p: p q: q [
"
checkValidWithContext :: Context -> [(Symbol, Sort)] -> Expr -> Expr -> IO Bool
cf. Interface.hs
"
	xts isEmpty ifFalse: [ self shouldBeImplemented ].
	^self bracket: [
		z3 assert: p & q not.
		z3 check not
	]
]

{ #category : #accessing }
SMTContext >> ctxSymEnv [
	^ ctxSymEnv
]

{ #category : #'as yet unclassified' }
SMTContext >> declare: aSymEnv [
"
declare :: Context -> IO () -- SolveM ()
cf. Smt/Interface.hs
"
	| xts |
	
	^self "BOGUS... only for PLE investigation"
]

{ #category : #'as yet unclassified' }
SMTContext >> del [
	z3 del.
	z3 := nil
]

{ #category : #'as yet unclassified' }
SMTContext >> evalToSMT: e₁_e₂ [
	| e₁ e₂ |
	e₁ := e₁_e₂ key. e₂ := e₁_e₂ value.
	^e₁ === e₂
]

{ #category : #initialization }
SMTContext >> initializeFromSymEnv: aSymEnv [
	z3 := Z3Solver new.
	ctxSymEnv := aSymEnv.
	self declare: aSymEnv
]

{ #category : #'as yet unclassified' }
SMTContext >> smtAssert: aBool [
	z3 assert: aBool
]

{ #category : #'as yet unclassified' }
SMTContext >> toSMT: e bs: bs [
"
toSMT :: String ->  Config -> SMT.Context -> [(Symbol, Sort)] -> Expr -> Pred
"
	| senv elabEnv |
	bs isEmpty ifFalse: [self shouldBeImplemented].
	^e
]
