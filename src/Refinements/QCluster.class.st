"
type QCluster = M.HashMap QCSig [Qualifier]
"
Class {
	#name : #QCluster,
	#superclass : #Dictionary,
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
QCluster class >> candidatesP: env _: tyss _: x [
"
candidatesP :: So.Env -> [(SortIdx, F.Sort, a)] -> F.QualParam -> [(So.TVSubst, SortIdx, QualPattern)]
               env       tyss                      x
"
	| xt qPat mono |
	xt := x sort.
	qPat := x pattern.
	mono := xt isMono.
	^(tyss collectTriples: [ :idx :t :_ |
		| su |
		su := xt unify: t env: env fast: mono.
		su isNil
			ifFalse: [{ su . idx . qPat }]
			ifTrue:  [ nil ]
		]) withoutNils
]

{ #category : #'as yet unclassified' }
QCluster class >> instCands: ho _: aSEnvOfSort [
"
instCands :: Bool -> F.SEnv F.Sort -> [(F.Sort, [F.Symbol])]
             ho      env
"
	| xts txs tyss |
	xts := aSEnvOfSort associations.
	txs := xts collect: #reverse.
	tyss := txs groupAssociations.
	^ho
		ifTrue: [ tyss ]
		ifFalse: [ tyss selectByKey: [ :ty | ty functionSort isNil ] ]
]

{ #category : #'as yet unclassified' }
QCluster class >> instKSig: ho _: env _: v _: t _: qsig [
"
instKSig :: Bool -> F.SEnv F.Sort -> F.Symbol -> F.Sort -> QCSig -> [[F.Symbol]] 
            ho      env              v           t         qsig
cf. Solution.hs
"
	| senv qp qps tyss su0_i0_qs0′s |
	qp := qsig first. qps := qsig allButFirst.	
	senv := [ :key | env lookupSEnvWithDistance: key ].
	tyss := (self instCands: ho _: env) associations asArray collectWithIndex: [ :ass :j |
		{ j. ass key. ass value } ].
	su0_i0_qs0′s := self candidatesP: senv _: {{0 . t . {v}}} _: qp.
	^(su0_i0_qs0′s collectTriplesAndCat: [ :su0 :i0 :qs0 |
		| what |
		what := tyss matchP: senv is: { { i0 . qs0 } } qualParams: (qps collect: [ :eachQP | eachQP applyQPP: su0 ]).
		(what >>= [ :ixs |
			| yss |
			yss := QCluster instSymbol: tyss is: ixs reversed allButFirst.
			yss size.
			{ {v}, yss flattened } ])   ])
]

{ #category : #'as yet unclassified' }
QCluster class >> instSymbol: tyss is: i_qp′s [
"
instSymbol :: [(SortIdx, a, [F.Symbol])] -> [(SortIdx, QualPattern)] -> [[F.Symbol]]
              tyss                               i        qp
"
	| m |
	i_qp′s isEmpty ifTrue: [ ^#() ].
	
	m := Dictionary newFromAssociations: (
		tyss collectTriples: [ :i :_ :ys | i -> ys ]
	).
	
	^m instSymbolGo: i_qp′s tyss: tyss
]

{ #category : #'instance creation' }
QCluster class >> mkQCluster: qualifiers [
"
mkQCluster :: [Qualifier] -> QCluster
mkQCluster = Misc.groupMap qualSig
"
	^(qualifiers groupMap: #sig) as: self
]

{ #category : #'as yet unclassified' }
QCluster >> instK: ho env: env v: v t: t [
"
instK :: Bool -> F.SEnv F.Sort -> F.Symbol -> F.Sort -> QCluster    -> Sol.QBind
                                                     ...[Qualifier]... (before 015953ea)
         ho      env              v           t         qc
cf. Solver/Solution.hs
"
	| eQuals |
	eQuals := self associations >>= [ :sig_qs |
		| sig qs xss | sig := sig_qs key. qs := sig_qs value.
		xss := QCluster instKSig: ho _: env _: v _: t _: sig.
		xss >>= [ :xs | qs collect: [ :q | q eQual: xs ] ] ].
	^QBind fromEQuals: eQuals asSet
	
]

{ #category : #'as yet unclassified' }
QCluster >> refineK: ho env: env rft: vtk [
"
refineK :: Bool -> F.SEnv F.Sort -> [F.Qualifier] -> (F.Symbol, F.Sort, F.KVar) -> (F.KVar, Sol.QBind)  -- before 015953eabb6f9
refineK :: Bool -> F.SEnv F.Sort -> QCluster      -> (F.Symbol, F.Sort, F.KVar) -> (F.KVar, Sol.QBind)  -- after  015953eabb6f9
           ho      env              qs               vtk
The body of the function is unchanged.
cf. Solution.hs
"
	| v t k eqs eqs1 |
	v := vtk first.
	t := vtk second.
	k := vtk third.

	eqs := self instK: ho env: env v: v t: t.
	eqs1 := eqs select: [ :thisEQual | thisEQual okInst: env symbol: v sort: t ].
	^k -> eqs1
]
