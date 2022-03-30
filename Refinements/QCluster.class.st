"
I wrap around a dictionary compartmentalizing a bunch of Qualifiers by their sig.
"
Class {
	#name : #QCluster,
	#superclass : #Object,
	#instVars : [
		'theDict'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
QCluster class >> candidatesP: env _: tyss _: x [
"-> [(So.TVSubst, SortIdx, QualPattern)]"
	| xt qPat mono |
	xt := x sort.
	qPat := x pattern.
	mono := xt isMono.
	^tyss collect: [ :idx_t__ |
		| idx t su |
		idx := idx_t__ first.
		t := idx_t__ second.
		su := Subst mkSubst: #().   "BOGUS! (self unifyFast: mono f: env t1: xt t2: t) maybeToList."
		{ su . idx . qPat } ]
]

{ #category : #'as yet unclassified' }
QCluster class >> instCands: ho _: aSEnvOfSort [
"
instCands :: Bool -> F.SEnv F.Sort -> [(F.Sort, [F.Symbol])]
"
	| xts txs tyss |
	xts := aSEnvOfSort associations.
	txs := xts collect: #reverse.
	tyss := txs groupAssociations.
	ho ifTrue: [ self shouldBeImplemented ]. "filter away function sorts"
	^tyss
]

{ #category : #'as yet unclassified' }
QCluster class >> instKSig: ho _: env _: v _: t _: qsig [
"
ho :: Bool
env :: S.SEnv F.Sort
v :: F.Symbol
t :: F.Sort
qsig :: QCSig -- type QCSig = [F.QualParam]
-> [[Symbol]] "
	"cf. Solution.hs"
	| senv qp qps tyss su0_i0_qs0s |
	qp := qsig first. qps := qsig allButFirst.
	
	tyss := (self instCands: ho _: env) associations asArray collectWithIndex: [ :ass :j |
		{ j. ass key. ass value } ].

	"senv := [ :key | env lookupSEnvWithDistance: key ].
	su0_i0_qs0s := self candidatesP: senv _: {{0 . t . {v}}} _: qp.
	su0_i0_qs0s collect: [ :su0_i0_qs0 |
		| su0 i0 qs0 |
		su0 := su0_i0_qs0 first.
		i0  := su0_i0_qs0 second.
		qs0 := su0_i0_qs0 third.
		#BOGUS
		  ]."
qps isEmpty ifFalse: [ ^{{v . 'lq_kargßnnf_argººk_ºº1ºº1ººk_ºº1'}} ].
	^{{v} "append ys" }
]

{ #category : #'instance creation' }
QCluster class >> of: qualifiers [
	"cf. mkQCluster"
	^self basicNew
		theDict: (qualifiers groupedBy: #sig);
		yourself
]

{ #category : #'as yet unclassified' }
QCluster class >> unifyFast: aBoolean f: f t1: t1 t2: t2 [
"
Fast Unification; `unifyFast True` is just equality
"
	aBoolean ifFalse: [ self shouldBeImplemented ].
	^t1=t2
		ifTrue: [#()]
		ifFalse: [nil]
]

{ #category : #'as yet unclassified' }
QCluster >> instK: ho env: env v: v t: t [
"-> Sol.QBind"
	"cf. Solver/Solution.hs"
	| eQuals |
	eQuals := theDict associations collectAndCat: [ :sig_qs |
		| sig qs xss |
		sig := sig_qs key.
		qs := sig_qs value.
		xss := self class instKSig: ho _: env _: v _: t _: sig.
		xss collectAndCat: [ :xs | qs collect: [ :q | q eQual: xs ] ] ].
	^QBind fromEQuals: eQuals asSet
	
]

{ #category : #'as yet unclassified' }
QCluster >> refineK: ho env: env rft: vtk [
"cf. Solution.hs"
	| v t k eqs eqs1 |
	v := vtk first.
	t := vtk second.
	k := vtk third.
	eqs := self instK: ho env: env v: v t: t.
	eqs1 := eqs "qbFilter" "BOGUS".
	^k -> eqs1
]

{ #category : #accessing }
QCluster >> theDict [
	^ theDict
]

{ #category : #accessing }
QCluster >> theDict: anObject [
	theDict := anObject
]
