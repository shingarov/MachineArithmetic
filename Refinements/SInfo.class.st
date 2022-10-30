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
SInfo >> cstrDefs [
"cstrDefs :: F.SInfo a -> [(F.SubcId, F.Symbol)]"
	^cm keysAndValuesCollectMaybe: [ :cid :c |
		| x |
		x := bs cstrDef: c.
		x ifNil: [ nil ] ifNotNil: [ cid -> x ]]
]

{ #category : #'as yet unclassified' }
SInfo >> cut: kI kVars: cKs [
"
cutSInfo :: SInfo a -> KIndex -> S.HashSet KVar -> SInfo a
"
	| cs cm1 ws1 |
	ws1 := ws associationsSelect: [ :k__ | cKs includes: k__ key ].
	cs := (cKs collectAndCat: [ :k | (kI at: k ifAbsent: Set new) asArray ]) asSet.
	cm1 := cm associationsSelect: [ :i_c |
		| i c |
		i := i_c key.
		c := i_c value.
		(cs includes: i) or: [ c isConcC ] ].
	^self copy
		cm: cm1;
		ws: ws1;
		yourself
]

{ #category : #sanitizing }
SInfo >> dropDeadSubsts [
	| kvsM |
	kvsM :=	Dictionary newFromAssociations: (ws keys collect: [ :key | key -> (self kvarDomain: key) ]).
	^self mapKVarSubsts: [ :k :su | 
		| liveVars |
		liveVars := kvsM at: k ifAbsent: [#()].
		su selectByKey: [ :fromSymbol | liveVars includes: fromSymbol "should be ∈" ]]
]

{ #category : #'as yet unclassified' }
SInfo >> ebindDefs [
"ebindDefs :: F.SInfo a -> [(F.BindId, F.SubcId, F.Symbol)]"
	| ebSyms cDefs |
	ebSyms := self ebindSyms.
	cDefs := Dictionary newFromAssociations: self cstrDefs.
	^cDefs keysAndValuesCollectMaybe: [ :cid :x |
		| bid |
		bid := ebSyms at: x ifAbsent: [nil].
		{ bid . cid . x } ]
]

{ #category : #'as yet unclassified' }
SInfo >> ebindInfo [
	| sh |
	sh := self ebindDefs collectTriples: [ :bid :cid :x | bid -> { x . cm at: cid } ].
	^sh groupAssociations collect: [ :val |
		| sym_c |
		val size = 1 ifFalse: [ self shouldBeImplemented ].
		sym_c := val anyOne.
		EbDef cs: {sym_c last} sym: sym_c first ]
]

{ #category : #'as yet unclassified' }
SInfo >> ebindSyms [
	^Dictionary newFromAssociations: (ebinds collect: [ :bi | (bs lookup: bi) key -> bi ])
]

{ #category : #'as yet unclassified' }
SInfo >> eliminatingSolverInfo [
	"Construct a SolverInfo comprising the Solution and various
	 indices needed by the worklist-based refinement loop.
	cf. Eliminate.hs:solverInfo"
| cD sI_ sHyp kHyps kI
  es_cKs_nKs  es cKs nKs
  kS sE ebs |
	es_cKs_nKs := self kutVars. es := es_cKs_nKs first. cKs := es_cKs_nKs second. nKs := es_cKs_nKs third.
	kI := self kIndex.
	sE := self symbolEnv.
	sI_ := self cut: kI kVars: cKs.
	kS := self kvScopes: es.
	ebs := ((ebinds collect: [ :j | bs lookup: j ]) collect: #key) asSet.
	cD := self elimDeps: es nonKutVs: nKs ebs: ebs.
	kHyps := self nonCutHyps: kI nKs: nKs.
	sHyp := sE
		createSolution_kGs: Dictionary new
		kXs: Dictionary new
		kYs: (Dictionary newFromAssociations: kHyps)
		z: kS
		ebs: Dictionary new "sic!"
		xbs: bs sxEnv.
	^SolverInfo basicNew
				sol: sHyp
				query: sI_
				deps: cD
				vars: cKs

]

{ #category : #'as yet unclassified' }
SInfo >> getSubC: i [
"
getSubC :: SInfo a -> Integer -> SimpC a
"
	^cm at: i
]

{ #category : #'as yet unclassified' }
SInfo >> initialSolution: ks [
	^Solution initialSolution: self kVars: ks "cf. S.init cfg fi ks"
]

{ #category : #'as yet unclassified' }
SInfo >> instConstants [
	"obtain a SEnv of Sorts from gLits"
	^gLits rejectByKey: [ :eachKey | eachKey beginsWith: String litPrefix]
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
SInfo >> kvScopes: es [ 
"
kvScopes :: SInfo a -> [CEdge] -> M.HashMap KVar IBindEnv
cf. Eliminate.hs
"
	| CKs KCs kiM |
	CKs := OrderedCollection new.
	KCs := OrderedCollection new.
	es do: [ :e |
		| l r | l := e key. r := e value.
		((r isKindOf: CstrVertex) and: [ l isKindOf: KVarVertex ]) ifTrue: [ KCs add: l kvar -> r id ].
		((l isKindOf: CstrVertex) and: [ r isKindOf: KVarVertex ]) ifTrue: [ CKs add: r kvar -> l id ].
	].
	kiM := (CKs, KCs) groupAssociations.
	^kiM collect: [ :is |
		| senvs |
		senvs := is collect: [ :i | (self getSubC: i) senv ].
		senvs asArray reduceRight: [ :a :b | a intersection: b ] ]
]

{ #category : #'as yet unclassified' }
SInfo >> kvarDomain: k [
	"Compute the domain of a kvar.
	 Answer a collection of var names."
	^bs domain: (self wfc: k)
]

{ #category : #logic }
SInfo >> mapKVarSubsts: aBlock [
	"mapKVarSubsts :: Visitable t => (KVar -> Subst -> Subst) -> t -> t"
	| kvVis |
	kvVis := Visitor defaultTransforming: [ :x | (x isKindOf: PKVar)
		ifTrue: [ PKVar
			var: x var
			subst: (aBlock value: x var value: x s) ]
		ifFalse: [ x ] ].
	^self accept: kvVis
]

{ #category : #visiting }
SInfo >> mapKVars1: f [
	"mapKVars' :: Visitable t => ((KVar, Subst) -> Maybe Expr) -> t -> t"
	| kvVis |
	kvVis := Visitor defaultTransforming: [ :p |
		(p isKindOf: PKVar)
			ifTrue: [
				| p1 |
				p1 := f value: {p var . p s}.
				p1 isNil ifTrue: [ p ] ifFalse: [ p1 subst: p s ] ]
			ifFalse: [ p ] ].
	^self accept: kvVis
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
SInfo >> nonCutHyp: kI k: k [
	| indices cs |
	indices := kI at: k ifAbsent: Set new.
	cs := indices asArray collect: [ :j | self getSubC: j ].
	^cs collect: #nonCutCube
]

{ #category : #'as yet unclassified' }
SInfo >> nonCutHyps: kI nKs: nKs [
	^nKs asArray collect: [ :k | k -> (self nonCutHyp: kI k: k) ]
]

{ #category : #'as yet unclassified' }
SInfo >> refine: qs sorts: genv wfc: w [
"
This is the old way before QCluster:
refine :: F.SInfo a -> [F.Qualifier] -> F.SEnv F.Sort -> F.WfC a -> (F.KVar, Sol.QBind)
cf Solution.hs"
	| env wenv |
	wenv := (Dictionary fromListSEnv: (bs envCs: w env)) collect: #sr_sort.
	env := wenv, genv.
	^qs refineK: self allowHOquals env: env rft: w rft
]

{ #category : #'as yet unclassified' }
SInfo >> remakeSubst: su kvar: k [ 
	^(self kvarDomain: k) inject: su into: [ :substSoFar :sym | substSoFar update: k symbol: sym ]
]

{ #category : #'as yet unclassified' }
SInfo >> remakeSubsts [
	^self mapKVarSubsts: [ :kvar :subst | self remakeSubst: subst kvar: kvar ]
]

{ #category : #sanitizing }
SInfo >> replaceDeadKvars [
	"Replace KVars that do not have a WfC with PFalse.
	replaceDeadKvars :: SInfo -> SInfo"
	^self mapKVars: [ :k | (ws includesKey: k) ifTrue: [ nil ] ifFalse: [ DecidableRefinement never ] ]
]

{ #category : #sanitizing }
SInfo >> sanitize [
	| san |
	san := self replaceDeadKvars.
	^san dropDeadSubsts "BOGUS...and others"
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
	"Answer a SymEnv which contains the Sort of every variable in the receiver.
	 Cf. Sanitize.hs"
	| xts sEnv |
	"BOGUS.  We are implementing as little as we can get away with, for now."
	xts := self symbolSorts "++ alits".
	sEnv := SEnv newFromAssociations: xts. "++ theorySymbols ddecls tsSort"
	^SymEnv xEnv: sEnv fEnv: #bogus ds: #bogus ls: #bogus  ts: #bogus
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
