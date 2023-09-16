Class {
	#name : #SInfo,
	#superclass : #HornInfo,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
SInfo >> accumBinds: k ids: ids i: i [
	| oldSym_sr oldSym sr newSym i′_fi′ i′ fi′ |
	oldSym_sr := bs lookup: i.
	oldSym := oldSym_sr key.
	sr := oldSym_sr value.
	newSym := oldSym kArgSymbol: k.
	i′_fi′ := self newTopBind: newSym to: sr.
	i′ := i′_fi′ key. 	fi′ := i′_fi′ value.
	^fi′ -> ({i′}, ids)
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

{ #category : #sanitizing }
SInfo >> badParams: c [
"
badParams :: F.SInfo a -> F.SimpC a -> KvBads
"
	| xsrs sEnv bads |
	xsrs := bs envCs: c senv.
	sEnv := xsrs collect: #key.
	bads := (c subcKSubs: xsrs) collectTriples: [ :v :k :su |
				| vEnv |
				vEnv := v
					ifNil: [ sEnv ] ifNotNil: [ sEnv insert: v ].
				su associations select: [ :x_e | x_e value badArg: vEnv ] thenCollect: [ :xe | k -> xe key ] ].
	bads := bads concat. "this should be renamed to #join"
	^bads groupAssociations as: KVBads
]

{ #category : #'as yet unclassified' }
SInfo >> compile [
	"Destructively replace all DecidableRefinements with compiled expressions."
	| γ |
	γ := EvalEnv ofSorts: self symbolEnv sort.
	cm do: [ :eachC | eachC compileIn: γ ].
	bs compileIn: γ.
	quals := quals collect: [ :eachQ | eachQ evaluateIn: γ ]
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
	| cs cm′ ws′ |
	ws′ := ws associationsSelect: [ :k__ | cKs includes: k__ key ].
	cs := (cKs collectAndCat: [ :k | (kI at: k ifAbsent: Set new) asArray ]) asSet.
	cm′ := cm associationsSelect: [ :i_c |
		| i c |
		i := i_c key.
		c := i_c value.
		(cs includes: i) or: [ c isConcC ] ].
	^self copy
		cm: cm′;
		ws: ws′;
		yourself
]

{ #category : #'as yet unclassified' }
SInfo >> doPLE: subcIds [
"
doPLE :: (F.Loc a) =>  Config -> F.SInfo a -> [F.SubcId] -> SolveM ()
                                 fi0=self      subcIds
"
	| fi fi′ sI s |
	fi := self instantiate: subcIds.
	sI := fi solverInfo.
	fi′ := sI query.
	
	"now modify the SolverState's ssBinds -- but we got rid of SolverState!!!"
	s := thisContext sender receiver. "the Solution"
	s __binds: fi′ bs.
	^nil
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

{ #category : #sanitizing }
SInfo >> dropKvarEnv: kve _: c [
"
dropKvarEnv :: Fixpoint a => F.SInfo a -> KvDom -> F.SimpC a -> KvDom
"
	| kBads |
	kBads := self badParams: c.
	^kve keysAndValuesCollect: [ :k :v | k -> (kBads dropBadParams: k _: v) ]
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

{ #category : #Elaborate }
SInfo >> elaborate [
	^self elaborate: self symbolEnv
]

{ #category : #Elaborate }
SInfo >> elaborate: γ [
"
class Elaborate a where
  elaborate :: Located String -> SymEnv -> a -> a

instance (Loc a) => Elaborate (SInfo a) where
  ...
Cf. SortCheck.hs
"
	cm do: [ :eachC | eachC elaborate: γ ].
	bs elaborate: γ.
	"TODO: asserts elaborate"

	gLits := gLits keysAndValuesCollect: [ :k :v | k -> (γ naturalTransformationFor: k) ]. "Peculiar to Smalltalk"

	"don't elaborate quals until later in qbPreds (cf. Solutions.hs),
	 because of the #subst."

	^self
]

{ #category : #'as yet unclassified' }
SInfo >> eliminatingSolverInfo [
	"Construct a SolverInfo comprising the Solution and various
	 indices needed by the worklist-based refinement loop.
	 solverInfo :: Config -> SInfo a -> SolverInfo a b
	 cf. Eliminate.hs
	
	 Caveat programmator: There are two solverInfo's in LF and
	 it's easy to confuse them.  This one is from Solver/Eliminate.hs,
	 the other one (our sender, called #solverInfo) is from Solver/Solve.hs"
| cD sI′ sHyp kHyps kI
  es_cKs_nKs  es cKs nKs
  kS sE ebs |
	es_cKs_nKs := self kutVars. es := es_cKs_nKs first. cKs := es_cKs_nKs second. nKs := es_cKs_nKs third.
	kI := self kIndex.
	sE := self symbolEnv.
	sI′ := self cut: kI kVars: cKs.
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
				query: sI′
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

{ #category : #sanitizing }
SInfo >> initEnv: w [
"
initEnv :: F.SInfo a -> F.WfC a -> F.SEnv F.BindId
"
	| is |
	is := w env elems.
	^SEnv newFromAssociations: (is collect: [ :i | (bs lookup: i) key -> i ])
]

{ #category : #sanitizing }
SInfo >> initKvarEnv [
"
initKvarEnv :: F.SInfo a -> KvDom
"
	^(ws collect: [ :each | self initEnv: each ]) as: KVDom
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
SInfo >> instantiate: subcIds [
	"Strengthen Constraint Environments via PLE.

instantiate :: (Loc a) => Config -> SInfo a -> Maybe [SubcId] -> IO (SInfo a)
                           cfg      fi′=self      subcIds
Cf. PLE.hs (NOT Instantiate.hs which is the old one and doesn't pass ple0 test!)
"
	| aEnv cs fi t res sEnv |
	fi := self normalize.
	aEnv := fi ae.
	cs := fi cm associations selectAssociations: [ :i :c | (aEnv isPleCstr: c sid: i) and: [
			subcIds ifNil: [ True ] ifNotNil: [ subcIds includes: i ] ] ].
	
	"1. BUILD the Trie"
	t := CTrie mkCTrie: cs.
	
	"2. TRAVERSE Trie to compute InstRes"
	res := t pleTrie: (fi instEnv: cs).
	res savePLEEqualities: fi.
	
	"3. STRENGTHEN SInfo using InstRes"
	sEnv := fi symbolEnv.
	^res resSInfo: fi symEnv: sEnv
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
SInfo >> mapKVars′: f [
	"mapKVars' :: Visitable t => ((KVar, Subst) -> Maybe Expr) -> t -> t"
	| kvVis |
	kvVis := Visitor defaultTransforming: [ :p |
		(p isKindOf: PKVar)
			ifTrue: [
				| p′ |
				p′ := f value: {p var . p s}.
				p′ isNil ifTrue: [ p ] ifFalse: [ p′ subst: p s ] ]
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
refine :: F.SInfo a -> [F.Qualifier] -> F.SEnv F.Sort -> F.WfC a -> (F.KVar, Sol.QBind)  -- before 015953eabb6f9
refine :: F.SInfo a -> QCluster      -> F.SEnv F.Sort -> F.WfC a -> (F.KVar, Sol.QBind)  -- after  015953eabb6f9
          fi=self      qs               genv             w
The body of the function is unchanged.
cf Solution.hs
"
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
SInfo >> restrictKVarDomain [
	| kvm |
	kvm := self safeKvarEnv.
	ws keysAndValuesDo: [ :k :v | k -> (kvm restrictWf: k wfc: v) ]
]

{ #category : #sanitizing }
SInfo >> safeKvarEnv [
	"Compute the 'real' domain of each kvar, which is
	 a SUBSET of the input domain, in which we KILL the parameters
	 `x` which appear in substitutions of the form `K[x := y]`
	 where `y` is not in the env.
	
	safeKvarEnv :: F.SInfo a -> KvDom"
	
	| cs env₀ |
	env₀ := self initKvarEnv.
	cs := cm values.
	^cs inject: env₀ into: [ :envSoFar :thisC | self dropKvarEnv: envSoFar _: thisC ]
]

{ #category : #sanitizing }
SInfo >> sanitize [
	^self replaceDeadKvars
		restrictKVarDomain
			dropDeadSubsts "TODO: the rest"
]

{ #category : #'SMT interface' }
SInfo >> smt2 [
	| γ |
	γ := self symbolEnv .
	γ naturalTransformations: gLits.
	γ aggregateNTs.
	cm do: [ :eachC | eachC smt2: γ ].
	bs smt2: γ.
]

{ #category : #logic }
SInfo >> solve [
	| fi si wkl s₀ ks |
	fi := self.
	si := fi solverInfo.
	
	wkl := si initWorklist.
	s₀ := si sol.
	ks := si vars.
	s₀ __binds: bs.
	^s₀ solve_: self ks: ks wkl: wkl
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
	symbolEnv :: Config -> F.SInfo a -> F.SymEnv
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
