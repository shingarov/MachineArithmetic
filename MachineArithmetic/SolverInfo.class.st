"
I contain all the stuff needed to produce a result,
I am the the essential ingredient of the state needed by solve_.

siSol     :: !(F.Sol b F.QBind)             -- ^ the initial solution
siQuery   :: !(F.SInfo a)                   -- ^ the whole input query
siDeps    :: !CDeps                         -- ^ dependencies between constraints/ranks etc.
siVars    :: !(S.HashSet F.KVar)            -- ^ set of KVars to actually solve for

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
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #accessing }
SolverInfo >> deps [
	^ deps
]

{ #category : #solving }
SolverInfo >> initWorklist [
	^Worklist basicNew initializeFrom: self
]

{ #category : #solving }
SolverInfo >> initializeFrom: aSInfo [ 
	query := aSInfo.
	deps := aSInfo elimDeps: aSInfo kvEdges nonKutVs: #() ebs: #().
	vars := aSInfo kVars.
	sol := Solution new. "BOGUS. How does *this* work???"
	^self
]

{ #category : #accessing }
SolverInfo >> query [
	^ query
]

{ #category : #solving }
SolverInfo >> runSolverM: actBlock [
	| fi s0 be initEnv acquire act1 |
	fi := self query copy. "{F.hoInfo = F.HOI (C.allowHO cfg) (C.allowHOqs cfg)}; see Monad.hs"
	be := fi bs.
	initEnv := fi symbolEnv.
	acquire := initEnv makeContextWithSEnv.
	s0 := SolverState new.
	s0 ctx: acquire.
	s0 binds: be.
	act1 := actBlock. "assumesAxioms...."
	^act1 value: s0
]

{ #category : #accessing }
SolverInfo >> sol [
	^ sol
]

{ #category : #accessing }
SolverInfo >> vars [
	^ vars
]
