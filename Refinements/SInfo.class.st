Class {
	#name : #SInfo,
	#superclass : #HornInfo,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
SInfo >> accumBinds: k ids: ids i: i [
	| oldSym_sr oldSym sr newSym i1_fi1 i1 fi1 |
	oldSym_sr := bs lookup: i.
	oldSym := oldSym_sr key.
	sr := oldSym_sr value.
	newSym := oldSym kArgSymbol: k.
	i1_fi1 := self newTopBind: newSym to: sr.
	i1 := i1_fi1 key.
	fi1 := i1_fi1 value.
	^fi1 -> ({i1},ids)
]

{ #category : #logic }
SInfo >> accumBindsIfValid: k ids: ids i: i [
"accumBindsIfValid :: KVar -> (SInfo a, [BindId]) -> BindId -> (SInfo a, [BindId])"
	| sr renamable |
	sr := (bs lookup: i) value.
	renamable := true "sr sr_sort isValidInRefinements   TODO see UniqifyKVars.hs".
	^renamable
		ifTrue: [ self accumBinds: k ids: ids i: i ]
		ifFalse: [ self shouldBeImplemented ]
]

{ #category : #'as yet unclassified' }
SInfo >> cut: kIndex kVars: setOfKVarNames [
	"BOGUS"
	"ok for now because ws was already cut before"
	^self
]

{ #category : #'as yet unclassified' }
SInfo >> dropDeadSubsts [
	| kvsM |
	kvsM :=	Dictionary newFromAssociations: (ws keys collect: [ :key | key -> (self kvarDomain: key) ]).
	^self mapKVarSubsts: [ :k :su | 
		| liveVars |
		liveVars := kvsM at: k ifAbsent: [#()].
		su select: [ :fromSymbol :toExpr | liveVars includes: fromSymbol "should be ∈" ]]
]

{ #category : #'as yet unclassified' }
SInfo >> ebindInfo [
	"BOGUS"
	^#()
]

{ #category : #'as yet unclassified' }
SInfo >> eliminatingSolverInfo [
	"Construct a SolverInfo comprising the Solution and various
	 indices needed by the worklist-based refinement loop.
	cf. Eliminate.hs:solverInfo"
| cD sI_ sHyp kHyps kI
  es_cKs_nKs  es cKs nKs
  kS sE ebs |
	es_cKs_nKs := self kutVars.
	es := es_cKs_nKs first.
	cKs := es_cKs_nKs second.
	nKs := es_cKs_nKs third.
	kI := self kIndex.
	sE := self symbolEnv.
	sI_ := self cut: kI kVars: cKs.
	kS := #(). "BOGUS. kS := kvScopes sI es"
	ebs := #(). "BOGUS. ebs := S.fromList $ fst <$> flip lookupBindEnv (bs sI) <$> (ebinds sI)"
	cD := self elimDeps: es nonKutVs: nKs ebs: ebs.
	kHyps := #(). "nonCutHyps   sI kI nKs"
	sHyp := Solution basicNew "sHyp = Sol.fromList sE mempty mempty kHyps kS [] $ fromListSEnv [ (x, (i, sr_sort sr)) | (i,x,sr) <- bindEnvToList (bs sI)]"
		sEnv: sE;
		sMap: Dictionary new;
		gMap: Dictionary new;
		sHyp: kHyps;
		sScp: kS;
		sEbd: Dictionary new;
		sxEnv: bs sxEnv;
		yourself.
	^SolverInfo basicNew
				sol: sHyp
				query: sI_
				deps: cD
				vars: cKs

]

{ #category : #'as yet unclassified' }
SInfo >> initialSolution: ks [
	^Solution initialSolution: self kVars: ks "cf. S.init cfg fi ks"
]

{ #category : #'as yet unclassified' }
SInfo >> instConstants [
	"obtain a SEnv of Sorts from gLits"
	gLits isNil ifFalse: [ self shouldBeImplemented ].
	^nil
]

{ #category : #'as yet unclassified' }
SInfo >> kIndex [
	"Map each `KVar` to the list of constraints on which it appears on RHS.
	type KIndex = M.HashMap KVar [Integer]
	kIndex     :: SInfo a -> KIndex
	"
	| iCs b |
	iCs := cm associations.
	b := iCs collectAndCat: [ :ass |
		| i c rkvars |
		i := ass key.
		c := ass value.
		rkvars := c crhs kvarsExpr asArray.
		rkvars collect: [ :k | k->i ] ].
	^b groupAssociations 
]

{ #category : #logic }
SInfo >> kVars [
	^ws keys asSet
]

{ #category : #'as yet unclassified' }
SInfo >> kutVars [
	| es_ds es ds |
	es_ds := self elimVars.
	es := es_ds key.
	ds := es_ds value.
	^{es. ds depCuts. ds depNonCuts.}
]

{ #category : #'as yet unclassified' }
SInfo >> kvarDomain: k [
	"Compute the domain of a kvar.
	 Answer a collection of var names."
	^bs domain: (self wfc: k)
]

{ #category : #logic }
SInfo >> mapKVarSubsts: aBlock [
	"NB: this should be factored into a visitor and KVar-specific part"
	bs := bs mapKVarSubsts: aBlock.
	cm := cm collect: [ :c | c mapKVarSubsts: aBlock ]. "and not do it destructively!!!"
	^self
]

{ #category : #'as yet unclassified' }
SInfo >> newTopBind: x to: sr [ 
	| i_be be i |
	i_be := bs insertVar: x sort: sr top.
	i  := i_be key.
	be := i_be value.
	^i -> (self copy bs: be)
]

{ #category : #'as yet unclassified' }
SInfo >> refine: qcs sorts: genv wfc: w [
"cf Solution.hs"
	| env wenv |
	genv isNil ifFalse: [ self shouldBeImplemented ].
	
	wenv := (Dictionary fromListSEnv: (bs envCs: w env)) collect: #sr_sort.
	env := wenv. ", genv"
	^qcs refineK: self allowHOquals env: env rft: w rft
]

{ #category : #'as yet unclassified' }
SInfo >> remakeSubst: su kvar: k [ 
	^(self kvarDomain: k) inject: su into: [ :substSoFar :sym | substSoFar update: k symbol: sym ]
]

{ #category : #'as yet unclassified' }
SInfo >> remakeSubsts [
	^self mapKVarSubsts: [ :kvar :subst | self remakeSubst: subst kvar: kvar ]
]

{ #category : #'as yet unclassified' }
SInfo >> sanitize [
	^self dropDeadSubsts "BOGUS...and others"
]

{ #category : #logic }
SInfo >> solve [
	| fi si wkl s0 ks act |
	fi := self.
	si := fi solverInfo.
	
	wkl := si initWorklist.
	s0 := si sol.
	ks := si vars.
	act := [ :solverState | solverState solve_: self s0: s0 ks: ks wkl: wkl ].
	^si runSolverM: act
]

{ #category : #logic }
SInfo >> solverInfo [
	"cf. Solver/Solve.hs:solverInfo"
	^options eliminate useElim
		ifTrue: [ self eliminatingSolverInfo ]
		ifFalse: [
			| cD |
			cD := self elimDeps: self kvEdges nonKutVs: #() ebs: #().
			^SolverInfo basicNew
				sol: Solution new
				query: self
				deps: cD
				vars: self kVars ]
]

{ #category : #logic }
SInfo >> symbolEnv [
	"Answer a SymEnv"
	"cf. Sanitize.hs"
	^SymEnv new "IMPLEMENT NOW!" 
]

{ #category : #'as yet unclassified' }
SInfo >> updateWfc: w [
	"updateWfc :: SInfo a -> WfC a -> SInfo a
	cf. UniqifyKVars.hs"
	| oldIds fi_newIds newIds fi1 v t k v1 w11 tail su w1 fi11 |
	oldIds := w env indexes.
	v := w rft first.
	t := w rft second.
	k := w rft third.
	fi_newIds := oldIds inject: self->{} into: [ :soFar :eachId |
		soFar key accumBindsIfValid: k ids: soFar value i: eachId ].
	fi1 := fi_newIds key.
	newIds := fi_newIds value.
	v1 := v kArgSymbol: k.
	w11 := w copy
		env: (IBindEnv from: newIds);
		rft: {v1.t.k};
		yourself	.
	tail := (self kvarDomain: k) collect: [ :x | x -> (x kArgSymbol: k) ].
	su := Dictionary newFromAssociations: {v->v1}, tail.
	w1 := w11 updateWfCExpr: su.
	fi11 := (fi1 newTopBind: v1 to: t trueSortedReft) value.
	fi11 ws: (ws copy at: k put: w1; yourself).
	^fi11
]

{ #category : #'as yet unclassified' }
SInfo >> updateWfcs [
	^ws inject: self into: [ :sInfoSoFar :eachWfC | sInfoSoFar updateWfc: eachWfC ]
]

{ #category : #'as yet unclassified' }
SInfo >> wfcUniqify [
	^self remakeSubsts updateWfcs
]

{ #category : #'as yet unclassified' }
SInfo >> ws: wfDictionary [ 
	ws := wfDictionary.
	^self
]

{ #category : #'as yet unclassified' }
SInfo >> wsWithin: ks [
	^ws associations select: [ :k_w | ks includes: k_w key "and: w isn't GWfc" ] thenCollect: #value.
]
