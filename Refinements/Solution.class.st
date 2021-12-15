"
sEnv :: !SymEnv                      -- ^ Environment used to elaborate solutions
sMap :: !(M.HashMap KVar a)          -- ^ Actual solution (for cut kvar)
gMap :: !(M.HashMap KVar b)          -- ^ Solution for gradual variables
sHyp :: !(M.HashMap KVar Hyp)        -- ^ Defining cubes  (for non-cut kvar)
sScp :: !(M.HashMap KVar IBindEnv)   -- ^ Set of allowed binders for kvar
sEbd :: !(M.HashMap BindId EbindSol) -- ^ EbindSol for each existential binder
sxEnv :: !(SEnv (BindId, Sort))      --   TODO: merge with sEnv? used for sorts of ebinds to solve ebinds in lhsPred

(cf. Solutions.hs)
"
Class {
	#name : #Solution,
	#superclass : #Object,
	#instVars : [
		'sEnv',
		'sMap',
		'gMap',
		'sHyp',
		'sScp',
		'sEbd',
		'sxEnv',
		'__solverState'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
Solution class >> initialSolution: sInfo kVars: ks [
	"Initial Solution (from Qualifiers and WF constraints).
	cf Solution.hs"
	| senv genv qcs ws keqs ebs xEnv qs_ |
	xEnv := sInfo bs sxEnv.
	genv := sInfo instConstants.
	senv := sInfo symbolEnv.
	ebs := sInfo ebindInfo.
	qs_ := sInfo quals.
	ws := sInfo wsWithin: ks.
	qcs := QCluster of: sInfo quals.
	keqs := ws collect: [ :w | sInfo refine: qcs sorts: genv wfc: w ].
	^Solution basicNew
		sEnv: senv;
		sMap: Dictionary new;
		gMap: keqs;
		sHyp: #();
		sScp: Dictionary new;
		sEbd: ebs;
		sxEnv: xEnv;
		yourself
]

{ #category : #'instance creation' }
Solution class >> new [
	"Answer the unit element of the monoid of solutions."
	^Solution basicNew
		sEnv: SymEnv new;
		sMap: Dictionary new;
		gMap: Dictionary new;
		sHyp: #();
		sScp: Dictionary new;
		sEbd: Dictionary new;
		sxEnv: Dictionary new;
		yourself
]

{ #category : #'as yet unclassified' }
Solution class >> refine: qcs sorts: genv wfc: w [

w env  .


	self shouldBeImplemented.
]

{ #category : #copying }
Solution >> , y [
	| newInstance |
	newInstance := self class basicNew.
	self class instanceVariableNamesDo: [ :iv |
		"Please factor this out to a general structure -- this is not specific to Sol.
		A Cartesian product forms a semigroup if projections each form a semigroup."
		iv = #__solverState ifFalse: "BOGUS, please please refactor this whole shape of dispatching asap"
		[newInstance
			perform: iv,':'
			with: (self perform: iv), (y perform: iv)] ].
	^newInstance
]

{ #category : #bogus }
Solution >> __solverState: anObject [
	__solverState := anObject
]

{ #category : #accessing }
Solution >> gMap [
	^ gMap
]

{ #category : #accessing }
Solution >> gMap: anObject [
	gMap := anObject
]

{ #category : #bogus }
Solution >> isUnsat: aSimpC in: bindingsInSmt [
	| lp rp solver valid |
	lp := self lhsPred: aSimpC in: bindingsInSmt.
	rp := aSimpC rhs evaluateIn: __solverState binds.
	^(Z3Solver isValid: lp ==> rp) not
]

{ #category : #bogus }
Solution >> lhsPred: aSimpC in: bindingsInSmt [
	"Create an actual Z3 predicate expression corresponding to LHS of constraint in current solution."
	| be cEnv |
	be := __solverState binds.
	cEnv := CombinedEnv new 
		ci: aSimpC id;
		bEnv: be;
		iEnv: aSimpC env;
		bindingsInSmt: bindingsInSmt;
		yourself.
	^cEnv apply: self bs: aSimpC env
]

{ #category : #bogus }
Solution >> result: aWorklist in: anIBindEnv [
	^self result_: aWorklist in: anIBindEnv
]

{ #category : #bogus }
Solution >> result_: aWorklist in: anIBindEnv [ 
	| filtered |
	filtered := aWorklist unsatCandidates select: [ :aSimpC | self isUnsat: aSimpC in: anIBindEnv ].
	^filtered size = 0
		ifTrue: [ #Safe ] ifFalse: [ #Unsafe ]
]

{ #category : #accessing }
Solution >> sEbd [
	^ sEbd
]

{ #category : #accessing }
Solution >> sEbd: anObject [
	sEbd := anObject
]

{ #category : #accessing }
Solution >> sEnv [
	^ sEnv
]

{ #category : #accessing }
Solution >> sEnv: anObject [
	sEnv := anObject
]

{ #category : #accessing }
Solution >> sHyp [
	^ sHyp
]

{ #category : #accessing }
Solution >> sHyp: anObject [
	sHyp := anObject
]

{ #category : #accessing }
Solution >> sMap [
	^ sMap
]

{ #category : #accessing }
Solution >> sMap: anObject [
	sMap := anObject
]

{ #category : #accessing }
Solution >> sScp [
	^ sScp
]

{ #category : #accessing }
Solution >> sScp: anObject [
	sScp := anObject
]

{ #category : #accessing }
Solution >> sxEnv [
	^ sxEnv
]

{ #category : #accessing }
Solution >> sxEnv: anObject [
	sxEnv := anObject
]
