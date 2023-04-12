Class {
	#name : #SolverState,
	#superclass : #Object,
	#instVars : [
		'ctx',
		'binds',
		'stats'
	],
	#category : #Refinements
}

{ #category : #accessing }
SolverState >> binds [
	^ binds
]

{ #category : #accessing }
SolverState >> binds: anObject [
	binds := anObject
]

{ #category : #accessing }
SolverState >> ctx [
	^ ctx
]

{ #category : #accessing }
SolverState >> ctx: anObject [
	ctx := anObject
]

{ #category : #'as yet unclassified' }
SolverState >> sendConcreteBindingsToSMT: known act: aBlock [
"Takes the environment of bindings already known to the SMT,
  -- and the environment of all bindings that need to be known.
  --
  -- Yields the ids of bindings known to the SMT

F.IBindEnv -> (F.IBindEnv -> SolveM a) -> SolveM a
cf. Monad.hs"
"this does not belong here... should this be in IBindEnv?"
	| concretePreds bindingsInSmt |
	concretePreds := (binds withoutIndexes: known indexes) concretePreds.

	"BOGUS... known union: blablabla"
	^aBlock value: concretePreds.
]

{ #category : #'as yet unclassified' }
SolverState >> solve_: fi s0: s0 ks: ks wkl: w [
"cf. Solver/Solve.hs.
This method shouldn't be on SolverState: # ignores self"
	| s1 s2 |
	s1 := fi initialSolution: ks. "cf. Solve.hs"
	s2 := s0, s1. "mappend..."
	binds compile.
	s2 __solverState: self.
	w compileIn: binds.
	^self sendConcreteBindingsToSMT: IBindEnv empty act: [ :bindingsInSmt |
		| s3 |
		s3 := s2 refine: bindingsInSmt worklist: w     . "refine bindingsInSmt s2 wkl"
		s3 __solverState: self. "BOGUS, for now"
		s3 result: w in: bindingsInSmt ]
]

{ #category : #accessing }
SolverState >> stats [
	^ stats
]

{ #category : #accessing }
SolverState >> stats: anObject [
	stats := anObject
]
