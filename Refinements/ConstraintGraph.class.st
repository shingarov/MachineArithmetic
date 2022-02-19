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
	| ik kj iWrites kReads kRdBy |
	ik := es select: [ :e | e key isCstr and: [e value isKVar] ].
	
	'abbcdddeea' group .
	
	self shouldBeImplemented.
]

{ #category : #'instance creation' }
ConstraintGraph class >> fromCEdges: cs [
	"cf. Deps.hs:cGraphCE"
	| next cstrIds |
	next := self cSuccM: cs.
	cstrIds := ((cs collect: #key) select: #isCstr) collect: #id.
	
	
self shouldBeImplemented 
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
