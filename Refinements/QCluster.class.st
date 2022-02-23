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
		su := Th new.
		{ su . idx . qPat } ]
]

{ #category : #'as yet unclassified' }
QCluster class >> instKSig: ho _: env _: v _: t _: qsig [
"-> [[Symbol]] "
	"cf. Solution.hs"
	| senv qp qps |
	qp := qsig first.
	qps := qsig allButFirst.
	(self candidatesP: senv _: {{0 . t . {v}}} _: qp) collect: [ :su0_i0_qs0 |
		| su0 i0 qs0 |
		su0 := su0_i0_qs0 first.
		i0  := su0_i0_qs0 second.
		qs0 := su0_i0_qs0 third.
		"BOGUS"
		  ].
	^{v} "append ys"
]

{ #category : #'instance creation' }
QCluster class >> of: qualifiers [
	"cf. mkQCluster"
	^self basicNew
		theDict: (qualifiers groupedBy: #sig);
		yourself
]

{ #category : #'as yet unclassified' }
QCluster >> instK: ho env: env v: v t: t [
"-> Sol.QBind"
	"cf. Solver/Solution.hs"
	| eQuals |
env isEmpty ifFalse: [ self shouldBeImplemented "the whole story with SEnv, SESearch etc" ].

	eQuals := theDict associations collectAndCat: [ :sig_qs |
		| sig qs xs |
		sig := sig_qs key.
		qs := sig_qs value.
		xs := self class instKSig: ho _: env _: v _: t _: sig.
		xs collectAndCat: [ :x | qs collect: [ :q | q eQual: xs ] ] ].
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
