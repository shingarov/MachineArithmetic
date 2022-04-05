Class {
	#name : #CombinedEnv,
	#superclass : #Object,
	#instVars : [
		'ci',
		'bEnv',
		'iEnv',
		'bindingsInSmt'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
CombinedEnv class >> mrExprInfos: mF _: erF _: irF _: xs [
"mrExprInfos :: (a -> (b, c)) -> ([b] -> b1) -> ([c] -> c1) -> [a] -> (b1, c1)
cf. Solver/Solution.hs"
	| exprInfos es is |
	exprInfos := xs collect: mF.
	es := exprInfos collect: #expr.
	is := exprInfos collect: #kInfo.
	^{ erF value: es . irF value: is }
]

{ #category : #'as yet unclassified' }
CombinedEnv >> addCEnv: bs_ [
"
addCEnv :: CombinedEnv -> F.IBindEnv -> CombinedEnv
"
	^self copy 
		iEnv: (iEnv union: bs_);
		yourself
]

{ #category : #'as yet unclassified' }
CombinedEnv >> apply: aSolution bs: anIBindEnv [ 
"CombinedEnv -> Sol.Sol a Sol.QBind -> F.IBindEnv -> ExprInfo

    -- Clear the 'known' bindings for applyKVars, since it depends on
    -- using the fully expanded representation of the predicates to bind their
    -- variables with quantifiers.
    (pks, kI)     = applyKVars g {ceBindingsInSmt = F.emptyIBindEnv} s ks
    (ps,  ks, _)  = envConcKVars g s bs

cf. Solver/Solution.hs
"
	| ps_ks__ ps ks pks_kI preds pks kI |
	ps_ks__ := self concKVars: aSolution _: anIBindEnv .
	ps := ps_ks__ first.
	ks := ps_ks__ second.
	pks_kI := self withoutBindingsInSmt applyKVars: aSolution _: ks.
	pks := pks_kI expr.
	kI := pks_kI kInfo.
	^ExprInfo
		expr: (Bool and: {pks}, ps)
		kInfo: kI
	"appears like at the Hackathon, the following code was transforming them into Z3 Bools:
	
	preds := anIBindEnv indexes collect: [ :i |
		(Dictionary newFromAssociations: bindingsInSmt) at: i ].
	^Bool and: preds asArray"
]

{ #category : #'as yet unclassified' }
CombinedEnv >> applyKVar: aSolution _: kvSub [
"CombinedEnv -> Sol.Sol a Sol.QBind -> F.KVSub -> ExprInfo"
	| either |
	either := aSolution lookup: kvSub kVar.
	^either
		left: [ :cs | self hypPred: aSolution _: kvSub _: cs ]
		right: [ :eqs |
			| preds |
			preds := aSolution qbPreds: kvSub subst qBind: eqs.
			preds := preds collect: #first.
			ExprInfo
				expr: (Bool and: preds asArray) simplify
				kInfo: KInfo new
		]
]

{ #category : #'as yet unclassified' }
CombinedEnv >> applyKVars: s _: kvSubs [
	"applyKVars :: CombinedEnv -> Sol.Sol a Sol.QBind -> [F.KVSub] -> ExprInfo
here type ExprInfo    = (F.Expr, KInfo)
cf. Solution.hs"
	| pair |
	pair := self class mrExprInfos: [ :ksu | self applyKVar: s _: ksu ]
		_: [ :x | (Bool and: x) simplify ] _: [ :x | x inject: KInfo new into: [ :soFar :thisSubcollection | soFar, thisSubcollection ] ] _: kvSubs.
	^ExprInfo expr: pair first kInfo: pair last
]

{ #category : #accessing }
CombinedEnv >> bEnv [
	^ bEnv
]

{ #category : #accessing }
CombinedEnv >> bEnv: anObject [
	bEnv := anObject
]

{ #category : #accessing }
CombinedEnv >> bindingsInSmt [
	^ bindingsInSmt
]

{ #category : #accessing }
CombinedEnv >> bindingsInSmt: anObject [
	bindingsInSmt := anObject
]

{ #category : #accessing }
CombinedEnv >> ci [
	^ ci
]

{ #category : #accessing }
CombinedEnv >> ci: anObject [
	ci := anObject
]

{ #category : #'as yet unclassified' }
CombinedEnv >> concKVars: s _: bs [ 
"envConcKVars :: CombinedEnv -> Sol.Sol a Sol.QBind -> F.IBindEnv -> ([F.Expr], [F.KVSub], [F.KVSub])"
	| is xrs pss_kss_gss pss kss gss |
	is := bs elems.
	xrs := is collect: [ :i | self lookupBindEnvExt: s _: i ].
	pss_kss_gss := (xrs collect: [ :x_sr | x_sr value concKVars: x_sr key bindingsInSmt: bindingsInSmt ]) unzip: 3.
	pss := pss_kss_gss first concat.
	kss := pss_kss_gss second concat.
	gss := pss_kss_gss third concat. "concat will be removed here!!!"
	gss isEmpty ifFalse: [ self shouldBeImplemented "L.nubBy (\x y -> F.ksuKVar x == F.ksuKVar y) $ concat gss" ].
	^{ pss . kss . gss }
]

{ #category : #'as yet unclassified' }
CombinedEnv >> cubePred: s _: ksu _: c [
"
cubePred :: CombinedEnv -> Sol.Sol a Sol.QBind -> F.KVSub -> Sol.Cube -> ExprInfo
"
	| k bs bs1 xts_psu_p_kI  xts psu p kI |
	k := ksu kVar.
	bs := c binds.
	bs1 := s delCEnv: k _: bs.
	xts_psu_p_kI := self cubePredExc: s _: ksu _: c _: bs1.
	xts := xts_psu_p_kI first first.
	psu := xts_psu_p_kI first second.
	p := xts_psu_p_kI first third.
	kI := xts_psu_p_kI second.
	
	^ExprInfo
		expr: (s elabExist: xts p: psu & p)
		kInfo: kI
]

{ #category : #'as yet unclassified' }
CombinedEnv >> cubePredExc: s _: ksu _: c _: bs1 [
	"Compute the predicate for the subset of binders bs'.
--   The output is a tuple, `(xts, psu, p, kI)` such that the actual predicate
--   we want is `Exists xts. (psu /\ p)`."
	| su1 bs yts1 g1 p1_kI k sEnv ___psu1 su xts_psu existPred |
	su1 := c subst.
	bs := c binds.
	yts1 := self symZ3consts: bs1.
	g1 := self addCEnv: bs.
	p1_kI := g1 apply: s bs: bs1.
	k := ksu kVar.
	sEnv := #sEnv.
	___psu1 := s sEnv substElim: sEnv combEnv: g1 kVar: k subst: su1.
	su := ksu subst.
	xts_psu := s sEnv substElim: sEnv combEnv: self kVar: k subst: su.
	existPred := s elabExist: yts1 p: p1_kI expr & ___psu1 last.
	^{
	xts_psu, {existPred}.
	p1_kI kInfo   "TODO: extendKInfo kI (Sol.cuTag c))"
	}
]

{ #category : #'as yet unclassified' }
CombinedEnv >> ebSol: s _: i [
"CombinedEnv -> Sol.Sol a Sol.QBind -> F.BindId -> Maybe F.Expr"
	| sebds es |
	sebds := s sEbd.
	es := sebds at: i ifAbsent: [ ^nil ].
	(es isKindOf: EbDef) ifTrue: [
		| cs cSols |
		cs := es cs.
		cSols := cs collect: [ :c | c id = ci
			ifTrue: [ Bool false ]
			ifFalse: [ | s_ |
				s_ := s copy sEbd: (sebds copy at: i put: EbIncr new; yourself); yourself.
				s_ ebReft: i c: c combEnv: self	 ] ].
		^Bool and: cSols ].
	(es isKindOf: EbSol) ifTrue: [ self shouldBeImplemented ].
	^nil
]

{ #category : #'as yet unclassified' }
CombinedEnv >> ebindReft: s simpC: c [
	| bs g_ |
	bs := c senv.
	g_ := self copy
		iEnv: bs;
		ci: c id;
		yourself.
	^(g_ apply: s bs: bs) expr & c crhs
]

{ #category : #'as yet unclassified' }
CombinedEnv >> hypPred: s _: ksu _: hyp [
"
hypPred :: CombinedEnv -> Sol.Sol a Sol.QBind -> F.KVSub -> Sol.Hyp  -> ExprInfo
"
	| preds |
	preds := hyp collect: [ :aCube | self cubePred: s _: ksu _: aCube ].
	^preds fold: [ :p :q | p ⊕ q ]
]

{ #category : #accessing }
CombinedEnv >> iEnv [
	^ iEnv
]

{ #category : #accessing }
CombinedEnv >> iEnv: anObject [
	iEnv := anObject
]

{ #category : #'as yet unclassified' }
CombinedEnv >> lookupBindEnvExt: s _: i [
"CombinedEnv -> Sol.Sol a Sol.QBind -> F.BindId -> (F.Symbol, F.SortedReft)
cf. Solver/Solution.hs"
	| x_sr x sr p |
	x_sr := bEnv lookup: i.
	x := x_sr key.
	sr := x_sr value.
	p := self withoutBindingsInSmt ebSol: s _: i.
	p isNil ifFalse: [
		sr := sr copy sr_reft: (Reft symbol: x expr: p); yourself.
		^x->sr ].
	(bindingsInSmt includesKey: i) ifTrue: [
		| eVar |
		eVar := DefineFun of: i in: bindingsInSmt.
		"eVar := bindingsInSmt at: i."
		sr := sr copy sr_reft: (Reft symbol: x expr: eVar); yourself ].
	^x->sr
]

{ #category : #'as yet unclassified' }
CombinedEnv >> symSorts: bs [
"
symSorts :: CombinedEnv -> F.IBindEnv -> [(F.Symbol, F.Sort)]
"
	^(bEnv envCs: bs) collect: [ :k_v |
		| k v |
		k := k_v key. v := k_v value.
		k -> v sr_sort
	]
	

]

{ #category : #'as yet unclassified' }
CombinedEnv >> symZ3consts: bs [
"
symSorts :: CombinedEnv -> F.IBindEnv -> [(F.Symbol, F.Sort)]
"
	^(bEnv envCs: bs) collect: [ :k_v |
		| k |
		k := k_v key.
		(FxEVar of: k) evaluateIn: bEnv evalEnv
	]
	

]

{ #category : #'as yet unclassified' }
CombinedEnv >> withoutBindingsInSmt [
	^self copy bindingsInSmt: (Dictionary new); yourself 
]
