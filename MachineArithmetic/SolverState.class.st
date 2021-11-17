Class {
	#name : #SolverState,
	#superclass : #Object,
	#instVars : [
		'ctx',
		'binds',
		'stats'
	],
	#category : #'MachineArithmetic-Refinement'
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
	| be concretePreds bindingsInSmt |
	be := self binds.
	concretePreds := be toList
		select: [ :i_s_r |
				| i p |
				i := i_s_r first.
				p := i_s_r third sr_reft expr.
				"(p isConc and: [ p isShortExpr not ]) and: [ (known indexes includes: i) not ]"
				(known indexes includes: i) not ]
		thenCollect: [ :i_s_r |
				| i s sSort v p |
				i := i_s_r first.
				s := be variableNamed: i_s_r second.
				i -> (i_s_r third evaluate: s in: be)
	].
	"BOGUS... known union: blablabla"
	^aBlock value: concretePreds.
]

{ #category : #'as yet unclassified' }
SolverState >> solve_: fi s0: s0 ks: ks wkl: wkl [
	| s1 s2 |
	s1 := fi initialSolution: ks. "cf. Solve.hs"
	s2 := s0, s1. "mappend..."
	^self sendConcreteBindingsToSMT: IBindEnv empty act: [ :bindingsInSmt |
		| s3 |
		s3 := s2. "refine bindingsInSmt s2 wkl"
		s3 __solverState: self. "BOGUS, for now"
		s3 result: wkl in: bindingsInSmt ]
]

{ #category : #accessing }
SolverState >> stats [
	^ stats
]

{ #category : #accessing }
SolverState >> stats: anObject [
	stats := anObject
]
