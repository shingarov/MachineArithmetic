Class {
	#name : #SInfo,
	#superclass : #HornInfo,
	#category : #'MachineArithmetic-Refinement'
}

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
	^Dictionary new. "BOGUS"
	"| iCs rkvars |
	iCs := cm associations.
	^(iCs collect: [ :ass |
		| i c k |
		i := ass key.
		c := ass value.
		k := c crhs kvarsExpr.
		k->i ]) group"
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
	| be_i be i |
	be_i := bs insertVar: x sort: sr top.
	be := be_i key.
	i  := be_i value.
	^i -> (self copy bs: be)
]

{ #category : #'as yet unclassified' }
SInfo >> refine: qcs sorts: genv wfc: w [

bs envCs: w env  . "no use for now"

qcs refineK: #ho env: #() rft: w rft.
	self shouldBeImplemented.
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
	"cf. Solve.hs:solverInfo"
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
	| oldIds newIds fi1 v t k v1 w11 tail su w1 fi11 |
	oldIds := w env indexes.
	oldIds isEmpty ifFalse: [ #accumBindsIfValid shouldBeImplemented ]. newIds := oldIds. fi1 := self.
	
	v := w rft first.
	t := w rft second.
	k := w rft third.
	v1 := v kArgSymbol: k.
	
	w11 := w copy
		env: (IBindEnv from: newIds);
		rft: {v1.t.k.};
		yourself	.
	
	tail := (self kvarDomain: k) collect: [ :x | x -> (x kArgSymbol: k) ].
	su := Dictionary newFromAssociations: {v->v1.}, tail.
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
