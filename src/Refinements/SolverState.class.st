"
--------------------------------------------------------------------------------
-- | Solver Monadic API --------------------------------------------------------
--------------------------------------------------------------------------------

type SolveM = StateT SolverState IO

data SolverState = SS
  { ssCtx     :: !Context          -- ^ SMT Solver Context
  , ssBinds   :: !F.BindEnv        -- ^ All variables and types
  , ssStats   :: !Stats            -- ^ Solver Statistics
  }

Cf. Solver/Monad.hs
"
Class {
	#name : #SolverState,
	#superclass : #Object,
	#instVars : [
		'ssCtx',
		'ssBinds',
		'ssStats'
	],
	#category : #'Refinements-Solver'
}

{ #category : #'instance creation' }
SolverState class >> ssBinds: bs [
	^self basicNew
		ssBinds: bs;
		yourself
]

{ #category : #accessing }
SolverState >> ssBinds [
	^ ssBinds
]

{ #category : #accessing }
SolverState >> ssBinds: anObject [
	ssBinds := anObject
]

{ #category : #accessing }
SolverState >> ssCtx [
	^ ssCtx
]

{ #category : #accessing }
SolverState >> ssCtx: anObject [
	ssCtx := anObject
]

{ #category : #accessing }
SolverState >> ssStats [
	^ ssStats
]

{ #category : #accessing }
SolverState >> ssStats: anObject [
	ssStats := anObject
]
