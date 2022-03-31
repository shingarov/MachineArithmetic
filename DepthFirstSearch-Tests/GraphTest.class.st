Class {
	#name : #GraphTest,
	#superclass : #TestCase,
	#category : #'DepthFirstSearch-Tests'
}

{ #category : #'mock objects' }
GraphTest >> ABtoXYZ [
	"Cycle (AB), cycle (XYZ), connected by an arrow from A to X."
	<gtExample>
	^Graph fromTriples: (OrderedCollection
		with: { $A. #($B $X). 'A'. }
		with: { $B. #($A). 'B'. }
		
		with: { $X. #($Y). 'X'. }
		with: { $Y. #($Z). 'Y'. }
		with: { $Z. #($X). 'Z'. }
	)
]

{ #category : #'mock objects' }
GraphTest >> abc [
	<gtExample>
	^Graph fromTriples: (OrderedCollection
		with: { $a. #($b). 'a'. }
		with: { $b. #($c). 'b'. }
		with: { $c. #().   'c'. }
	)
]

{ #category : #'mock objects' }
GraphTest >> abcd [
	<gtExample>
	^Graph fromEdges: (OrderedCollection
		with: { 'a'. 0. #(1). }
		with: { 'b'. 1. #(2). }
		with: { 'c'. 2. #(0). }
		with: { 'd'. 3. #(1). }
	)
]

{ #category : #'mock objects' }
GraphTest >> acyclicSCC [
	^AcyclicSCC of: 42
]

{ #category : #'mock objects' }
GraphTest >> cyclicSCC [
	^CyclicSCC of: #(1 2 3)
]

{ #category : #'mock objects' }
GraphTest >> edgesABtoXYZ [
	"Cycle (AB), cycle (XYZ), connected by an arrow from A to X."
	<gtExample>
	^LabeledGraph fromEdges: (OrderedCollection
		with: 'A' -> 'B'
		with: 'B' -> 'A'

		with: 'X' -> 'Y'
		with: 'Y' -> 'Z'
		with: 'Z' -> 'X'

		with: 'A' -> 'X'
	)
]

{ #category : #'mock objects' }
GraphTest >> exWiki [
	"Example taken from https://en.wikipedia.org/wiki/Tarjan's_strongly_connected_components_algorithm"
	<gtExample>
	^Graph fromTriples: {
		{ $a. #( $e ). 'a'. }.
		{ $b. #( $a ). 'b'. }.
		{ $c. #( $b $d ). 'c'. }.
		{ $d. #( $c ). 'd'. }.
		{ $e. #( $b ). 'e'. }.
		{ $f. #( $b $e $g ). 'f'. }.
		{ $g. #( $c $f ). 'g'. }.
		{ $h. #( $d $g $h ). 'h'. }.
	}
]

{ #category : #'mock objects' }
GraphTest >> tarjanSIAM [
	"The example graph in Tarjan, SIAM'72, p.158"
	^AdjacencyStructure  fromEdges: {
		1 -> 2.
		2 -> 3.
		2 -> 8.
		3 -> 4.
		3 -> 7.
		4 -> 5.
		5 -> 3.
		5 -> 6.
		7 -> 4.
		7 -> 6.
		8 -> 1.
		8 -> 7.
	}
]

{ #category : #'tests - SCC' }
GraphTest >> testABtoXYZ [
	| scc ab xyz |
	scc := self ABtoXYZ sccNodes trees.
	
	"two SCCs: AB and XYZ"
	self assert: scc size equals: 2.
	
	"XYZ is reachable from AB, but not the other direction,
	 so AB comes before XYZ"
	ab := scc first.
	xyz := scc second.
	
	self assert: ab allNodes asSet equals:  #('A' 'B') asSet.
	self assert: xyz allNodes asSet equals: #('X' 'Y' 'Z') asSet.

]

{ #category : #'tests - simple' }
GraphTest >> testAbX [
	| g |
	g := Graph fromTriples: (OrderedCollection
		with: { $a. #($b). 'a'. }
		with: { $b. #($c). 'b'. } "the out-list references an unspecified node ('c'); these are ignored"
	).
	self assert: (g edgesOutOfVertex: 1) equals: {(1->2)}.
	self assert: (g edgesOutOfVertex: 2) isEmpty.
]

{ #category : #'tests - simple' }
GraphTest >> testAbc [
	self assert: (self abc keyAtVertex: 1) equals: $a.
	self assert: (self abc nodeAtVertex: 1) equals: 'a'.
	self assert: (self abc edgesOutOfVertex: 1) equals: {(1->2)}.
	self assert: (self abc edgesOutOfVertex: 2) equals: {(2->3)}.
	self assert: (self abc edgesOutOfVertex: 3) isEmpty.
]

{ #category : #'tests - simple' }
GraphTest >> testAbcAtVertex [
	self assert: (self abc keyAtVertex: 1) equals: $a.
	self assert: (self abc nodeAtVertex: 1) equals: 'a'.
]

{ #category : #'tests - simple' }
GraphTest >> testAbcEdgesOutOfVertex [
	self assert: (self abc edgesOutOfVertex: 1) equals: {(1->2)}.
	self assert: (self abc edgesOutOfVertex: 2) equals: {(2->3)}.
	self assert: (self abc edgesOutOfVertex: 3) isEmpty.
]

{ #category : #'tests - simple' }
GraphTest >> testAbcIndexForKey [
	self assert: (self abc vertexAtKey: $a) equals: 1
]

{ #category : #'tests - SCC' }
GraphTest >> testAcyclicSccCollect [
	self
		assert: (self acyclicSCC collect: [ :aVertex | aVertex+1 ])
		equals: (AcyclicSCC of: 43)
		
]

{ #category : #'tests - SCC' }
GraphTest >> testAcyclicSccInject [
	self
		assert: (self acyclicSCC inject: #() into: [ :soFar :thisTime | soFar, (Array with: thisTime) ])
		equals: #(42)
]

{ #category : #'tests - SCC' }
GraphTest >> testCyclicSccCollect [
	self
		assert: (self cyclicSCC collect: [ :aVertex | aVertex+1 ])
		equals: (CyclicSCC of: #(2 3 4))
		
]

{ #category : #'tests - SCC' }
GraphTest >> testCyclicSccInject [
	self
		assert: (self cyclicSCC inject: 0 into: [ :soFar :thisTime | soFar+thisTime ])
		equals: 1+2+3
]

{ #category : #'tests - SCC' }
GraphTest >> testDFS [
	self tarjanSIAM dfs: #(1)
]

{ #category : #'tests - simple' }
GraphTest >> testEdges [
	self assert: self abc edges asSet equals: { 1->2. 2->3. } asSet
]

{ #category : #'tests - SCC' }
GraphTest >> testEdgesABtoXYZ [
	| scc ab xyz |
	scc := self edgesABtoXYZ sccNodes trees.
	
	"two SCCs: AB and XYZ"
	self assert: scc size equals: 2.
	
	"XYZ is reachable from AB, but not the other direction,
	 so AB comes before XYZ"
	ab := scc first.
	xyz := scc second.
	
	self assert: ab allNodes asSet equals:  #('A' 'B') asSet.
	self assert: xyz allNodes asSet equals: #('X' 'Y' 'Z') asSet.

]

{ #category : #'tests - SCC' }
GraphTest >> testFlatScc [
	| scc |
	scc := self ABtoXYZ flatScc.
	
	"two SCCs: AB and XYZ"
	self assert: scc size equals: 2.
	self assert: scc first size equals: 2.
	self assert: scc second size equals: 3.

]

{ #category : #'tests - SCC' }
GraphTest >> testFlatSccNodes [
	| scc |
	scc := self ABtoXYZ flatSccNodes.
	
	"two SCCs: AB and XYZ"
	self assert: scc size equals: 2.
	self assert: scc first asSet equals: #('A' 'B') asSet.
	self assert: scc second asSet equals: #('X' 'Y' 'Z') asSet.

]

{ #category : #'tests - simple' }
GraphTest >> testFromDictionary [
	| d g |
	d := Dictionary newFromAssociations: (#(a b c) collect: [ :vert | vert -> Set new ]).
	(d at: #a) add: #b.
	(d at: #b) add: #c.
	g := Graph fromDictionary: d. "a->b->c"
	self assert: g scc trees size equals: 3
]

{ #category : #'tests - simple' }
GraphTest >> testIndegree [
	self assert: (self abc indegreeOf: 1) equals: 0.
	self assert: (self abc indegreeOf: 2) equals: 1.
	self assert: (self abc indegreeOf: 3) equals: 1.

]

{ #category : #'tests - simple' }
GraphTest >> testKeyOrder [
	| triples g |
	triples := { 
		{ 100 . #(1) . 'X'   }.
		{ 101 . #(1) . 'Y'   }.
		{ 1   . #()  . 'One' }.
	 }.
	g := Graph fromTriples: triples.
	
	self assert: (g keyAtVertex: 1) equals: 1.
	self assert: (g keyAtVertex: 2) equals: 100.
	self assert: (g keyAtVertex: 3) equals: 101.

	self assert: (g vertexAtKey: 1  ) equals: 1.
	self assert: (g vertexAtKey: 100) equals: 2.
	self assert: (g vertexAtKey: 101) equals: 3.

	self assert: g edges asSet equals: {2->1. 3->1.} asSet.
	
	self assert: (g nodeAtVertex: 1) equals: 'One'.
	self assert: (g nodeAtVertex: 2) equals: 'X'.
	self assert: (g nodeAtVertex: 3) equals: 'Y'.
	
	self assert: (g vertexForNode: 'One') equals: 1.
	self assert: (g vertexForNode: 'X') equals: 2.
	self assert: (g vertexForNode: 'Y') equals: 3.
	

	self assert: (g edgesOutOfVertex: 1) isEmpty.
	self assert: (g edgesOutOfVertex: 2) asSet equals: {(2->1)} asSet.
	self assert: (g edgesOutOfVertex: 3) asSet equals: {(3->1)} asSet.
]

{ #category : #'tests - simple' }
GraphTest >> testNodeDictionary [
	| d g scc |
	d := Dictionary new
		at: 'A' put: (Set with: 'B');
		at: 'B' put: (Set with: 'A' with: 'X');
		at: 'X' put: (Set with: 'Y');
		at: 'Y' put: (Set with: 'Z');
		at: 'Z' put: (Set with: 'X');
		yourself.
	g := LabeledGraph fromNodeDictionary: d.
	scc := g sccNodes.
	self assert: scc trees size equals: 2.
	self assert: scc trees first allNodes asSet equals: #('A' 'B') asSet.
	self assert: scc trees second allNodes asSet equals: #('X' 'Y' 'Z') asSet.
]

{ #category : #'tests - simple' }
GraphTest >> testNodes [
	| nodes |
	nodes := self ABtoXYZ nodes.
	self assert:  nodes asSet equals: #('A' 'B' 'X' 'Y' 'Z') asSet.

]

{ #category : #'tests - simple' }
GraphTest >> testOutdegree [
	self assert: (self abc outdegreeOf: 1) equals: 1.
	self assert: (self abc outdegreeOf: 2) equals: 1.
	self assert: (self abc outdegreeOf: 3) equals: 0.

]

{ #category : #'tests - succ/pred' }
GraphTest >> testPreds [
	self assert: (self edgesABtoXYZ immediatePredecessorsOf: 'X') equals: #('A' 'Z') asSet
]

{ #category : #'tests - SCC' }
GraphTest >> testRanks [
	| ranks_sccs ranks sccs |
	ranks_sccs := self ABtoXYZ nodeRanks.
	ranks := ranks_sccs first.
	sccs := ranks_sccs second.
	self assert: (ranks at: 'A') equals: 1.
	self assert: (ranks at: 'B') equals: 1.
	self assert: (ranks at: 'X') equals: 2.
	self assert: (ranks at: 'Y') equals: 2.
	self assert: (ranks at: 'Z') equals: 2.

]

{ #category : #'tests - simple' }
GraphTest >> testReverse [
	| reversed |
	reversed := self abc reversed.
	self assert: (reversed keyAtVertex: 1) equals: $a.
	self assert: (reversed nodeAtVertex: 1) equals: 'a'.
	self assert: (reversed edgesOutOfVertex: 3) asSet equals: {(3->2)} asSet.
	self assert: (reversed edgesOutOfVertex: 2) asSet equals: {(2->1)} asSet.
	self assert: (reversed edgesOutOfVertex: 1) isEmpty.
]

{ #category : #'tests - SCC' }
GraphTest >> testSimpleForkDFS [
	| g dfsForest |
	g := Graph basicNew initializeShapeFromAssocs: {
		1 -> 2.
		1 -> 3.
		3 -> 1.
	} nVertices: 3.
	dfsForest := g dfs: #(1).
	self assert: dfsForest trees size equals: 1.
	self assert: dfsForest trees first root equals: 1.
]

{ #category : #'mock objects' }
GraphTest >> testSlice [
	| es slice |
	es := OrderedCollection
		with: { 100. #(200). 100. }
		with: { 200. #(100 300).    200. }
		
		with: { 300. #(400). 300. }
		with: { 400. #(500). 400. }
		with: { 500. #(300). 500. }.
	slice := #(200 300) asSet sliceEdges: es.
	self assert: slice size equals: 2
]

{ #category : #'tests - SCC' }
GraphTest >> testStrongConnect1 [
	| g sccs |
	g := AdjacencyStructure fromEdges: { 1->2. }.
	sccs := g strongConnect.
	self assert: sccs trees size equals: 2.
	sccs trees do: [ :scc | self assert: scc subtrees isEmpty ]
]

{ #category : #'tests - SCC' }
GraphTest >> testStrongConnect2 [
	| g sccs |
	g := AdjacencyStructure fromEdges: { 1->2. 2->1. }.
	sccs := g strongConnect.
	self assert: sccs trees size equals: 1.
	self deny: sccs trees anyOne subtrees isEmpty
]

{ #category : #'tests - SCC' }
GraphTest >> testStrongConnect3 [
	| g sccs |
	g := AdjacencyStructure fromEdges: {
		1->2. 2->1.
		4->5. 5->3. 3->4.
		6->7. 7->8. 8->6.
		4->1.
		2->6.
	}.
	sccs := g strongConnect.
	self assert: sccs trees size equals: 3.
]

{ #category : #'tests - SCC' }
GraphTest >> testStrongConnectTarjan [
	| sccs |
	sccs := self tarjanSIAM strongConnect.
	self assert: sccs trees size equals: 3

]

{ #category : #'tests - succ/pred' }
GraphTest >> testSuccs [
	self assert: (self edgesABtoXYZ immediateSuccessorsOf: 'A') equals: #('B' 'X') asSet
]

{ #category : #'tests - SCC' }
GraphTest >> testTopSort [
	| g ts |
	g := Graph fromTriples: (OrderedCollection 
		with: { $a. #($b). 'a'. }
		with: { $b. #($c $d). 'b'. }
		with: { $c. #(). 'c'. }
		with: { $d. #(). 'd'. }
	).
	ts := g topologicalSortKeys.
	self assert: ts size equals: 4.
	self assert: ts first equals: $a.
	self assert: ts second equals: $b.
]

{ #category : #'tests - simple' }
GraphTest >> testVertices [
	self assert: self abc vertices size equals: 3.
	self assert: (self abc vertices includes: 1).
	self deny:   (self abc vertices includes: 0).
]

{ #category : #'tests - SCC' }
GraphTest >> testWiki [
	| sccs |
	sccs := self exWiki sccNodes.
	self assert: sccs trees size equals: 4.
	self assert: sccs trees first allNodes asBag equals: #('h') asBag.
	self assert: sccs trees last  allNodes asBag equals: #('a' 'b' 'e') asBag.
]
