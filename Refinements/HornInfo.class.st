"
cm       :: !(M.HashMap SubcId (c a))  -- ^ cst id |-> Horn Constraint
ws       :: !(M.HashMap KVar (WfC a))  -- ^ Kvar  |-> WfC defining its scope/args
bs       :: !BindEnv                   -- ^ Bind  |-> (Symbol, SortedReft)
ebinds   :: ![BindId]                  -- ^ Subset of existential binders
gLits    :: !(SEnv Sort)               -- ^ Global Constant symbols
dLits    :: !(SEnv Sort)               -- ^ Distinct Constant symbols
kuts     :: !Kuts                      -- ^ Set of KVars *not* to eliminate
quals    :: ![Qualifier]               -- ^ Abstract domain
bindInfo :: !(M.HashMap BindId a)      -- ^ Metadata about binders
ddecls   :: ![DataDecl]                -- ^ User-defined data declarations
hoInfo   :: !HOInfo                    -- ^ Higher Order info
asserts  :: ![Triggered Expr]          -- ^ TODO: what is this?
ae       :: AxiomEnv                   -- ^ Information about reflected function defs

"
Class {
	#name : #HornInfo,
	#superclass : #Object,
	#instVars : [
		'cm',
		'bs',
		'ebinds',
		'ws',
		'quals',
		'gLits',
		'dLits',
		'kuts',
		'ae',
		'ddecls',
		'options'
	],
	#category : #Refinements
}

{ #category : #'instance creation' }
HornInfo class >> fromQuery: aHornQuery [ 
	^self basicNew initializeFrom: aHornQuery
]

{ #category : #elimination }
HornInfo class >> graphElim: edges ks: nonKutVs ebs: ebs [
	"Eliminate a KVar k by replacing every 'path'

          ki -> ci -> k -> c

      with an edge

          ki ------------> c
	Answer the resulting sequence of CEdges."
	nonKutVs isEmpty ifFalse: [ self shouldBeImplemented ].
	ebs isEmpty ifFalse: [ self shouldBeImplemented ].
	^edges
]

{ #category : #accessing }
HornInfo >> bs [
	^bs
]

{ #category : #accessing }
HornInfo >> bs: newBs [
	bs := newBs.
	^self
]

{ #category : #accessing }
HornInfo >> cm [
	^cm
]

{ #category : #accessing }
HornInfo >> cm: newCm [
	cm := newCm
]

{ #category : #'as yet unclassified' }
HornInfo >> constraintGraph [
	"cf. cGraph in Deps.hs"
	| next es outRs_sccs |
	next := self kvSucc.
	es := cm keys collect: [ :i | {i . next at: i ifAbsent: [Set new]. i} ].
	outRs_sccs := (Graph fromTriples: es) nodeRanks.
	^ConstraintGraph new
		edges: es;
		ranks: outRs_sccs first;
		succ: next;
		nSccs: outRs_sccs last size;
		yourself
]

{ #category : #'as yet unclassified' }
HornInfo >> edgeDeps: cEdges [
	"cf. Deps.hs:edgeDeps"
	^Elims new "BOGUS"
		depCuts: Set new;
		depNonCuts: Set new;
		yourself 
]

{ #category : #elimination }
HornInfo >> elimDeps: edges nonKutVs: setOfKVars ebs: setOfSymbols [
	"Cf. Deps.hs"
	| es1 |
	es1 := self class graphElim: edges ks: setOfKVars ebs: setOfSymbols.
	^self graphDeps: es1
]

{ #category : #'as yet unclassified' }
HornInfo >> elimVars [
	"Compute Dependencies and Cuts.
	 Answer the association, [CEdge] -> (Elims KVar)."
	| es ds |
	es := self kvEdges.
	ds := self edgeDeps: es.
	^es->ds
]

{ #category : #elimination }
HornInfo >> graphDeps: edges [
	"cf. Deps.hs:graphDeps"
	
	| cg es |
	cg := ConstraintGraph fromCEdges: edges.
	es := cg" "edges.
	^CDeps new
]

{ #category : #GT }
HornInfo >> gtInspectorBindsIn: composite [
	<gtInspectorPresentationOrder: 20>
	bs isNil ifTrue: [ ^nil ].
	^bs gtInspectorBindsIn: composite
]

{ #category : #GT }
HornInfo >> gtInspectorConstraintsIn: composite [
	<gtInspectorPresentationOrder: 21>
	cm isNil ifTrue: [ ^nil ].
	^ composite fastTable
		title: 'Constraints';
		display: [ cm associations ];
		column: 'Key' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Constraint' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ];
		send: [ :selection | selection value ]
]

{ #category : #GT }
HornInfo >> gtInspectorQualifsIn: composite [
	<gtInspectorPresentationOrder: 22>
	quals isNil ifTrue: [ ^nil ].
	^ composite fastList
		title: 'Qualif';
		display: [ quals asOrderedCollection ]
]

{ #category : #GT }
HornInfo >> gtInspectorWfsIn: composite [
	<gtInspectorPresentationOrder: 23>
	cm isNil ifTrue: [ ^nil ].
	^ composite fastTable
		title: 'WfC';
		display: [ ws associations ];
		column: 'Key' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each key ];
		column: 'Constraint' evaluated: [ :each | GTObjectPrinter asTruncatedTextFrom: each value ];
		send: [ :selection | selection value ]
]

{ #category : #'private - initialization' }
HornInfo >> initializeFrom: aHornQuery [
	"cf. Horn/Info.hs:hornFInfo"
	| be1_kve be2_ebs_cs |
	self initializeMempty.
	be1_kve := HornQuery hornWfs: BindEnv empty _: aHornQuery vars.
	be2_ebs_cs := HornQuery hornSubCs_be: be1_kve key kve: be1_kve value c: aHornQuery qCstr first.
	cm := be2_ebs_cs third.
	bs := be2_ebs_cs first.
	ebinds := be2_ebs_cs second.
	quals := aHornQuery qualifiers.
	ws := be1_kve value "Dictionary of varName -> KVInfo"
		collect: [ :kvInfo | kvInfo kvWfC ].

" BOGUS:
    , F.gLits     = F.fromMapSEnv $ H.qCon q
    , F.dLits     = F.fromMapSEnv $ H.qDis q
    , F.ae        = axEnv cfg q cs"
  options := aHornQuery options.
	^self
]

{ #category : #'private - initialization' }
HornInfo >> initializeMempty [
	"cf. instance Monoid (GInfo c a) in Constraints.hs.
	The constructor then replaces the fields (cf. Horn/Info.hs:hornFInfo);
	we don't do this, instead we only initialize those fields
	which will not be replaced in the constructor."
	kuts := Kuts new

]

{ #category : #'as yet unclassified' }
HornInfo >> kvEdges [
	"cf. Deps.hs
	kvEdges :: (F.TaggedC c a) => F.GInfo c a -> [CEdge]"
	| ks cs selfes |
	ks := self kVars asArray.
	cs := cm values.
	selfes := (cs collect: [ :c | (CstrVertex id: c id)->(CstrVertex id: c id) ]),
		(ks collect: [ :k | (KVarVertex kvar: k)->(DKVarVertex kvar: k) ]),
		(ks collect: [ :k | (DKVarVertex kvar: k)->(DKVarVertex kvar: k) ]).
	^selfes,
	(cs collectAndCat: [ :c | (c edges: bs) asArray ])
	"BOGUS!!! ebindEdges!!!!!" "++ concatMap (ebindEdges ebs bs) cs)"
]

{ #category : #'as yet unclassified' }
HornInfo >> kvReadBy [
	^(cm associations inject: Set new into: [ :accum :i_ci |
		| i ci |
		i := i_ci key.
		ci := i_ci value.		
		(bs envKVars: ci) do: [ :k | accum add: k->i ].
		accum]) groupAssociations

]

{ #category : #'as yet unclassified' }
HornInfo >> kvSucc [
	| rdBy |
	rdBy := self kvReadBy.
	^self kvWriteBy collect: [ :ks | ks collectAndCat: [ :k | rdBy at: k ifAbsent: [Set new] ] ]
]

{ #category : #'as yet unclassified' }
HornInfo >> kvWriteBy [
	^cm collect: [ :aSubC | aSubC crhs kvarsExpr ]
]

{ #category : #'as yet unclassified' }
HornInfo >> mkSlice [
	| es g g1 v2i i2v |
	es := self constraintGraph edges.
	g := Graph fromTriples: es.
	g1 := g reversed.
	v2i := [ :v | g1 nodeAtVertex: v ]. "'nodes' here are constraintIds"
	i2v := [ :i | g1 vertexForNode: i ].
	^self mkSlice_: g1 es: es v2i: v2i i2v: i2v
]

{ #category : #'as yet unclassified' }
HornInfo >> mkSlice_: g1 es: es v2i: v2i i2v: i2v [
	| concCs rootVs reachVs kvarCs |
	concCs := (cm select: #isTarget) keys. "ids of target constraints"
	rootVs := concCs collect: i2v.
	reachVs := ((g1 dfs: rootVs) trees collect: #allNodes)
		inject: Set new
		into: [ :soFar :thisTime | soFar addAll: thisTime; yourself ] .
	kvarCs := reachVs collect: v2i.
	^Slice new
		kVarCs: kvarCs;
		concCs: concCs;
		edges: (kvarCs sliceEdges: es);
		yourself 
]

{ #category : #accessing }
HornInfo >> quals [
	^quals
]

{ #category : #'as yet unclassified' }
HornInfo >> slice [
	"Compute constraints that transitively affect target constraints,
	 and delete everything else from SInfo.
	 Cf. Deps.hs."
	| sl ks is cm1 ws1 |
	options yourself "noslice". "TODO"
	sl := self mkSlice.
	ks := self sliceKVars: sl. "a set of KVars"
	is := sl kVarCs asSet union: sl concCs asSet.
	cm1 := cm selectByKey: [ :cstrId | is includes: cstrId ].
	ws1 := ws selectByKey: [ :kvar | ks includes: kvar ].
	"!!!DESTRUCTIVE!!!"
	cm := cm1.
	ws := ws1.
	^self
]

{ #category : #'as yet unclassified' }
HornInfo >> sliceKVars: sl [
	| union cs |
	union := sl kVarCs asSet union: sl concCs asSet.
	cs := union collect: [ :anId | cm at: anId ].
	^(cs collectAndCat: [ :c | bs subcKVars: c ]) asSet
]

{ #category : #'as yet unclassified' }
HornInfo >> wfc: k [ 
	^ws at: k
]
