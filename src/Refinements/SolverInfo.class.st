"
--------------------------------------------------------------------------------
-- | `SolverInfo` contains all the stuff needed to produce a result, and is the
--   the essential ingredient of the state needed by solve_
--------------------------------------------------------------------------------
data SolverInfo a b = SI
  { siSol     :: !(F.Sol b F.QBind)             -- ^ the initial solution
  , siQuery   :: !(F.SInfo a)                   -- ^ the whole input query
  , siDeps    :: !CDeps                         -- ^ dependencies between constraints/ranks etc.
  , siVars    :: !(S.HashSet F.KVar)            -- ^ set of KVars to actually solve for
  }

Cf. Graph/Types.hs
"
Class {
	#name : #SolverInfo,
	#superclass : #Object,
	#instVars : [
		'sol',
		'query',
		'deps',
		'vars'
	],
	#category : #'Refinements-Graph'
}

{ #category : #accessing }
SolverInfo >> deps [
	^ deps
]

{ #category : #solving }
SolverInfo >> initWorklist [
	^Worklist basicNew initializeFrom: self
]

{ #category : #accessing }
SolverInfo >> query [
	^ query
]

{ #category : #accessing }
SolverInfo >> sol [
	^ sol
]

{ #category : #'as yet unclassified' }
SolverInfo >> sol: s query: sInfo deps: cD vars: cKs [
	sol := s.
	query := sInfo.
	deps := cD.
	vars := cKs.
	^self
	
]

{ #category : #accessing }
SolverInfo >> vars [
	^ vars
]
