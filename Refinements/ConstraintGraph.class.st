"
Cf. Graph/Types.hs : data CGraph
  { gEdges :: [DepEdge]
    -- | Maps a constraint id to an index identifying the strongly connected
    -- component to which it belongs.
    -- The scc indices correspond with a topological ordering of the sccs.
  , gRanks :: !(F.CMap Int)
    -- | Tells for each constraint C, which constraints read any kvars that
    -- C writes.
    --
    -- This is redundant with 'gEdges', so both fields need to express the
    -- exact same dependencies.
  , gSucc  :: !(F.CMap [F.SubcId])
    -- | Amount of strongly connected components
  , gSccs  :: !Int
  }

Notes:
A (CMap α) is a HashMap from SubcId to α; cf. Solutions.hs.

"
Class {
	#name : #ConstraintGraph,
	#superclass : #Object,
	#instVars : [
		'edges',
		'ranks',
		'succ',
		'nSccs'
	],
	#category : #Refinements
}

{ #category : #'as yet unclassified' }
ConstraintGraph class >> cSuccM: es [
	"cf. Deps.hs
	[CEdge -> (Dict id->[id]).
	Answer the Dictionary which tells for each coonstraint writing a kvar
  -- which constraints are reading the kvar." 
	| iWrites kReads kRdBy |
	iWrites := (es select:  [ :e | e key isCstr and: [e value isKVar]] thenCollect: [ :anEdge | anEdge key id -> anEdge value kvar ]) groupAssociations.
	kReads :=  (es select:  [ :e | e key isKVar and: [e value isCstr]] thenCollect: [ :anEdge | anEdge key kvar -> anEdge value id ]) groupAssociations.
	kRdBy := [ :k | kReads at: k ifAbsent: [Set new] ].
	^iWrites collect: [ :kvs | (kvs collectAndCat: kRdBy) asSet asArray sorted ]
]

{ #category : #'instance creation' }
ConstraintGraph class >> fromCEdges: cs [
	"cf. Deps.hs:cGraphCE"
	| next cstrIds es g outRs_sccs |
	next := self cSuccM: cs.
	cstrIds := ((cs collect: #key) select: #isCstr) collect: #id.
	es := cstrIds collect: [ :i |
		{ i . next at: i ifAbsent: #() . i } ]. "yes, I know, duplicates, also in LH"
	g := Graph fromTriples: es.
	outRs_sccs := g nodeRanks.
	^self basicNew 
		edges: es;
		ranks: outRs_sccs first;
		succ: next;
		nSccs: outRs_sccs last size;
		yourself
]

{ #category : #accessing }
ConstraintGraph >> edges [
	^ edges
]

{ #category : #accessing }
ConstraintGraph >> edges: anObject [
	edges := anObject
]

{ #category : #accessing }
ConstraintGraph >> nSccs [
	^ nSccs
]

{ #category : #accessing }
ConstraintGraph >> nSccs: anObject [
	nSccs := anObject
]

{ #category : #accessing }
ConstraintGraph >> ranks [
	^ ranks
]

{ #category : #accessing }
ConstraintGraph >> ranks: anObject [
	ranks := anObject
]

{ #category : #accessing }
ConstraintGraph >> succ [
	^ succ
]

{ #category : #accessing }
ConstraintGraph >> succ: anObject [
	succ := anObject
]
