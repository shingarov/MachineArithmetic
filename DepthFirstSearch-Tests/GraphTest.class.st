Class {
	#name : #GraphTest,
	#superclass : #TestCase,
	#category : #'DepthFirstSearch-Tests'
}

{ #category : #'mock objects' }
GraphTest >> abc [
	<gtExample>
	^Graph fromEdges: (OrderedCollection
		with: { 'a'. $a. #($b). }
		with: { 'b'. $b. #($c). }
		with: { 'c'. $c. #(). }
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
GraphTest >> exWiki [
	"Example taken from https://en.wikipedia.org/wiki/Tarjan's_strongly_connected_components_algorithm"
	<gtExample>
	^Graph fromEdges: {
		{ 'a'. $a. #( $e ). }.
		{ 'b'. $b. #( $a ). }.
		{ 'c'. $c. #( $b $d ). }.
		{ 'd'. $d. #( $c ). }.
		{ 'e'. $e. #( $b ). }.
		{ 'f'. $f. #( $b $e $g ). }.
		{ 'g'. $g. #( $f ). }.
		{ 'h'. $h. #( $d $g $h ). }.
	}
]

{ #category : #'tests - simple' }
GraphTest >> testAbX [
	| g |
	g := Graph fromEdges: (OrderedCollection
		with: { 'a'. $a. #($b). }
		with: { 'b'. $b. #($c). } "the out-list references an unspecified node ('c'); these are ignored"
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
	self assert: (self abc indexFor: $a) equals: 1
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
	| g |
	g := Graph basicNew initializeShapeFromAssocs: {
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
	} within: (1 to: 8).
	g dfs: #(1).
]

{ #category : #'tests - simple' }
GraphTest >> testEdges [
	self assert: self abc edges asSet equals: { 1->2. 2->3. } asSet
]

{ #category : #'tests - simple' }
GraphTest >> testIndegree [
	self assert: (self abc indegreeOf: 1) equals: 0.
	self assert: (self abc indegreeOf: 2) equals: 1.
	self assert: (self abc indegreeOf: 3) equals: 1.

]

{ #category : #'tests - simple' }
GraphTest >> testIntervalToGraph [
	| g |
	g := (1 to: 3) graphWithEdges: { 1->2. 2->3. }.
	self assert: (g edgesOutOfVertex: 1) asSet equals: {(1->2)} asSet.
	self assert: (g edgesOutOfVertex: 2) asSet equals: {(2->3)} asSet.
	self assert: (g edgesOutOfVertex: 3) isEmpty.
]

{ #category : #'tests - simple' }
GraphTest >> testOutdegree [
	self assert: (self abc outdegreeOf: 1) equals: 1.
	self assert: (self abc outdegreeOf: 2) equals: 1.
	self assert: (self abc outdegreeOf: 3) equals: 0.

]

{ #category : #'tests - simple' }
GraphTest >> testReverse [
	self assert: (self abc reversed keyAtVertex: 1) equals: $a.
	self assert: (self abc reversed nodeAtVertex: 1) equals: 'a'.
	self assert: (self abc reversed edgesOutOfVertex: 3) asSet equals: {(3->2)} asSet.
	self assert: (self abc reversed edgesOutOfVertex: 2) asSet equals: {(2->1)} asSet.
	self assert: (self abc reversed edgesOutOfVertex: 1) isEmpty.
]

{ #category : #'tests - SCC' }
GraphTest >> testSimpleForkDFS [
	| g dfsForest |
	g := Graph basicNew initializeShapeFromAssocs: {
		1 -> 2.
		1 -> 3.
		3 -> 1.
	} within: (1 to: 3).
	dfsForest := g dfs: #(1).
	self assert: dfsForest trees size equals: 1.
	self assert: dfsForest trees first root equals: 1.
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
	"Tarjan, SIAM'72, p.158"
	| g sccs |
	g := Graph basicNew initializeShapeFromAssocs: {
	} within: (1 to: 8).

	"idiotic but for now..."
	(g instVarNamed: #shape)
		at: 1 put: #(2);
		at: 2 put: #(3 8);
		at: 3 put: #(4 7);
		at: 4 put: #(5);
		at: 5 put: #(3 6);
		at: 7 put: #(4 6);
		at: 8 put: #(1 7).

	"g = buildG (1,8) [ (1,2),
		(2,3), (2,8),
		(3,4), (3,7),
		(4,5),
		(5,3), (5,6),
		(7,4), (7,6),
		(8,1), (8,7) ]
	"
	sccs := g strongConnect.
	self assert: sccs trees size equals: 3

]

{ #category : #'tests - SCC' }
GraphTest >> testTopSort [
	| g ts |
	g := Graph fromEdges: (OrderedCollection 
		with: { 'a'. $a. #($b). }
		with: { 'b'. $b. #($c $d). }
		with: { 'c'. $c. #(). }
		with: { 'd'. $d. #(). }
	).
	ts := g topologicalSort.
	self assert: ts size equals: 4.
	self assert: ts first equals: 'a'.
	self assert: ts second equals: 'b'.
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
	sccs := self exWiki scc.
	self assert: sccs trees size equals: 4.
	self assert: sccs trees first allNodes asBag equals: #('h') asBag.
	self assert: sccs trees last  allNodes asBag equals: #('a' 'b' 'e') asBag.
]
