Extension { #name : #BlockClosure }

{ #category : #'*Refinements' }
BlockClosure >> runCM0 [
	^self runReader: #incrementer initialState: {42}
]

{ #category : #'*Refinements' }
BlockClosure >> runHotel [
	^self runReader: #hotel initialState: Hotel new
]

{ #category : #'*Refinements' }
BlockClosure >> runSolverM: aSolverInfo [ 
	| be fi s0 res |
	fi := aSolverInfo query.
	be := fi bs.
	s0 := SolverState ssBinds: be. "BOGUS: assumesAxioms and all SMT stuff"
	res := self runReader: #solverState initialState: s0.
	^res
]
