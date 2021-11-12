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
		'ae',
		'ddecls'
	],
	#category : #'MachineArithmetic-Refinement'
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
	Answer the resulting collection of CEdges."
	"BOGUS!!!!!!!"
	^#()
]

{ #category : #accessing }
HornInfo >> bs [
	^bs
]

{ #category : #accessing }
HornInfo >> bs: newBs [
	bs := newBs
]

{ #category : #accessing }
HornInfo >> cm [
	^cm
]

{ #category : #accessing }
HornInfo >> cm: newCm [
	cm := newCm
]

{ #category : #elimination }
HornInfo >> elimDeps: edges nonKutVs: setOfKVars ebs: setOfSymbols [
	| es1 |
	es1 := self class graphElim: edges ks: setOfKVars ebs: setOfSymbols.
	^self graphDeps: es1
]

{ #category : #elimination }
HornInfo >> graphDeps: edges [
	"BOGUS!!!!!!!!"
	| cg es |
	cg := CGraph of: edges.
	es := cg "edges".
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

{ #category : #initialization }
HornInfo >> initializeFrom: aHornQuery [ 
	| be1_kve be2_ebs_cs |
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
  
]

{ #category : #'as yet unclassified' }
HornInfo >> kvEdges [
	"BOGUS!!!!!!!!!!!"
	^#()
]

{ #category : #elimination }
HornInfo >> slice [
	"Compute constraints that transitively affect target constraints,
	 and delete everything else from SInfo."
	"BOGUS -- nust implement"
	^self
]
