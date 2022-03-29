"
I encode the shape of a finite, directed graph with integer vertices as an adjacency structure,
associating each vertex of the graph with its adjacency list.
"
Class {
	#name : #AdjacencyStructure,
	#superclass : #Object,
	#instVars : [
		'shape'
	],
	#category : #DepthFirstSearch
}

{ #category : #'instance creation' }
AdjacencyStructure class >> fromEdges: collectionOfAssocs [
	| vertices |
	vertices := Set new.
	collectionOfAssocs do: [ :anEdge |
		vertices add: anEdge key.
		vertices add: anEdge value ].
	^self fromEdges: collectionOfAssocs nVertices: vertices max
]

{ #category : #'instance creation' }
AdjacencyStructure class >> fromEdges: collectionOfAssocs nVertices: n [
	^self basicNew initializeShapeFromAssocs: collectionOfAssocs nVertices: n
]

{ #category : #'as yet unclassified' }
AdjacencyStructure >> asTreeGrowingFrom: root [ 
	^Tree root: root 
		subtrees: ((shape at: root) collect: [ :child | self asTreeGrowingFrom: child ])
]

{ #category : #'as yet unclassified' }
AdjacencyStructure >> childrenOf: aVertex do: aBlock [
	(shape at: aVertex) do: aBlock
]

{ #category : #DFS }
AdjacencyStructure >> components [
	"Answer the Forest representing the connected components of a graph.
	 Two vertices are connected if there is a path between them, traversing edges in either direction."
	self shouldBeImplemented
]

{ #category : #DFS }
AdjacencyStructure >> dff [
	"Answer a spanning forest of the graph,
	 obtained from a depth-first search of the graph starting from each vertex in an unspecified order."
	^self dfs: self vertices

]

{ #category : #DFS }
AdjacencyStructure >> dfs: vertices [
	"Answer a spanning forest of the part of the graph reachable from the listed
	 vertices, obtained from a depth-first search of the graph starting at
	 each of the listed vertices in order."
	^self dfs: vertices alreadyVisited: Set new
]

{ #category : #DFS }
AdjacencyStructure >> dfs: vertices alreadyVisited: vis [
	"Answer a spanning forest of the part of the graph reachable from the listed
	 vertices, obtained from a depth-first search of the graph starting at
	 each of the listed vertices in order."
	^Forest of: ((vertices collect: [ :vertex | self generate: vertex alreadyVisited: vis ]) reject: #isNil)

]

{ #category : #Dijkstra }
AdjacencyStructure >> distanceFrom: source to: target [
	^ (Dijkstra graph: self source: source) distanceTo: target
]

{ #category : #Dijkstra }
AdjacencyStructure >> eccentricityOf: anObject [
	^ (Dijkstra graph: self source: anObject) eccentricity
]

{ #category : #DFS }
AdjacencyStructure >> flatScc [
	| forest |
	forest := self scc.
	^forest trees collect: [ :eachTree | eachTree allNodes ]
]

{ #category : #DFS }
AdjacencyStructure >> generate: vertex alreadyVisited: vis [
	| children |
	(vis includes: vertex) ifTrue: [ ^nil ].
	vis add: vertex.
	children := (shape at: vertex) collect: [ :v | self generate: v alreadyVisited: vis ] thenReject: #isNil.
	^Tree root: vertex subtrees: children
]

{ #category : #'private - initialization' }
AdjacencyStructure >> initializeShapeFromAssocs: edges nVertices: n [
	shape := Array new: n.
	1 to: n do: [ :j | shape at: j put: Set new ].
	edges do: [ :from_to | (shape at: from_to key) add: from_to value ]
]

{ #category : #'private - initialization' }
AdjacencyStructure >> initializeShapeFromAssocs: edges within: anInterval [
self shouldBeImplemented.
	shape := Dictionary new.
	anInterval do: [ :vertex | shape at: vertex put: Set new ].
	edges do: [ :from_to | (shape at: from_to key) add: from_to value ]
]

{ #category : #DFS }
AdjacencyStructure >> mentionsItself: v [
	^(shape at: v) includes: v
]

{ #category : #accessing }
AdjacencyStructure >> numVertices [
	^shape size
]

{ #category : #DFS }
AdjacencyStructure >> scc [
	"First identify strongly connected components,
	 then perform a topological sort on these components.
	 Answer the Forest representing the receiver's strongly connected components, topologically sorted."
	| sccs node_component scc_graph sortedSCCs |
	sccs := self strongConnect.
	
	node_component := Dictionary new.
	"Map each vertex to the SCC it belongs to.
	 A bit of terminological confusion: 'node' here means node of a tree."
	sccs trees collect: [ :eachSCC | eachSCC allNodes do: [ :eachNode | node_component at: eachNode put: eachSCC ] ].
	
	scc_graph := Dictionary newFromAssociations: (sccs trees asArray collect: [ :eachSCC | eachSCC -> Set new ]).
	1 to: shape size do: [ :eachVertex |
		| thisSCC |
		thisSCC := node_component at: eachVertex.
		(shape at: eachVertex) do: [ :successor |
			| successorSCC |
			successorSCC := node_component at: successor.
			successorSCC = thisSCC ifFalse: [ (scc_graph at: thisSCC) add: successorSCC ]]].
	"Now scc_graph is a dictionary going from each scc to the set of its topological successors"
	sortedSCCs := (LabeledGraph fromNodeDictionary: scc_graph) topologicalSortNodes.
	^Forest of: sortedSCCs
]

{ #category : #Dijkstra }
AdjacencyStructure >> shortestPathFrom: source to: target [
	^ (Dijkstra graph: self source: source) shortestPathTo: target
]

{ #category : #DFS }
AdjacencyStructure >> strongConnect [
	^(TarjanSearch of: shape) strongConnect
]

{ #category : #DFS }
AdjacencyStructure >> strongConnect: v [
	^(TarjanSearch of: shape) strongConnect: v
]

{ #category : #DFS }
AdjacencyStructure >> topologicalSort [
	"Sort the receiver topologically.
	 Answer the sequence of vertices.
	 The order is partially specified by the condition that
	 a vertex i precedes j whenever j is reachable from i but not vice versa."
	| count ready result |
	count := Array new: shape size withAll: 0.
	shape doWithIndex: [ :successors :j |
		successors do: [ :eachSuccessor | count at: eachSuccessor put: (count at: eachSuccessor)+1 ] ].
	ready := (Interval from: 1 to: shape size) select: [ :node | (count at: node) = 0 ].
	ready := ready asOrderedCollection.
	result := OrderedCollection new.
	[ready isEmpty] whileFalse: [ 
		| node |
		node := ready removeLast.
		result addLast: node.
		(shape at: node) do: [ :eachSuccessor |
			count at: eachSuccessor put: (count at: eachSuccessor)-1.
			(count at: eachSuccessor) = 0 ifTrue: [ ready addLast: eachSuccessor ]]].
	^result
]

{ #category : #accessing }
AdjacencyStructure >> vertices [
	^Interval from: 1 to: self numVertices
]
