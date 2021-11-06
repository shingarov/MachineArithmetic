Class {
	#name : #Solution,
	#superclass : #Object,
	#instVars : [
		'solverState'
	],
	#category : #'MachineArithmetic-Refinement'
}

{ #category : #solving }
Solution >> isUnsat: aSimpC in: bindingsInSmt [
	| lp rp solver valid |
	lp := self lhsPred: aSimpC in: bindingsInSmt.
	rp := aSimpC rhs evaluateIn: solverState binds.
	^(Z3Solver isValid: lp ==> rp) not
]

{ #category : #solving }
Solution >> lhsPred: aSimpC in: bindingsInSmt [
	"Create an actual Z3 predicate expression corresponding to LHS of constraint in current solution."
	| be cEnv |
	be := solverState binds.
	cEnv := CombinedEnv new 
		ci: aSimpC id;
		bEnv: be;
		iEnv: aSimpC env;
		bindingsInSmt: bindingsInSmt;
		yourself.
	^cEnv apply: self bs: aSimpC env
]

{ #category : #solving }
Solution >> result: aWorklist in: anIBindEnv [
	^self result_: aWorklist in: anIBindEnv
]

{ #category : #solving }
Solution >> result_: aWorklist in: anIBindEnv [ 
	| filtered |
	filtered := aWorklist unsatCandidates select: [ :aSimpC | self isUnsat: aSimpC in: anIBindEnv ].
	^filtered size = 0
		ifTrue: [ #Safe ] ifFalse: [ #Unsafe ]
]

{ #category : #accessing }
Solution >> solverState [
	^ solverState
]

{ #category : #accessing }
Solution >> solverState: anObject [
	solverState := anObject
]
